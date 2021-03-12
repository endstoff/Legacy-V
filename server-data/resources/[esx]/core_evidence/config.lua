Config = {

-- IMPORTANT! To configure report text navigate to /html/script.js and find the text you want to replace

EvidenceReportInformationBullet = "sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationFingerprint = "firstname, lastname, job, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationBlood = "firstname, lastname, job, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)

ShowBloodSplatsOnGround = true, -- Show blood on the ground when player is shot
PlayClipboardAnimation = true, -- Play clipboard animation when reading report

JobRequired = 'police', -- The job needed to use evidence system
JobGradeRequired = 6, -- The MINIMUM job grade required to use evidence system (If you use 0 all job grades can use the system)

CloseReportKey = 'BACKSPACE', -- The key used to close the report
PickupEvidenceKey = 'E', -- The key used to pick up evidence

EvidenceAlanysisLocation = vector3(485.50827026367,-989.93328857422,30.689641952515), -- The place where the evidence will be analyzed and report generated
TimeToAnalyze = 10000, -- Time in miliseconds to analyze the given evidence
TimeToFindFingerprints = 3000, -- Time in miliseconds to find fingerprints in a car

Text = {

	['evidence_colleted'] = 'Beweis #{number} eingesammelt!',
	['no_more_space'] = 'Nicht genug platz für weitere Beweise 3/3!',
	['analyze_evidence'] = '[~b~E~w~] Analysieren Sie die Beweise',
	['evidence_being_analyzed'] = 'Der Beweis wird von der Forensik untersucht! Bitte warten',
	['evidence_being_analyzed_hologram'] = '~b~Die Beweise werden ausgewertet',
	['read_evidence_report'] = '[~b~E~w~] Beweisbericht lesen',
	['analyzing_car'] = 'Das Auto wird gerade analysiert! Bitte warten',
	['pick_up_evidence_text'] = 'Beweise sichern [~r~E~w~]',
	['no_fingerprints_found'] = 'Keine Fingerabdrücke gefunden!',
	['no_evidence_to_analyze'] = "Keine Beweise zum Analysieren!",
	['shell_hologram'] = '~b~ {guncategory} ~w~ Hülse',
	['blood_hologram'] = '~r~Blutspritzer',

	['blood_after_0_minutes'] = 'Status: ~r~Frisch',
	['blood_after_5_minutes'] = 'Status: ~y~Alt',
	['blood_after_10_minutes'] = 'Status: ~b~Sehr alt',

	['shell_after_0_minutes'] = 'Status: ~r~Heiß',
	['shell_after_5_minutes'] = 'Status: ~y~Warm',
	['shell_after_10_minutes'] = 'Status: ~b~Kalt',


	['submachine_category'] = 'Maschinenpistole',
	['pistol_category'] = 'Pistole',
	['shotgun_category'] = 'Shotgun',
	['assault_category'] = 'Sturmgewehr',
	['lightmachine_category'] = 'Leichtes Maschinengewehr',
	['sniper_category'] = 'Sniper',
	['heavy_category'] = 'Schwere Waffe'


}
	

}

-- Only change if you know what are you doing!
function SendTextMessage(msg)

		SetNotificationTextEntry('STRING')
		AddTextComponentString(msg)
		DrawNotification(0,1)

		--EXAMPLE USED IN VIDEO
		--exports['mythic_notify']:SendAlert('inform', msg)

end
