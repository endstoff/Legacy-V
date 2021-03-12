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
    ('emergency_revive_kit', 'Emergency Revive Kit', 1),
    ('blood_100', 'Blood 100', 1),
    ('blood_250', 'Blood 250', 1),
    ('blood_500', 'Blood 500', 1),
    ('blood_1000', 'Blood 1000', 1)
;

ALTER TABLE `users` ADD `healthData` TEXT NOT NULL;