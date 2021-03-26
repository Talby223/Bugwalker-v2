

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.builds DISABLE TRIGGER ALL;

INSERT INTO public.builds (id, created_at, build_string, build_date) VALUES ('c87b35d7-f107-4f57-90f8-c0c6035e3ff2', '2021-03-25 19:33:02.693199-05', 'c87b35d7-f107-4f57-90f8-c0c6035e3ff2', '2021-03-25 19:33:02.693199-05');


ALTER TABLE public.builds ENABLE TRIGGER ALL;


ALTER TABLE public.spells DISABLE TRIGGER ALL;



ALTER TABLE public.spells ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;



ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.bugs DISABLE TRIGGER ALL;



ALTER TABLE public.bugs ENABLE TRIGGER ALL;


ALTER TABLE public.comments DISABLE TRIGGER ALL;



ALTER TABLE public.comments ENABLE TRIGGER ALL;


ALTER TABLE public.run_game_asset_update_jobs DISABLE TRIGGER ALL;



ALTER TABLE public.run_game_asset_update_jobs ENABLE TRIGGER ALL;


ALTER TABLE public.specs DISABLE TRIGGER ALL;

INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('58acf3da-44b5-4098-ae90-bcba93b3c2e8', 62, 8, 'Arcane', 'Manipulates raw Arcane magic, destroying enemies with overwhelming power.

Preferred Weapon: Staff, Wand, Dagger, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('9443dd2a-fac6-43fb-8fb6-c85463afca18', 63, 8, 'Fire', 'Focuses the pure essence of Fire magic, assaulting enemies with combustive flames.

Preferred Weapon: Staff, Wand, Dagger, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('bdbeac68-064c-4cba-850b-ee59663751c4', 64, 8, 'Frost', 'Freezes enemies in their tracks and shatters them with Frost magic.

Preferred Weapon: Staff, Wand, Dagger, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('85bff9ef-d8cd-4812-bf2e-fd5d5c092850', 65, 2, 'Holy', 'Invokes the power of the Light to heal and protect allies and vanquish evil from the darkest corners of the world.

Preferred Weapon: Sword, Mace, and Shield', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('5e47f789-2af3-4a98-b68c-201ff890a124', 66, 2, 'Protection', 'Uses Holy magic to shield $Ghimself:herself; and defend allies from attackers.

Preferred Weapon: Sword, Mace, Axe, and Shield', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('e8de6edf-ed72-4a6a-98c7-21670bb7fa58', 70, 2, 'Retribution', 'A righteous crusader who judges and punishes opponents with weapons and Holy magic.

Preferred Weapon: Two-Handed Sword, Mace, Axe', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('2670bcb7-09f9-4b80-b5a3-29c7c04bd0e4', 71, 1, 'Arms', 'A battle-hardened master of weapons, using mobility and overpowering attacks to strike $Ghis:her; opponents down.

Preferred Weapon: Two-Handed Axe, Mace, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('9d379217-6c69-4646-8229-f9de86398b06', 72, 1, 'Fury', 'A furious berserker unleashing a flurry of attacks to carve $Ghis:her; opponents to pieces.

Preferred Weapons: Dual Axes, Maces, Swords', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('c9f25b2c-58e3-467d-881c-4e61476f392d', 73, 1, 'Protection', 'A stalwart protector who uses a shield to safeguard $Ghimself:herself; and $Ghis:her; allies.

Preferred Weapon: Axe, Mace, Sword, and Shield', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('d6301b59-8d73-4c79-b40a-61223fa1c91d', 102, 11, 'Balance', 'Can shapeshift into a powerful Moonkin, balancing the power of Arcane and Nature magic to destroy enemies.

Preferred Weapon: Staff, Dagger, Mace', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('3db89c73-1527-431c-90ae-d94055cc0298', 103, 11, 'Feral', 'Takes on the form of a great cat to deal damage with bleeds and bites.

Preferred Weapon: Staff, Polearm', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('a9b39d9e-cd81-4bcf-a01a-ca927f487305', 104, 11, 'Guardian', 'Takes on the form of a mighty bear to absorb damage and protect allies.

Preferred Weapon: Staff, Polearm', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('53c9cb96-904a-4770-b742-f64c0d4d7b24', 105, 11, 'Restoration', 'Channels powerful Nature magic to regenerate and revitalize allies.

Preferred Weapon: Staff, Dagger, Mace', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('d878a0cf-cde1-4a66-a326-7cfe7231d287', 250, 6, 'Blood', 'A dark guardian who manipulates and corrupts life energy to sustain $Ghimself:herself; in the face of an enemy onslaught.

Preferred Weapon: Two-Handed Axe, Mace, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('1c0d1be4-d48b-4e52-96b0-9c60ef2828a8', 251, 6, 'Frost', 'An icy harbinger of doom, channeling runic power and delivering vicious weapon strikes.

Preferred Weapons: Dual Axes, Maces, Swords', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('af7fc169-93fe-4ebd-8eb9-c7043703b10d', 252, 6, 'Unholy', 'A master of death and decay, spreading infection and controlling undead minions to do $Ghis:her; bidding.

Preferred Weapon: Two-Handed Axe, Mace, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('c4e06bee-e080-47c7-ae5b-38457b51611c', 253, 3, 'Beast Mastery', 'A master of the wild who can tame a wide variety of beasts to assist $Ghim:her; in combat.

Preferred Weapon: Bow, Crossbow, Gun', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('adeef328-daa1-4f23-bbd7-e3cc5b19f5e5', 254, 3, 'Marksmanship', 'A master sharpshooter who excels in bringing down enemies from afar.

Preferred Weapon: Bow, Crossbow, Gun', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('a5775395-22d5-4341-aa1d-95c076b70306', 255, 3, 'Survival', 'An adaptive ranger who favors using explosives, animal venom, and coordinated attacks with their bonded beast.

Preferred Weapon: Polearm, Staff', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('f868874b-80d7-4cf9-88d5-c9b7f1530c2a', 256, 5, 'Discipline', 'Uses magic to shield allies from taking damage as well as heal their wounds.

Preferred Weapon: Staff, Wand, Dagger, Mace', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('a9bf68a5-73f3-4f7a-ae3a-26ccc98b739a', 257, 5, 'Holy', 'A versatile healer who can reverse damage on individuals or groups and even heal from beyond the grave.

Preferred Weapon: Staff, Wand, Dagger, Mace', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('3638ebb6-401e-4a32-b863-fb1fa616e2b8', 258, 5, 'Shadow', 'Uses sinister Shadow magic and terrifying Void magic to eradicate enemies.

Preferred Weapon: Staff, Wand, Dagger, Mace', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('5bef9bab-459c-43b1-80d6-fd610324929a', 259, 4, 'Assassination', 'A deadly master of poisons who dispatches victims with vicious dagger strikes.

Preferred Weapons: Daggers', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('20a6deab-23e4-4b82-9de6-f7e1c147aebb', 260, 4, 'Outlaw', 'A ruthless fugitive who uses agility and guile to stand toe-to-toe with enemies.

Preferred Weapons: Axes, Maces, Swords, Fist Weapons', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('be446479-3cad-4429-ba36-8641ee679468', 261, 4, 'Subtlety', 'A dark stalker who leaps from the shadows to ambush $Ghis:her; unsuspecting prey.

Preferred Weapons: Daggers', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('2751c86b-2e00-4224-8de3-42f4e9d1e385', 262, 7, 'Elemental', 'A spellcaster who harnesses the destructive forces of nature and the elements.

Preferred Weapon: Mace, Dagger, and Shield', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('33e8ba16-a595-4a37-9dcd-9d63f0067b77', 263, 7, 'Enhancement', 'A totemic warrior who strikes foes with weapons imbued with elemental power.

Preferred Weapons: Dual Axes, Maces, Fist Weapons', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('c8d706cb-2f7c-4655-a3df-8be52e1b32ec', 264, 7, 'Restoration', 'A healer who calls upon ancestral spirits and the cleansing power of water to mend allies'' wounds.

Preferred Weapon: Mace, Dagger, and Shield', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('de34a333-764f-4fe1-b465-56cd71ea0247', 265, 9, 'Affliction', 'A master of shadow magic who specializes in drains and damage-over-time spells.

Preferred Weapon: Staff, Wand, Dagger, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('272be875-20a7-4f2b-abfc-d7a1fd5c8d2f', 266, 9, 'Demonology', 'A commander of demons who twists the souls of $Ghis:her; army into devastating power.

Preferred Weapon: Staff, Wand, Dagger, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('45f2ba75-09d6-4a2d-8af8-43fc649dec5e', 267, 9, 'Destruction', 'A master of chaos who calls down fire to burn and demolish enemies.

Preferred Weapon: Staff, Wand, Dagger, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('81f41b9f-7055-44c4-bfa6-1ed435de1505', 268, 10, 'Brewmaster', 'A sturdy brawler who uses unpredictable movement and mystical brews to avoid damage and protect allies.

Preferred Weapon: Staff, Polearm', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('54e7aaca-ec38-4121-873b-44b839675f69', 269, 10, 'Windwalker', 'A martial artist without peer who pummels foes with hands and fists.

Preferred Weapons: Fist Weapons, Axes, Maces, Swords', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('0d86fd96-cd0f-4f59-b359-3d5673e2ad0a', 270, 10, 'Mistweaver', 'A healer who masters the mysterious art of manipulating life energies aided by the wisdom of the Jade Serpent.

Preferred Weapon: Staff, Mace, Sword', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('46df946d-1bca-4831-8948-58ff3e687c2d', 577, 12, 'Havoc', 'A brooding master of warglaives and the destructive power of Fel magic.

Preferred Weapons: Warglaives, Swords, Axes, Fist Weapons', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('f90a7bb8-ca61-45aa-9346-dc14d966a4b2', 581, 12, 'Vengeance', 'Embraces the demon within to incinerate enemies and protect their allies.

Preferred Weapons: Warglaives, Swords, Axes, Fist Weapons', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('c534847b-15a6-41bc-808b-755b132fb1ce', 0, 0, 'General', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('7cd4d36f-6112-4ed4-abaf-359fda8420d6', 1, 1, 'Warrior', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('da19b999-8b29-4284-8caa-a4191e23b862', 2, 2, 'Paladin', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('bccebad7-e174-4840-aa98-d0339c3d1aad', 3, 3, 'Hunter', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('c740bc73-486f-4302-bec1-a1fe62136a18', 4, 4, 'Rogue', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('c164200e-d411-41c7-8ad1-02d0c7888d2f', 5, 5, 'Priest', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('97a6f2c3-06b5-4a29-b459-e9585ba446df', 6, 6, 'Death Knight', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('050de022-001a-4d02-ac3f-0f2b0a295eab', 7, 7, 'Shaman', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('7ceace46-5e3f-4bda-b520-cbfb650be1e0', 8, 8, 'Mage', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('08882c66-f06a-4a3d-b2db-35315ba65961', 9, 9, 'Warlock', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('04520413-5df3-4e2b-a241-95157b466869', 10, 10, 'Monk', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('3f7a1f9a-9634-47c4-9d82-3d43efa38edd', 11, 11, 'Druid', '', '');
INSERT INTO public.specs (id, game_id, game_class_id, spec_name, spec_description, spec_icon) VALUES ('f96da8e3-d0b6-4e85-b7b6-f177dfac73cf', 12, 12, 'Demon Hunter', '', '');


ALTER TABLE public.specs ENABLE TRIGGER ALL;


