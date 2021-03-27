﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;
using SaltyShared;
using Newtonsoft.Json;

namespace SaltyClient
{
    internal class VoiceManager : BaseScript
    {
        #region Properties / Fields
        public bool IsEnabled { get; private set; }
        public bool IsConnected { get; private set; }
        private GameInstanceState _pluginState = GameInstanceState.NotInitiated;
        public GameInstanceState PlguinState
        {
            get => this._pluginState;
            set
            {
                this._pluginState = value;

                BaseScript.TriggerEvent(Event.SaltyChat_PluginStateChanged, value);
            }
        }
        public bool IsNuiReady { get; private set; }

        public string TeamSpeakName { get; private set; }
        public Configuration Configuration { get; private set; }

        public VoiceClient[] VoiceClients => this._voiceClients.Values.ToArray();
        private Dictionary<int, VoiceClient> _voiceClients = new Dictionary<int, VoiceClient>();

        public Vector3[] RadioTowers { get; private set; }
        public CitizenFX.Core.UI.Notification RangeNotification { get; set; }

        public string WebSocketAddress { get; private set; } = "lh.saltmine.de:38088";
        public float VoiceRange { get; private set; }
        public string PrimaryRadioChannel { get; private set; }
        public string SecondaryRadioChannel { get; private set; }
        private bool IsUsingMegaphone { get; set; }

        public bool IsMicrophoneMuted { get; private set; }
        public bool IsMicrophoneEnabled { get; private set; }
        public bool IsSoundMuted { get; private set; }
        public bool IsSoundEnabled { get; private set; }

        public float RadioVolume { get; private set; } = 1.0f;
        public bool IsRadioSpeakerEnabled { get; set; }

        public static PlayerList PlayerList { get; private set; }
        #endregion

        #region Delegates
        public delegate float GetVoiceRangeDelegate();
        public delegate string GetRadioChannelDelegate(bool primary);
        public delegate float GetRadioVolumeDelegate();
        public delegate bool GetRadioSpeakerDelegate();
        public delegate int GetPluginStateDelegate();
        #endregion

        #region CTOR
        public VoiceManager()
        {
            // NUI Callbacks
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnConnected);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnDisconnected);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnError);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnMessage);
            API.RegisterNuiCallbackType(NuiEvent.SaltyChat_OnNuiReady);

            // Proximity Getter Exports
            GetVoiceRangeDelegate getVoiceRangeDelegate = new GetVoiceRangeDelegate(this.GetVoiceRange);
            this.Exports.Add("GetVoiceRange", getVoiceRangeDelegate);

            // Radio Getter Exports
            GetRadioChannelDelegate getRadioChannelDelegate = new GetRadioChannelDelegate(this.GetRadioChannel);
            this.Exports.Add("GetRadioChannel", getRadioChannelDelegate);

            GetRadioVolumeDelegate getRadioVolumeDelegate = new GetRadioVolumeDelegate(this.GetRadioVolume);
            this.Exports.Add("GetRadioVolume", getRadioVolumeDelegate);

            GetRadioSpeakerDelegate getRadioSpeakerDelegate = new GetRadioSpeakerDelegate(this.GetRadioSpeaker);
            this.Exports.Add("GetRadioSpeaker", getRadioSpeakerDelegate);

            // Radio Setter Exports
            this.Exports.Add("SetRadioChannel", new Action<string, bool>(this.SetRadioChannel));
            this.Exports.Add("SetRadioVolume", new Action<float>(this.SetRadioVolume));
            this.Exports.Add("SetRadioSpeaker", new Action<bool>(this.SetRadioSpeaker));

            // Misc Exports
            GetPluginStateDelegate getPluginStateDelegate = new GetPluginStateDelegate(this.GetPluginState);
            this.Exports.Add("GetPluginState", getPluginStateDelegate);

            this.Exports.Add("PlaySound", new Action<string, bool, string>(this.PlaySound));

            VoiceManager.PlayerList = this.Players;
        }
        #endregion

        #region Events
        [EventHandler("onClientResourceStop")]
        private void OnResourceStop(string resourceName)
        {
            if (resourceName != API.GetCurrentResourceName())
                return;

            this.IsEnabled = false;
            this.IsConnected = false;

            lock (this._voiceClients)
            {
                this._voiceClients.Clear();
            }

            this.PrimaryRadioChannel = null;
            this.SecondaryRadioChannel = null;
        }
        #endregion

        #region Remote Events (Handling)
        [EventHandler(Event.SaltyChat_Initialize)]
        private void OnInitialize(string teamSpeakName, dynamic towers)
        {
            this.TeamSpeakName = teamSpeakName;

            List<Vector3> towerPositions = new List<Vector3>();

            foreach (dynamic tower in towers)
            {
                towerPositions.Add(new Vector3(tower[0], tower[1], tower[2]));
            }

            this.RadioTowers = towerPositions.ToArray();

            this.IsEnabled = true;

            if (this.IsConnected)
                this.InitializePlugin();
            else if (this.IsNuiReady)
                this.ExecuteCommand("connect", this.WebSocketAddress);
            else
                Debug.WriteLine("[Salty Chat] Got server response, but NUI wasn't ready");

            //VoiceManager.DisplayDebug(true);
        }

        [EventHandler(Event.SaltyChat_SyncClients)]
        private void OnClientSync(string json)
        {
            try
            {
                SaltyShared.VoiceClient[] voiceClients = Newtonsoft.Json.JsonConvert.DeserializeObject<SaltyShared.VoiceClient[]>(json);

                lock (this._voiceClients)
                {
                    this._voiceClients.Clear();

                    foreach (SaltyShared.VoiceClient sharedVoiceClient in voiceClients)
                    {
                        VoiceClient voiceClient = new VoiceClient(
                            sharedVoiceClient.PlayerId,
                            sharedVoiceClient.TeamSpeakName,
                            sharedVoiceClient.VoiceRange,
                            sharedVoiceClient.IsAlive,
                            new CitizenFX.Core.Vector3(
                                sharedVoiceClient.Position.X,
                                sharedVoiceClient.Position.Y,
                                sharedVoiceClient.Position.Z
                            )
                        );

                        this._voiceClients.Add(sharedVoiceClient.PlayerId, voiceClient);
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"SaltyChat_SyncClients: Error while parsing voice clients{Environment.NewLine}{ex.ToString()}");
            }
        }

        [EventHandler(Event.SaltyChat_UpdateClient)]
        private void OnClientUpdate(string json)
        {
            try
            {
                SaltyShared.VoiceClient sharedVoiceClient = Newtonsoft.Json.JsonConvert.DeserializeObject<SaltyShared.VoiceClient>(json);

                VoiceClient voiceClient = new VoiceClient(
                    sharedVoiceClient.PlayerId,
                    sharedVoiceClient.TeamSpeakName,
                    sharedVoiceClient.VoiceRange,
                    sharedVoiceClient.IsAlive,
                    new CitizenFX.Core.Vector3(
                        sharedVoiceClient.Position.X,
                        sharedVoiceClient.Position.Y,
                        sharedVoiceClient.Position.Z
                    )
                );

                lock (this._voiceClients)
                {
                    if (this._voiceClients.ContainsKey(voiceClient.ServerId))
                    {
                        this._voiceClients[voiceClient.ServerId] = voiceClient;
                    }
                    else
                    {
                        this._voiceClients.Add(voiceClient.ServerId, voiceClient);
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"SaltyChat_UpdateClient: Error while parsing voice client{Environment.NewLine}{ex.ToString()}");
            }
        }

        [EventHandler(Event.SaltyChat_UpdateVoiceRange)]
        private void OnClientUpdateVoiceRange(string handle, float voiceRange)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            lock (this._voiceClients)
            {
                if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
                {
                    client.VoiceRange = voiceRange;
                }
            }
        }

        [EventHandler(Event.SaltyChat_UpdateAlive)]
        private void OnClientUpdateAlive(string handle, bool isAlive)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            lock (this._voiceClients)
            {
                if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
                {
                    client.IsAlive = isAlive;
                }
            }
        }

        [EventHandler(Event.SaltyChat_RemoveClient)]
        private void OnClientRemove(string handle)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            lock (this._voiceClients)
            {
                if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
                {
                    this.ExecuteCommand(new PluginCommand(Command.RemovePlayer, this.Configuration.ServerUniqueIdentifier, new PlayerState(client.TeamSpeakName)));

                    this._voiceClients.Remove(serverId);
                }
            }
        }
        #endregion

        #region Remote Events (Phone)
        [EventHandler(Event.SaltyChat_EstablishCall)]
        private void OnEstablishCall(string handle, string positionJson)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
            {
                if (client.DistanceCulled)
                {
                    client.LastPosition = Newtonsoft.Json.JsonConvert.DeserializeObject<CitizenFX.Core.Vector3>(positionJson);
                    client.SendPlayerStateUpdate(this);
                }

                CitizenFX.Core.Vector3 playerPosition = Game.PlayerPed.Position;
                CitizenFX.Core.Vector3 remotePlayerPosition = client.LastPosition;

                int signalDistortion = API.GetZoneScumminess(API.GetZoneAtCoords(playerPosition.X, playerPosition.Y, playerPosition.Z));
                signalDistortion += API.GetZoneScumminess(API.GetZoneAtCoords(remotePlayerPosition.X, remotePlayerPosition.Y, remotePlayerPosition.Z));

                this.ExecuteCommand(
                    new PluginCommand(
                        Command.PhoneCommunicationUpdate,
                        this.Configuration.ServerUniqueIdentifier,
                        new PhoneCommunication(
                            client.TeamSpeakName,
                            signalDistortion
                        )
                    )
                );
            }
        }

        [EventHandler(Event.SaltyChat_EndCall)]
        private void OnEndCall(string handle)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
            {
                this.ExecuteCommand(
                    new PluginCommand(
                        Command.StopPhoneCommunication,
                        this.Configuration.ServerUniqueIdentifier,
                        new PhoneCommunication(
                            client.TeamSpeakName
                        )
                    )
                );
            }
        }
        #endregion

        #region Remote Events (Radio)
        [EventHandler(Event.SaltyChat_SetRadioSpeaker)]
        private void OnSetRadioSpeaker(bool isRadioSpeakerEnabled)
        {
            this.IsRadioSpeakerEnabled = isRadioSpeakerEnabled;
        }

        [EventHandler(Event.SaltyChat_SetRadioChannel)]
        private void OnSetRadioChannel(string radioChannel, bool isPrimary)
        {
            if (isPrimary)
            {
                this.PrimaryRadioChannel = radioChannel;

                if (String.IsNullOrEmpty(radioChannel))
                    this.PlaySound("leaveRadioChannel", false, "radio");
                else
                    this.PlaySound("enterRadioChannel", false, "radio");
            }
            else
            {
                this.SecondaryRadioChannel = radioChannel;

                if (String.IsNullOrEmpty(radioChannel))
                    this.PlaySound("leaveRadioChannel", false, "radio");
                else
                    this.PlaySound("enterRadioChannel", false, "radio");
            }
        }

        [EventHandler(Event.SaltyChat_IsSending)]
        private void OnPlayerIsSending(string handle, string radioChannel, bool isSending, bool stateChange, string positionJson)
        {
            this.OnPlayerIsSendingRelayed(handle, radioChannel, isSending, stateChange, positionJson, true, new List<dynamic>());
        }

        [EventHandler(Event.SaltyChat_IsSendingRelayed)]
        private void OnPlayerIsSendingRelayed(string handle, string radioChannel, bool isSending, bool stateChange, string positionJson, bool direct, List<dynamic> relays)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            if (serverId == Game.Player.ServerId)
            {
                if (isSending)
                {
                    this.ExecuteCommand(
                        new PluginCommand(
                            Command.RadioCommunicationUpdate,
                            this.Configuration.ServerUniqueIdentifier,
                            new RadioCommunication(
                                this.TeamSpeakName,
                                RadioType.LongRange,
                                RadioType.LongRange,
                                stateChange,
                                direct,
                                this.SecondaryRadioChannel == radioChannel,
                                relays.Select(r => (string)r).ToArray(),
                                this.RadioVolume
                            )
                        )
                    );
                }
                else
                {
                    this.ExecuteCommand(
                        new PluginCommand(
                            Command.StopRadioCommunication,
                            this.Configuration.ServerUniqueIdentifier,
                            new RadioCommunication(
                                this.TeamSpeakName,
                                RadioType.None,
                                RadioType.None,
                                stateChange,
                                direct,
                                this.SecondaryRadioChannel == radioChannel
                            )
                        )
                    );
                }
            }
            else if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
            {
                if (client.DistanceCulled)
                {
                    client.LastPosition = Newtonsoft.Json.JsonConvert.DeserializeObject<CitizenFX.Core.Vector3>(positionJson);
                    client.SendPlayerStateUpdate(this);
                }

                if (isSending)
                {
                    this.ExecuteCommand(
                        new PluginCommand(
                            Command.RadioCommunicationUpdate,
                            this.Configuration.ServerUniqueIdentifier,
                            new RadioCommunication(
                                client.TeamSpeakName,
                                RadioType.LongRange,
                                RadioType.LongRange,
                                stateChange,
                                direct,
                                this.SecondaryRadioChannel == radioChannel,
                                relays.Select(r => (string)r).ToArray(),
                                this.RadioVolume
                            )
                        )
                    );
                }
                else
                {
                    this.ExecuteCommand(
                        new PluginCommand(
                            Command.StopRadioCommunication,
                            this.Configuration.ServerUniqueIdentifier,
                            new RadioCommunication(
                                client.TeamSpeakName,
                                RadioType.None,
                                RadioType.None,
                                stateChange,
                                direct,
                                this.SecondaryRadioChannel == radioChannel
                            )
                        )
                    );
                }
            }
        }

        [EventHandler(Event.SaltyChat_UpdateRadioTowers)]
        private void OnUpdateRadioTowers(dynamic towers)
        {
            List<Vector3> towerPositions = new List<Vector3>();

            foreach (dynamic tower in towers)
            {
                towerPositions.Add(new Vector3(tower[0], tower[1], tower[2]));
            }

            this.RadioTowers = towerPositions.ToArray();

            this.ExecuteCommand(
                new PluginCommand(
                    Command.RadioTowerUpdate,
                    this.Configuration.ServerUniqueIdentifier,
                    new RadioTower(
                        towerPositions.ToArray()
                    )
                )
            );
        }
        #endregion

        #region Remote Events(Megaphone)
        [EventHandler(Event.SaltyChat_IsUsingMegaphone)]
        private void OnIsUsingMegaphone(string handle, float range, bool isSending, string positionJson)
        {
            if (!Int32.TryParse(handle, out int serverId))
                return;

            string name;

            if (serverId == Game.Player.ServerId)
            {
                name = this.TeamSpeakName;
            }
            else if (this._voiceClients.TryGetValue(serverId, out VoiceClient client))
            {
                if (client.DistanceCulled)
                {
                    client.LastPosition = Newtonsoft.Json.JsonConvert.DeserializeObject<CitizenFX.Core.Vector3>(positionJson);
                    client.SendPlayerStateUpdate(this);
                }

                name = client.TeamSpeakName;
            }
            else
            {
                return;
            }

            this.ExecuteCommand(
                new PluginCommand(
                    isSending ? Command.MegaphoneCommunicationUpdate : Command.StopMegaphoneCommunication,
                    this.Configuration.ServerUniqueIdentifier,
                    new MegaphoneCommunication(
                        name,
                        range
                    )
                )
            );
        }
        #endregion

        #region Exports (Proximity)
        internal float GetVoiceRange() => this.VoiceRange;
        #endregion

        #region Exports (Radio)
        internal string GetRadioChannel(bool primary) => primary ? this.PrimaryRadioChannel : this.SecondaryRadioChannel;

        internal float GetRadioVolume() => this.RadioVolume;

        internal bool GetRadioSpeaker() => this.IsRadioSpeakerEnabled;

        internal void SetRadioChannel(string radioChannelName, bool primary)
        {
            if ((primary && this.PrimaryRadioChannel == radioChannelName) ||
                (!primary && this.SecondaryRadioChannel == radioChannelName))
                return;

            BaseScript.TriggerServerEvent(Event.SaltyChat_SetRadioChannel, radioChannelName, primary);
        }

        internal void SetRadioVolume(float volumeLevel)
        {
            if (volumeLevel < 0f)
                this.RadioVolume = 0f;
            else if (volumeLevel > 1.6f)
                this.RadioVolume = 1.6f;
            else
                this.RadioVolume = volumeLevel;
        }

        internal void SetRadioSpeaker(bool isRadioSpeakEnabled)
        {
            BaseScript.TriggerServerEvent(Event.SaltyChat_SetRadioSpeaker, isRadioSpeakEnabled);
        }
        #endregion

        #region Exports (Misc)
        internal int GetPluginState() => (int)this.PlguinState;
        #endregion

        #region NUI Events
        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnNuiReady)]
        private void OnNuiReady(dynamic dummy, dynamic cb)
        {
            this.IsNuiReady = true;

            if (this.IsEnabled && this.TeamSpeakName != null && !this.IsConnected)
            {
                Debug.WriteLine("[Salty Chat] NUI is now ready, connecting...");

                this.ExecuteCommand("connect", this.WebSocketAddress);
            }

            cb("");
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnConnected)]
        private void OnConnected(dynamic dummy, dynamic cb)
        {
            this.IsConnected = true;

            if (this.IsEnabled)
                this.InitializePlugin();

            cb("");
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnDisconnected)]
        private void OnDisconnected(dynamic dummy, dynamic cb)
        {
            this.IsConnected = false;

            BaseScript.TriggerEvent("SaltyNUI:TsNotActive");

            cb("");
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnMessage)]
        private void OnMessage(dynamic message, dynamic cb)
        {
            cb("");

            PluginCommand pluginCommand = PluginCommand.Deserialize(message);

            if (pluginCommand.ServerUniqueIdentifier != this.Configuration.ServerUniqueIdentifier)
                return;

            switch (pluginCommand.Command)
            {
                case Command.PluginState:
                    {
                        if (pluginCommand.TryGetPayload(out PluginState pluginState))
                        {
                            BaseScript.TriggerServerEvent(Event.SaltyChat_CheckVersion, pluginState.Version);

                            this.ExecuteCommand(
                                new PluginCommand(
                                    Command.RadioTowerUpdate,
                                    this.Configuration.ServerUniqueIdentifier,
                                    new RadioTower(this.RadioTowers)
                                )
                            );
                        }   

                        break;
                    }
                case Command.Reset:
                    {
                        this.PlguinState = GameInstanceState.NotInitiated;

                        this.InitializePlugin();

                        break;
                    }
                case Command.Ping:
                    {
                        this.ExecuteCommand(new PluginCommand(this.Configuration.ServerUniqueIdentifier));

                        break;
                    }
                case Command.InstanceState:
                    {
                        if (pluginCommand.TryGetPayload(out InstanceState instanceState))
                            this.PlguinState = instanceState.State;

                        if (instanceState.IsReady)
                        {
                            BaseScript.TriggerEvent("SaltyNUI:TsActive");
                        }
                        else
                        {
                            BaseScript.TriggerEvent("SaltyNUI:TsNotActive");
                        }

                        break;
                    }
                case Command.SoundState:
                    {
                        if (pluginCommand.TryGetPayload(out SoundState soundState))
                        {
                            if (soundState.IsMicrophoneMuted != this.IsMicrophoneMuted)
                            {
                                this.IsMicrophoneMuted = soundState.IsMicrophoneMuted;

                                BaseScript.TriggerEvent(Event.SaltyChat_MicStateChanged, this.IsMicrophoneMuted);
                            }

                            if (soundState.IsMicrophoneEnabled != this.IsMicrophoneEnabled)
                            {
                                this.IsMicrophoneEnabled = soundState.IsMicrophoneEnabled;

                                BaseScript.TriggerEvent(Event.SaltyChat_MicEnabledChanged, this.IsMicrophoneEnabled);
                            }

                            if (soundState.IsSoundMuted != this.IsSoundMuted)
                            {
                                this.IsSoundMuted = soundState.IsSoundMuted;

                                BaseScript.TriggerEvent(Event.SaltyChat_SoundStateChanged, this.IsSoundMuted);
                            }

                            if (soundState.IsSoundEnabled != this.IsSoundEnabled)
                            {
                                this.IsSoundEnabled = soundState.IsSoundEnabled;

                                BaseScript.TriggerEvent(Event.SaltyChat_SoundEnabledChanged, this.IsSoundEnabled);
                            }
                        }

                        break;
                    }
                case Command.TalkState:
                    {
                        if (pluginCommand.TryGetPayload(out TalkState talkState))
                            this.SetPlayerTalking(talkState.Name, talkState.IsTalking);

                        break;
                    }
                case Command.RadioTrafficState:
                    {
                        if (pluginCommand.TryGetPayload(out RadioTrafficState radioTrafficState))
                            BaseScript.TriggerEvent(Event.SaltyChat_RadioTrafficStateChanged, radioTrafficState.Name, radioTrafficState.IsSending, radioTrafficState.IsPrimaryChannel, radioTrafficState.ActiveRelay);
                        
                        break;
                    }
            }
        }

        [EventHandler("__cfx_nui:" + NuiEvent.SaltyChat_OnError)]
        private void OnError(dynamic message, dynamic cb)
        {
            try
            {
                PluginError pluginError = PluginError.Deserialize(message);

                switch (pluginError.Error)
                {
                    case Error.AlreadyInGame:
                        {
                            Debug.WriteLine($"[Salty Chat] Error: Seems like we are already in an instance, retry...");

                            this.InitializePlugin();

                            break;
                        }
                    default:
                        {
                            Debug.WriteLine($"[Salty Chat] Error: {pluginError.Error} - Message: {pluginError.Message}");

                            break;
                        }
                }
            }
            catch (Exception e)
            {
                Debug.WriteLine($"[Salty Chat] Error: We received an error, but couldn't deserialize it:{Environment.NewLine}{e.ToString()}");
            }

            cb("");
        }
        #endregion

        #region Tick
        [Tick]
        private async Task FirstTick()
        {
            this.Configuration = JsonConvert.DeserializeObject<Configuration>(API.LoadResourceFile(API.GetCurrentResourceName(), "config.json"));
            this.VoiceRange = this.Configuration.VoiceRanges[1];

            BaseScript.TriggerServerEvent(Event.SaltyChat_Initialize);

            this.Tick -= this.FirstTick;

            await Task.FromResult(0);
        }

        [Tick]
        private async Task OnControlTick()
        {
            Ped playerPed = Game.PlayerPed;

            if (this.IsEnabled && playerPed != null && playerPed.IsAlive)
            {
                

                if (Game.IsControlJustPressed(0, (Control)this.Configuration.ToggleRange))
                {
                    this.ToggleVoiceRange();
                }

                if (playerPed.IsInPoliceVehicle)
                {
                    Vehicle vehicle = playerPed.CurrentVehicle;

                    if (vehicle.GetPedOnSeat(VehicleSeat.Driver) == playerPed || vehicle.GetPedOnSeat(VehicleSeat.Passenger) == playerPed)
                    {
                        

                        if (Game.IsControlJustPressed(0, (Control)this.Configuration.TalkMegaphone))
                        {
                            BaseScript.TriggerServerEvent(Event.SaltyChat_IsUsingMegaphone, true);
                            this.IsUsingMegaphone = true;
                        }
                        else if (Game.IsControlJustReleased(0, (Control)this.Configuration.TalkMegaphone))
                        {
                            BaseScript.TriggerServerEvent(Event.SaltyChat_IsUsingMegaphone, false);
                            this.IsUsingMegaphone = false;
                        }
                    }
                }
                else if (this.IsUsingMegaphone)
                {
                    BaseScript.TriggerServerEvent(Event.SaltyChat_IsUsingMegaphone, false);
                    this.IsUsingMegaphone = false;
                }

                if (this.PrimaryRadioChannel != null)
                {
                    

                    if (Game.IsControlJustPressed(0, (Control)this.Configuration.TalkPrimary))
                    {
                        BaseScript.TriggerServerEvent(Event.SaltyChat_IsSending, this.PrimaryRadioChannel, true);
                        Game.PlayerPed.Task.PlayAnimation("random@arrests", "generic_radio_enter", 2f, -1, (AnimationFlags)50);
                    }
                    else if (Game.IsControlJustReleased(0, (Control)this.Configuration.TalkPrimary))
                    {
                        BaseScript.TriggerServerEvent(Event.SaltyChat_IsSending, this.PrimaryRadioChannel, false);
                        Game.PlayerPed.Task.ClearAnimation("random@arrests", "generic_radio_enter");
                    }
                }

                if (this.SecondaryRadioChannel != null)
                {
                    

                    if (Game.IsControlJustPressed(0, (Control)this.Configuration.TalkSecondary))
                    {
                        BaseScript.TriggerServerEvent(Event.SaltyChat_IsSending, this.SecondaryRadioChannel, true);
                        Game.PlayerPed.Task.PlayAnimation("random@arrests", "generic_radio_enter", 2f, -1, (AnimationFlags)50);
                    }
                    else if (Game.IsControlJustReleased(0, (Control)this.Configuration.TalkSecondary))
                    {
                        BaseScript.TriggerServerEvent(Event.SaltyChat_IsSending, this.SecondaryRadioChannel, false);
                        Game.PlayerPed.Task.ClearAnimation("random@arrests", "generic_radio_enter");
                    }
                }
            }

            await Task.FromResult(0);
        }

        [Tick]
        private async Task OnStateUpdateTick()
        {
            if (this.IsConnected && this.PlguinState == GameInstanceState.Ingame)
            {
                List<PlayerState> playerStates = new List<PlayerState>();

                Ped playerPed = Game.PlayerPed;
                CitizenFX.Core.Vector3 playerPosition = playerPed.Position;
                int playerRoomId = API.GetRoomKeyFromEntity(playerPed.Handle);
                Vehicle playerVehicle = playerPed.CurrentVehicle;
                bool hasPlayerVehicleOpening = playerVehicle == null || playerVehicle.HasOpening();

                foreach (VoiceClient client in this.VoiceClients)
                {
                    Player nPlayer = client.Player;

                    if (nPlayer == null)
                    {
                        if (client.DistanceCulled)
                            continue;

                        client.DistanceCulled = true;

                        playerStates.Add(
                            new PlayerState(
                                client.TeamSpeakName,
                                client.LastPosition,
                                client.VoiceRange,
                                client.IsAlive,
                                client.DistanceCulled
                            )
                        );
                    }
                    else
                    {
                        if (client.DistanceCulled)
                            client.DistanceCulled = false;

                        Ped nPed = nPlayer.Character;
                        client.LastPosition = nPed.Position;

                        int? muffleIntensity = null;
                        int nPlayerRoomId = API.GetRoomKeyFromEntity(nPed.Handle);

                        if (nPlayerRoomId != playerRoomId && !API.HasEntityClearLosToEntity(playerPed.Handle, nPed.Handle, 17))
                        {
                            muffleIntensity = 10;
                        }
                        else
                        {
                            Vehicle nPlayerVehicle = nPed.CurrentVehicle;

                            if (playerVehicle != nPlayerVehicle)
                            {
                                bool hasNPlayerVehicleOpening = nPlayerVehicle == null || nPlayerVehicle.HasOpening();

                                if (!hasPlayerVehicleOpening && !hasNPlayerVehicleOpening)
                                    muffleIntensity = 10;
                                else if (!hasPlayerVehicleOpening || !hasNPlayerVehicleOpening)
                                    muffleIntensity = 6;
                            }
                        }

                        playerStates.Add(
                            new PlayerState(
                                client.TeamSpeakName,
                                client.LastPosition,
                                client.VoiceRange,
                                client.IsAlive,
                                client.DistanceCulled,
                                muffleIntensity
                            )
                        );
                    }
                }

                this.ExecuteCommand(
                    new PluginCommand(
                        Command.BulkUpdate,
                        this.Configuration.ServerUniqueIdentifier,
                        new BulkUpdate(
                            playerStates,
                            new SelfState(
                                playerPosition,
                                API.GetGameplayCamRot(0).Z
                            )
                        )
                    )
                );
            }

            await BaseScript.Delay(250);
        }
        #endregion

        #region Methods (Proximity)
        private void SetPlayerTalking(string teamSpeakName, bool isTalking)
        {
            if (teamSpeakName == this.TeamSpeakName)
            {
                BaseScript.TriggerEvent(Event.SaltyChat_TalkStateChanged, isTalking);

                API.SetPlayerTalkingOverride(Game.Player.Handle, isTalking);

                // Lip sync workaround for OneSync
                if (isTalking)
                    API.PlayFacialAnim(Game.PlayerPed.Handle, "mic_chatter", "mp_facial");
                else
                    API.PlayFacialAnim(Game.PlayerPed.Handle, "mood_normal_1", "facials@gen_male@variations@normal");
            }
            else
            {
                VoiceClient voiceClient = this.VoiceClients.FirstOrDefault(v => v.TeamSpeakName == teamSpeakName);

                if (voiceClient != null && voiceClient.Player != null)
                    API.SetPlayerTalkingOverride(voiceClient.Player.Handle, isTalking);
            }
        }

        /// <summary>
        /// Toggles voice range through <see cref="Voice.VoiceRanges"/>
        /// </summary>
        public void ToggleVoiceRange()
        {
            int index = Array.IndexOf(this.Configuration.VoiceRanges, this.VoiceRange);

            if (index < 0)
            {
                index = 1;
                this.VoiceRange = this.Configuration.VoiceRanges[index];
            }
            else if (index + 1 >= this.Configuration.VoiceRanges.Length)
            {
                index = 0;
                this.VoiceRange = this.Configuration.VoiceRanges[index];
            }
            else
            {
                index++;
                this.VoiceRange = this.Configuration.VoiceRanges[index];
            }

            BaseScript.TriggerServerEvent(Event.SaltyChat_SetVoiceRange, this.VoiceRange);
            BaseScript.TriggerEvent(Event.SaltyChat_VoiceRangeChanged, this.VoiceRange, index, this.Configuration.VoiceRanges.Length);

            if (this.RangeNotification != null)
                this.RangeNotification.Hide();

            this.RangeNotification = CitizenFX.Core.UI.Screen.ShowNotification($"Deine neue Sprachreichweite beträgt {this.VoiceRange} meter.");
        }
        #endregion

        #region Methods (Plugin)
        private void InitializePlugin()
        {
            this.ExecuteCommand(
                new PluginCommand(
                    Command.Initiate,
                    new GameInstance(
                        this.Configuration.ServerUniqueIdentifier,
                        this.TeamSpeakName,
                        this.Configuration.IngameChannelId,
                        this.Configuration.IngameChannelPassword,
                        this.Configuration.SoundPack,
                        this.Configuration.SwissChannelIds,
                        this.Configuration.RequestTalkStates,
                        this.Configuration.RequestRadioTrafficStates
                    )
                )
            );
        }

        /// <summary>
        /// Plays a file from soundpack specified in <see cref="VoiceManager.SoundPack"/>
        /// </summary>
        /// <param name="fileName">filename (without .wav) of the soundfile</param>
        /// <param name="loop">use <see cref="true"/> to let the plugin loop the sound</param>
        /// <param name="handle">use your own handle instead of the filename, so you can play the sound multiple times</param>
        public void PlaySound(string fileName, bool loop = false, string handle = null)
        {
            if (String.IsNullOrWhiteSpace(handle))
                handle = fileName;

            this.ExecuteCommand(
                new PluginCommand(
                    Command.PlaySound,
                    this.Configuration.ServerUniqueIdentifier,
                    new Sound(
                        fileName,
                        loop,
                        handle
                    )
                )
            );
        }

        /// <summary>
        /// Stops and dispose the sound
        /// </summary>
        /// <param name="handle">filename or handle of the sound</param>
        public void StopSound(string handle)
        {
            this.ExecuteCommand(
                new PluginCommand(
                    Command.StopSound,
                    this.Configuration.ServerUniqueIdentifier,
                    new Sound(handle)
                )
            );
        }

        private void ExecuteCommand(string funtion, object parameters)
        {
            API.SendNuiMessage(
                Newtonsoft.Json.JsonConvert.SerializeObject(new { Function = funtion, Params = parameters })
            );
        }

        internal void ExecuteCommand(PluginCommand pluginCommand)
        {
            this.ExecuteCommand("runCommand", Util.ToJson(pluginCommand));
        }

        private void DisplayDebug(bool show)
        {
            this.ExecuteCommand("showBody", show);
        }
        #endregion
    }
}
