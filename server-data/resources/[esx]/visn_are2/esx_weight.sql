INSERT INTO items (name, label, weight) VALUES
    ('defibrilator', 'Defibrilator', 1),
    ('painkillers', 'Painkillers', 1),
    ('morphin', 'Morphin', 1),
    ('bodybag', 'Body bag', 1),
    ('atropine', 'Atropine', 1),
    ('epinephrine', 'Epinephrine', 1),
    ('surgical_kit', 'Surgical kit', 1),
    ('bandage', 'Bandage', 1),
    ('elastic_bandage', 'Elastic bandage', 1),
    ('quickclot', 'Quickclot', 1),
    ('tourniquet', 'Tourniquet', 1),
    ('packing_bandage', 'Packing bandage', 1),
    ('blood_100', 'Blood 100', 1),
    ('blood_250', 'Blood 250', 1),
    ('blood_500', 'Blood 500', 1),
    ('blood_500', 'Blood 1000', 1)
    ('blood_1000', 'Blood 1000', 1)
;

ALTER TABLE `users` ADD `healthData` TEXT NOT NULL DEFAULT '{\"bodyPulse\":80,\"bodyBloodLevel\":6.0,\"victimBleeding\":false,\"recievingBloodInfusion\":0,\"bodyPain\":0,\"bodyInPain\":false,\"bloodPressureL\":80.0,\"needSewed\":[],\"isUnconscious\":false,\"bloodPressureH\":120.0,\"logs\":[],\"bodyPartDamage\":{\"torso\":0,\"right_arm\":0,\"left_leg\":0,\"right_leg\":0,\"head\":0,\"left_arm\":0},\"bloodParts\":{\"torso\":0,\"right_arm\":0,\"left_leg\":0,\"right_leg\":0,\"head\":0,\"left_arm\":0}}'