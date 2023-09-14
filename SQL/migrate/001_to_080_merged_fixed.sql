-- ------------------------------------------------------------
-- These are BOREALIS' tables. Some are actively used ingame,
-- hence why they're bundled in here.
-- ------------------------------------------------------------

--
-- BOREALIS' table for bans
--

CREATE TABLE `discord_bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `server_id` varchar(45) NOT NULL,
  `ban_type` varchar(45) NOT NULL,
  `ban_duration` int(11) NOT NULL DEFAULT '-1',
  `ban_reason` longtext,
  `ban_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiration_time` datetime NOT NULL,
  `admin_id` varchar(45) DEFAULT NULL,
  `admin_name` varchar(45) DEFAULT 'BOREALIS',
  `ban_lifted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- BOREALIS' table for channels
--

CREATE TABLE `discord_channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_group` varchar(32) NOT NULL,
  `channel_id` text NOT NULL,
  `pin_flag` int(11) NOT NULL DEFAULT '0',
  `server_id` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- BOREALIS' table for logs
--

CREATE TABLE `discord_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `action` text NOT NULL,
  `admin_id` varchar(45) DEFAULT NULL,
  `user_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- BOREALIS' table for strikes
--

CREATE TABLE `discord_strikes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `action_type` varchar(45) NOT NULL DEFAULT 'WARNING',
  `strike_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `admin_id` varchar(45) NOT NULL,
  `admin_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- BOREALIS' table for subscriptions
--

CREATE TABLE `discord_subscribers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL,
  `once` tinyint(1) NOT NULL DEFAULT '0',
  `subscribed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expired_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ------------------------------------------------------------
-- SS13 tables begin here. All of these are actively used.
-- Note that some are used by the WebInterface, but if so,
-- it's done in support of ingame systems.
-- ------------------------------------------------------------

--
-- Table for admin rank alterations
--

CREATE TABLE `ss13_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  `adminckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `adminip` varchar(18) CHARACTER SET latin1 NOT NULL,
  `log` text CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for the server-supported API/world.Topic commands
--

CREATE TABLE `ss13_api_commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `command` varchar(50) COLLATE utf8_bin NOT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE command` (`command`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table for auth tokens for world.Topic
--

CREATE TABLE `ss13_api_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(100) COLLATE utf8_bin NOT NULL,
  `ip` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `creator` varchar(50) COLLATE utf8_bin NOT NULL,
  `description` varchar(100) COLLATE utf8_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table to describe which tokens can access what commands for world.Topic
--

CREATE TABLE `ss13_api_token_command` (
  `command_id` int(11) NOT NULL,
  `token_id` int(11) NOT NULL,
  PRIMARY KEY (`command_id`,`token_id`),
  KEY `token_id` (`token_id`),
  CONSTRAINT `function_id` FOREIGN KEY (`command_id`) REFERENCES `ss13_api_commands` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `token_id` FOREIGN KEY (`token_id`) REFERENCES `ss13_api_tokens` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table for bans issued
--

CREATE TABLE `ss13_ban` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bantime` datetime NOT NULL,
  `serverip` varchar(32) CHARACTER SET latin1 NOT NULL,
  `bantype` varchar(32) CHARACTER SET latin1 NOT NULL,
  `reason` text CHARACTER SET latin1 NOT NULL,
  `job` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `rounds` int(11) DEFAULT NULL,
  `expiration_time` datetime NOT NULL,
  `ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `computerid` varchar(32) CHARACTER SET latin1 NOT NULL,
  `ip` varchar(32) CHARACTER SET latin1 NOT NULL,
  `a_ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `a_computerid` varchar(32) CHARACTER SET latin1 NOT NULL,
  `a_ip` varchar(32) CHARACTER SET latin1 NOT NULL,
  `who` text CHARACTER SET latin1 NOT NULL,
  `adminwho` text CHARACTER SET latin1 NOT NULL,
  `edits` text CHARACTER SET latin1,
  `unbanned` tinyint(1) DEFAULT NULL,
  `unbanned_datetime` datetime DEFAULT NULL,
  `unbanned_reason` text,
  `unbanned_ckey` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `unbanned_computerid` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `unbanned_ip` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for ban-mirroring, used to catch ban dodgers
--

CREATE TABLE `ss13_ban_mirrors` (
  `ban_mirror_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ban_id` int(10) unsigned NOT NULL,
  `player_ckey` varchar(32) NOT NULL,
  `ban_mirror_ip` varchar(32) NOT NULL,
  `ban_mirror_computerid` varchar(32) NOT NULL,
  `ban_mirror_datetime` datetime NOT NULL,
  PRIMARY KEY (`ban_mirror_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for housing CCIA notices to be sent mid-round
--

CREATE TABLE `ss13_ccia_general_notice_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table for player information
--

CREATE TABLE `ss13_player` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `firstseen` datetime NOT NULL,
  `lastseen` datetime NOT NULL,
  `ip` varchar(18) CHARACTER SET latin1 NOT NULL,
  `computerid` varchar(32) CHARACTER SET latin1 NOT NULL,
  `lastadminrank` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT 'Player',
  `whitelist_status` int(11) unsigned NOT NULL DEFAULT '0',
  `migration_status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ckey` (`ckey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for linking requests between the Web-Interface and game server
--

CREATE TABLE `ss13_player_linking` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) NOT NULL,
  `forum_username_short` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `forum_username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `player_ckey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('new','confirmed','rejected','linked') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table for player personal-AI preferences
--

CREATE TABLE `ss13_player_pai` (
  `ckey` varchar(32) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `role` text,
  `comments` text,
  PRIMARY KEY (`ckey`),
  CONSTRAINT `player_pai_fk_ckey` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table for general player preferences
--

CREATE TABLE `ss13_player_preferences` (
  `ckey` varchar(32) NOT NULL,
  `ooccolor` text,
  `lastchangelog` text,
  `UI_style` text,
  `current_character` int(11) DEFAULT '0',
  `toggles` int(11) DEFAULT '0',
  `UI_style_color` text,
  `UI_style_alpha` int(11) DEFAULT '255',
  `asfx_togs` int(11) DEFAULT '0',
  `lastmotd` text,
  `lastmemo` text,
  `language_prefixes` text,
  PRIMARY KEY (`ckey`),
  CONSTRAINT `player_preferences_fk_ckey` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table for holding admin ranks
--

CREATE TABLE `ss13_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `rank` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT 'Administrator',
  `level` int(2) NOT NULL DEFAULT '0',
  `flags` int(16) NOT NULL DEFAULT '0',
  `discord_id` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`ckey`),
  CONSTRAINT `ckey` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for initial character data
--

CREATE TABLE `ss13_characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ckey` varchar(32) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `metadata` varchar(512) DEFAULT NULL,
  `be_special_role` text,
  `gender` varchar(32) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `species` varchar(32) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  `hair_colour` varchar(7) DEFAULT NULL,
  `facial_colour` varchar(7) DEFAULT NULL,
  `skin_tone` int(11) DEFAULT NULL,
  `skin_colour` varchar(7) DEFAULT NULL,
  `hair_style` varchar(32) DEFAULT NULL,
  `facial_style` varchar(32) DEFAULT NULL,
  `eyes_colour` varchar(7) DEFAULT NULL,
  `underwear` varchar(32) DEFAULT NULL,
  `undershirt` varchar(32) DEFAULT NULL,
  `socks` varchar(32) DEFAULT NULL,
  `backbag` int(11) DEFAULT NULL,
  `b_type` varchar(32) DEFAULT NULL,
  `spawnpoint` varchar(32) DEFAULT NULL,
  `jobs` text,
  `alternate_option` tinyint(1) DEFAULT NULL,
  `alternate_titles` text,
  `disabilities` int(11) DEFAULT '0',
  `skills` text,
  `skill_specialization` text,
  `home_system` text,
  `citizenship` text,
  `faction` text,
  `religion` text,
  `nt_relation` text,
  `uplink_location` text,
  `organs_data` text,
  `organs_robotic` text,
  `gear` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ss13_characters_ckey` (`ckey`),
  KEY `ss13_characteres_name` (`name`),
  CONSTRAINT `ss13_characters_fk_ckey` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table for character flavour text
--

CREATE TABLE `ss13_characters_flavour` (
  `char_id` int(11) NOT NULL,
  `records_employment` text,
  `records_medical` text,
  `records_security` text,
  `records_exploit` text,
  `records_ccia` text,
  `flavour_general` text,
  `flavour_head` text,
  `flavour_face` text,
  `flavour_eyes` text,
  `flavour_torso` text,
  `flavour_arms` text,
  `flavour_hands` text,
  `flavour_legs` text,
  `flavour_feet` text,
  `robot_default` text,
  `robot_standard` text,
  `robot_engineering` text,
  `robot_construction` text,
  `robot_medical` text,
  `robot_rescue` text,
  `robot_miner` text,
  `robot_custodial` text,
  `robot_service` text,
  `robot_clerical` text,
  `robot_security` text,
  `robot_research` text,
  PRIMARY KEY (`char_id`),
  CONSTRAINT `ss13_flavour_fk_char_id` FOREIGN KEY (`char_id`) REFERENCES `ss13_characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table for housing IC criminal records
--

CREATE TABLE `ss13_character_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) NOT NULL,
  `UID` varchar(32) COLLATE utf8_bin NOT NULL,
  `datetime` varchar(50) COLLATE utf8_bin NOT NULL,
  `notes` text COLLATE utf8_bin NOT NULL,
  `charges` text COLLATE utf8_bin NOT NULL,
  `evidence` text COLLATE utf8_bin NOT NULL,
  `arbiters` text COLLATE utf8_bin NOT NULL,
  `brig_sentence` int(11) NOT NULL DEFAULT '0',
  `fine` int(11) NOT NULL DEFAULT '0',
  `felony` int(11) NOT NULL DEFAULT '0',
  `created_by` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `deleted_by` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `game_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UID_char_id` (`char_id`,`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Table for logging which characters have joined rounds when
--

CREATE TABLE `ss13_characters_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `char_id` int(11) NOT NULL,
  `game_id` varchar(50) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `job_name` varchar(32) DEFAULT NULL,
  `special_role` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ss13_charlog_fk_char_id` (`char_id`),
  CONSTRAINT `ss13_charlog_fk_char_id` FOREIGN KEY (`char_id`) REFERENCES `ss13_characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for CCIA actions taken against characters
--

CREATE TABLE `ss13_ccia_actions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('injunction','suspension','warning','other') COLLATE utf8_unicode_ci NOT NULL,
  `issuedby` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `details` text COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` date DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Bridge table between `ss13_ccia_actions` and `ss13_characters`
--

CREATE TABLE `ss13_ccia_action_char` (
  `action_id` int(10) unsigned NOT NULL,
  `char_id` int(11) NOT NULL,
  PRIMARY KEY (`action_id`,`char_id`),
  KEY `ccia_action_char_char_id_foreign` (`char_id`),
  CONSTRAINT `ccia_action_char_action_id_foreign` FOREIGN KEY (`action_id`) REFERENCES `ss13_ccia_actions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ccia_action_char_char_id_foreign` FOREIGN KEY (`char_id`) REFERENCES `ss13_characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table for logging player connections
--

CREATE TABLE `ss13_connection_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ckey` varchar(32) NOT NULL,
  `datetime` datetime NOT NULL,
  `serverip` varchar(32) NOT NULL,
  `ip` varchar(18) NOT NULL,
  `computerid` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for antag contest participants
--

CREATE TABLE `ss13_contest_participants` (
  `player_ckey` varchar(32) NOT NULL,
  `character_id` int(10) unsigned NOT NULL,
  `contest_faction` enum('INDEP','SLF','BIS','ASI','PSIS','HSH','TCD') NOT NULL DEFAULT 'INDEP'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for antag contenst reports
--

CREATE TABLE `ss13_contest_reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_ckey` varchar(32) NOT NULL,
  `character_id` int(10) unsigned DEFAULT NULL,
  `character_faction` enum('INDEP','SLF','BIS','ASI','PSIS','HSH','TCD') NOT NULL DEFAULT 'INDEP',
  `objective_type` text NOT NULL,
  `objective_side` enum('pro_synth','anti_synth') NOT NULL,
  `objective_outcome` tinyint(1) DEFAULT '0',
  `objective_datetime` datetime NOT NULL,
  `duplicate` int(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for death statistics
--

CREATE TABLE `ss13_death` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pod` text CHARACTER SET latin1 NOT NULL COMMENT 'Place of death',
  `coord` text CHARACTER SET latin1 NOT NULL COMMENT 'X, Y, Z POD',
  `tod` datetime NOT NULL COMMENT 'Time of death',
  `job` text CHARACTER SET latin1 NOT NULL,
  `special` text CHARACTER SET latin1 NOT NULL,
  `name` text CHARACTER SET latin1 NOT NULL,
  `byondkey` text CHARACTER SET latin1 NOT NULL,
  `laname` text CHARACTER SET latin1 NOT NULL COMMENT 'Last attacker name',
  `lakey` text CHARACTER SET latin1 NOT NULL COMMENT 'Last attacker key',
  `gender` text CHARACTER SET latin1 NOT NULL,
  `bruteloss` int(11) NOT NULL,
  `brainloss` int(11) NOT NULL,
  `fireloss` int(11) NOT NULL,
  `oxyloss` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for housing station directives
--

CREATE TABLE `ss13_directives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 NOT NULL,
  `data` text CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for round statistics
--

CREATE TABLE `ss13_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `game_id` varchar(32) NOT NULL,
  `var_name` varchar(32) CHARACTER SET latin1 NOT NULL,
  `var_value` int(16) DEFAULT NULL,
  `details` text CHARACTER SET latin1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for ingame forms
--

CREATE TABLE `ss13_forms` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(4) CHARACTER SET latin1 NOT NULL,
  `name` varchar(50) CHARACTER SET latin1 NOT NULL,
  `department` varchar(32) CHARACTER SET latin1 NOT NULL,
  `data` text CHARACTER SET latin1 NOT NULL,
  `info` text CHARACTER SET latin1,
  PRIMARY KEY (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for tracking IPC implants
--

CREATE TABLE `ss13_ipc_tracking` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player_ckey` varchar(32) NOT NULL,
  `character_name` varchar(255) NOT NULL,
  `tag_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table for the ingame library
--

CREATE TABLE `ss13_library` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` text CHARACTER SET latin1 NOT NULL,
  `title` text CHARACTER SET latin1 NOT NULL,
  `content` text CHARACTER SET latin1 NOT NULL,
  `category` text CHARACTER SET latin1 NOT NULL,
  `uploadtime` datetime NOT NULL,
  `uploader` varchar(32) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for player notes
--

CREATE TABLE `ss13_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adddate` datetime NOT NULL,
  `ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `ip` varchar(18) CHARACTER SET latin1 DEFAULT NULL,
  `computerid` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `a_ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `content` text CHARACTER SET latin1 NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `edited` tinyint(1) NOT NULL DEFAULT '0',
  `lasteditor` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `lasteditdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for ingame poll options
--

CREATE TABLE `ss13_poll_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pollid` int(11) NOT NULL,
  `text` varchar(255) CHARACTER SET latin1 NOT NULL,
  `percentagecalc` tinyint(1) NOT NULL DEFAULT '1',
  `minval` int(3) DEFAULT NULL,
  `maxval` int(3) DEFAULT NULL,
  `descmin` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `descmid` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `descmax` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for ingame poll questions
--

CREATE TABLE `ss13_poll_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `polltype` varchar(16) CHARACTER SET latin1 NOT NULL DEFAULT 'OPTION',
  `starttime` datetime NOT NULL,
  `endtime` datetime NOT NULL,
  `question` varchar(255) CHARACTER SET latin1 NOT NULL,
  `multiplechoiceoptions` int(11) DEFAULT NULL,
  `adminonly` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for ingame poll text/freeform replies
--

CREATE TABLE `ss13_poll_textreply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  `pollid` int(11) NOT NULL,
  `ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `ip` varchar(18) CHARACTER SET latin1 NOT NULL,
  `replytext` text CHARACTER SET latin1 NOT NULL,
  `adminrank` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT 'Player',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for ingame poll votes
--

CREATE TABLE `ss13_poll_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  `pollid` int(11) NOT NULL,
  `optionid` int(11) NOT NULL,
  `ckey` varchar(255) CHARACTER SET latin1 NOT NULL,
  `ip` varchar(16) CHARACTER SET latin1 NOT NULL,
  `adminrank` varchar(32) CHARACTER SET latin1 NOT NULL,
  `rating` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for tracking ingame population counts
--

CREATE TABLE `ss13_population` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `playercount` int(11) DEFAULT NULL,
  `admincount` int(11) DEFAULT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for player privacy preferences
--

CREATE TABLE `ss13_privacy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  `ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `option` varchar(128) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for ingame santa clause event
--

CREATE TABLE `ss13_santa` (
  `character_name` varchar(32) NOT NULL,
  `participation_status` tinyint(1) NOT NULL DEFAULT '1',
  `is_assigned` tinyint(1) NOT NULL DEFAULT '0',
  `mark_name` varchar(32) DEFAULT NULL,
  `character_gender` varchar(32) NOT NULL,
  `character_species` varchar(32) NOT NULL,
  `character_job` varchar(32) NOT NULL,
  `character_like` mediumtext NOT NULL,
  `gift_assigned` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`character_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table for syndicate contracts
--

CREATE TABLE `ss13_syndie_contracts` (
  `contract_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contractee_id` int(11) NOT NULL,
  `contractee_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('new','open','mod-nok','completed','closed','reopened','canceled') COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `reward_credits` int(11) DEFAULT NULL,
  `reward_other` text COLLATE utf8_unicode_ci,
  `completer_id` int(11) DEFAULT NULL,
  `completer_name` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`contract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table for comments to syndicate contracts
--

CREATE TABLE `ss13_syndie_contracts_comments` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) unsigned NOT NULL,
  `commentor_id` int(11) unsigned NOT NULL,
  `commentor_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `image_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('mod-author','mod-ooc','ic','ic-comprep','ic-failrep','ic-cancel','ooc') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `report_status` enum('waiting-approval','accepted','rejected') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `contract_id` (`contract_id`),
  CONSTRAINT `contract_id` FOREIGN KEY (`contract_id`) REFERENCES `ss13_syndie_contracts` (`contract_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Bridge table between contract comment data and player table
--

CREATE TABLE `ss13_syndie_contracts_comments_completers` (
  `user_id` int(11) NOT NULL,
  `comment_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`comment_id`),
  KEY `comment_id` (`comment_id`),
  CONSTRAINT `comment_id` FOREIGN KEY (`comment_id`) REFERENCES `ss13_syndie_contracts_comments` (`comment_id`) ON DELETE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `ss13_player` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table for individual contract objectives
--

CREATE TABLE `ss13_syndie_contracts_objectives` (
  `objective_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL,
  `status` enum('open','closed','deleted') COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `reward_credits` int(11) DEFAULT NULL,
  `reward_credits_update` int(11) DEFAULT NULL,
  `reward_other` text COLLATE utf8_unicode_ci,
  `reward_other_update` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`objective_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Bridge table between contract objectives and comments
--

CREATE TABLE `ss13_syndie_contracts_comments_objectives` (
  `objective_id` int(10) unsigned NOT NULL,
  `comment_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`objective_id`,`comment_id`),
  KEY `comments_comment_id` (`comment_id`),
  CONSTRAINT `comments_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `ss13_syndie_contracts_comments` (`comment_id`) ON DELETE CASCADE,
  CONSTRAINT `objectives_objective_id` FOREIGN KEY (`objective_id`) REFERENCES `ss13_syndie_contracts_objectives` (`objective_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table for contract subscribers
--

CREATE TABLE `ss13_syndie_contracts_subscribers` (
  `contract_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`contract_id`,`user_id`),
  CONSTRAINT `syndie_contracts_subscribers_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `ss13_syndie_contracts` (`contract_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table for player warnings
--

CREATE TABLE `ss13_warnings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `severity` tinyint(1) DEFAULT '0',
  `reason` text CHARACTER SET latin1 NOT NULL,
  `notes` text CHARACTER SET latin1,
  `ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `computerid` varchar(32) CHARACTER SET latin1 NOT NULL,
  `ip` varchar(32) CHARACTER SET latin1 NOT NULL,
  `a_ckey` varchar(32) CHARACTER SET latin1 NOT NULL,
  `a_computerid` varchar(32) DEFAULT NULL,
  `a_ip` varchar(32) DEFAULT NULL,
  `acknowledged` tinyint(1) DEFAULT '0',
  `expired` tinyint(1) DEFAULT '0',
  `visible` tinyint(1) DEFAULT '1',
  `edited` tinyint(1) DEFAULT '0',
  `lasteditor` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `lasteditdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table for housing tokens for the WebInterface SSO from within the game
--

CREATE TABLE `ss13_web_sso` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ckey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table for logging whitelist alterations
--

CREATE TABLE `ss13_whitelist_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  `user` varchar(32) NOT NULL,
  `action_method` varchar(32) NOT NULL DEFAULT 'Game Server',
  `action` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table for storing whitelist bitkeys
--

CREATE TABLE `ss13_whitelist_statuses` (
  `flag` int(10) unsigned NOT NULL,
  `status_name` varchar(32) NOT NULL,
  `subspecies` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`status_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Adds parallax related preferences toggles for the player preferences table.
--

ALTER TABLE `ss13_player_preferences`
	ADD `parallax_toggles` INT(11) NULL DEFAULT NULL,
	ADD `parallax_speed` INT(11) NULL DEFAULT NULL;
--
-- Adds the IP intel database table.
--

CREATE TABLE `ss13_ipintel` (
  `ip` varbinary(16) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `intel` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`ip`),
  KEY `idx_ipintel` (`ip`,`intel`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `ss13_player`
  ADD `account_join_date` DATE NULL DEFAULT NULL AFTER `whitelist_status`;
--
-- Implemented in PR #2098.
-- Adds character signature fields to the database.
--

ALTER TABLE `ss13_characters_flavour`
	ADD `signature` TINYTEXT NULL DEFAULT NULL AFTER `char_id`,
	ADD `signature_font` TINYTEXT NULL DEFAULT NULL AFTER `signature`;
--
-- Implemented in PR #2607.
-- Character body marking migration file
--

ALTER TABLE `ss13_characters`
  ADD `body_markings` TEXT NULL DEFAULT NULL AFTER `organs_robotic`;
--
-- Implemented in PR #2863.
-- Removes unused privacy table.
--

DROP TABLE `ss13_privacy`;
--
-- Implemented in PR #3119.
-- Renames some tables in the mirrors table to make it more readable.
-- Adds more useful data points.
--

ALTER TABLE `ss13_ban_mirrors`
  CHANGE `ban_mirror_id` `id` INT(10) UNSIGNED NOT NULL,
  CHANGE `player_ckey` `ckey` VARCHAR(32) NOT NULL,
  CHANGE `ban_mirror_ip` `ip` VARCHAR(32) NOT NULL,
  CHANGE `ban_mirror_computerid` `computerid` VARCHAR(32) NOT NULL,
  CHANGE `ban_mirror_datetime` `datetime` DATETIME NOT NULL,
  ADD `source` ENUM('legacy', 'conninfo', 'isbanned') NOT NULL AFTER `datetime`,
  ADD `extra_info` TEXT NULL DEFAULT NULL AFTER `source`;
--
-- A patch to fix a field in ss13_ban_mirrors.
--

ALTER TABLE `ss13_ban_mirrors` CHANGE `id` `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Create the Cargo Database
--

CREATE TABLE `ss13_cargo_categories` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL COLLATE 'utf8_bin',
	`display_name` VARCHAR(100) NOT NULL COLLATE 'utf8_bin',
	`description` VARCHAR(300) NOT NULL COLLATE 'utf8_bin',
	`icon` VARCHAR(50) NOT NULL COLLATE 'utf8_bin',
	`price_modifier` FLOAT UNSIGNED NOT NULL DEFAULT '1',
	`order_by` VARCHAR(5) NULL DEFAULT NULL COLLATE 'utf8_bin',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`deleted_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name` (`name`)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
;

CREATE TABLE `ss13_cargo_items` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`path` VARCHAR(150) NOT NULL COLLATE 'utf8_bin',
	`name` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_bin',
	`description` VARCHAR(300) NULL DEFAULT NULL COLLATE 'utf8_bin',
	`categories` VARCHAR(300) NOT NULL COMMENT 'JSON list of categories' COLLATE 'utf8_bin',
	`suppliers` TEXT NULL COMMENT 'JSTON list of suppliers' COLLATE 'utf8_bin',
	`amount` INT(10) UNSIGNED NOT NULL DEFAULT '1',
	`access` INT(10) UNSIGNED NULL DEFAULT NULL,
	`container_type` VARCHAR(50) NOT NULL DEFAULT 'crate' COLLATE 'utf8_bin',
	`groupable` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
	`order_by` VARCHAR(5) NULL DEFAULT NULL COLLATE 'utf8_bin',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`deleted_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `path` (`path`)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
;

CREATE TABLE `ss13_cargo_suppliers` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`short_name` VARCHAR(50) NOT NULL COLLATE 'utf8_bin',
	`name` VARCHAR(100) NOT NULL COLLATE 'utf8_bin',
	`description` VARCHAR(300) NOT NULL COLLATE 'utf8_bin',
	`tag_line` VARCHAR(300) NOT NULL COLLATE 'utf8_bin',
	`shuttle_time` INT(11) UNSIGNED NOT NULL,
	`shuttle_price` INT(11) UNSIGNED NOT NULL,
	`available` TINYINT(4) UNSIGNED NOT NULL DEFAULT '1',
	`price_modifier` FLOAT UNSIGNED NOT NULL DEFAULT '1',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`deleted_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `Schlüssel 2` (`short_name`)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
;
--
-- Implemented in PR #3653.
-- Renames parallax toggles to a more generic name.
--

ALTER TABLE `ss13_player_preferences`
  CHANGE `parallax_toggles` `toggles_secondary` INT(11) NULL DEFAULT NULL;CREATE TABLE `ss13_webhooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` longtext NOT NULL,
  `tags` longtext NOT NULL,
  `mention` varchar(32),
  `dateadded` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);
--
-- Implemented in PR #4026.
-- Adds a deleted_at column for mirrors.
-- Also adds indexes for speeding up search queries around the ban database.
--

ALTER TABLE `ss13_ban_mirrors`
  ADD `deleted_at` DATETIME NULL DEFAULT NULL AFTER `extra_info`;

CREATE INDEX `idx_mirrors_isbanned` ON `ss13_ban_mirrors` (
  `deleted_at`,
  `ckey`,
  `ip`,
  `computerid`
);

CREATE INDEX `idx_mirrors_select` ON `ss13_ban_mirrors` (
  `deleted_at`,
  `ban_id`
);

CREATE INDEX `idx_ban_isbanned` ON `ss13_ban` (
  `unbanned`,
  `bantype`,
  `expiration_time`,
  `ckey`,
  `computerid`,
  `ip`
);
--
-- Implemented in PR #3388
-- Renames 'Industrial Frame' to 'Hephaestus G1 Industrial Frame'
--

UPDATE `ss13_characters` SET species = "Hephaestus G1 Industrial Frame" WHERE species = "Industrial Frame";
--
-- Implemented in PR #4099.
-- Adds a `backbag_style` column for bag preferences.
--

ALTER TABLE `ss13_characters`
	ADD COLUMN `backbag_style` INT(11) NULL DEFAULT NULL AFTER `backbag`;
--
-- Logs the byond version and byond build in the player table and the connection log.
--

ALTER TABLE `ss13_player`
	ADD COLUMN `byond_version` INT(10) NULL DEFAULT NULL AFTER `computerid`;
ALTER TABLE `ss13_player`
	ADD COLUMN `byond_build` INT(10) NULL DEFAULT NULL AFTER `byond_version`;

ALTER TABLE `ss13_connection_log`
	ADD COLUMN `byond_version` INT(10) NULL DEFAULT NULL AFTER `computerid`;
ALTER TABLE `ss13_connection_log`
	ADD COLUMN `byond_build` INT(10) NULL DEFAULT NULL AFTER `byond_version`;--
-- Implemented in PR #4429
--

ALTER TABLE `ss13_poll_question`
	ADD COLUMN `createdby_ckey` VARCHAR(50) NULL DEFAULT NULL AFTER `adminonly`,
	ADD COLUMN `createdby_ip` VARCHAR(50) NULL DEFAULT NULL AFTER `createdby_ckey`,
	ADD COLUMN `publicresult` TINYINT(1) NOT NULL DEFAULT '0' AFTER `adminonly`,
	ADD COLUMN `viewtoken` VARCHAR(50) NULL DEFAULT NULL AFTER `publicresult`;
--
-- Implemented in PR #4432
-- Adds a table for gathering statistics regarding tickets.
--

CREATE TABLE `ss13_tickets` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `game_id` VARCHAR(32) NOT NULL,
  `message_count` INT(11) NOT NULL,
  `admin_count` INT(11) NOT NULL,
  `admin_list` TEXT NOT NULL,
  `opened_by` VARCHAR(32) NOT NULL,
  `taken_by` VARCHAR(32) NOT NULL,
  `closed_by` VARCHAR(32) NOT NULL,
  `response_delay` INT(11) NOT NULL,
  `opened_at` DATETIME NOT NULL,
  `closed_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `tickets_fk_opened` FOREIGN KEY (`opened_by`) REFERENCES `ss13_player` (`ckey`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tickets_fk_taken` FOREIGN KEY (`taken_by`) REFERENCES `ss13_player` (`ckey`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tickets_fk_closed` FOREIGN KEY (`closed_by`) REFERENCES `ss13_player` (`ckey`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Changes the Cargo Schema to allow grouping multiple items into one virtual item
-- Implemented in #4435
--

ALTER TABLE `ss13_cargo_items`
	DROP INDEX `path`;

ALTER TABLE `ss13_cargo_items`
	ADD COLUMN `supplier` VARCHAR(50) NOT NULL DEFAULT 'nt' AFTER `name`,
	ADD COLUMN `price` INT(11) NOT NULL AFTER `categories`,
	ADD COLUMN `items` TEXT NULL COMMENT 'JSON list of all the items and their attributes' AFTER `price`,
	CHANGE COLUMN `amount` `item_mul` INT(10) UNSIGNED NOT NULL DEFAULT '1' AFTER `items`,
	CHANGE COLUMN `access` `access` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `item_mul`,
	CHANGE COLUMN `suppliers` `suppliers_old` TEXT NULL COMMENT 'JSON list of suppliers' COLLATE 'utf8_bin' AFTER `deleted_at`,
	CHANGE COLUMN `path` `path_old` VARCHAR(150) NOT NULL COLLATE 'utf8_bin' AFTER `suppliers_old`;--
-- RReadds the unique index (previously on path)
-- Done in a separate migration to prevent locking up the previous migration if duplicate itemnames are in the db
-- Implemented in #4435
--

ALTER TABLE `ss13_cargo_items`
	ADD UNIQUE INDEX `name_supplier` (`name`, `supplier`);--
-- Adds different disabilities into the loadout
-- Implemented in #4485
--
ALTER TABLE `ss13_characters`
    CHANGE COLUMN `disabilities` `disabilities` TEXT NULL DEFAULT NULL AFTER `alternate_titles`;
    
UPDATE `ss13_characters` SET `disabilities` = NULL WHERE `disabilities` = 0;

UPDATE `ss13_characters` SET `disabilities` = "[\"Nearsightedness\"]" WHERE `disabilities` = 1;
--
-- Combines the ss13_admin and ss13_player table
--
ALTER TABLE `ss13_player`
	ADD COLUMN `rank` VARCHAR(32) NULL DEFAULT NULL AFTER `migration_status`,
	ADD COLUMN `flags` INT(32) UNSIGNED NOT NULL DEFAULT '0',
	ADD COLUMN `discord_id` VARCHAR(45) NULL DEFAULT NULL AFTER `flags`;

UPDATE `ss13_admin`
SET `flags` = 0
WHERE `rank` = "Removed";

UPDATE `ss13_player`
INNER JOIN `ss13_admin` ON ss13_admin.ckey = ss13_player.ckey
SET
	ss13_player.rank = ss13_admin.rank,
	ss13_player.flags = ss13_admin.flags,
	ss13_player.discord_id = ss13_admin.discord_id;

UPDATE `ss13_player`
SET `rank` = NULL
WHERE `rank` = "Removed";

ALTER TABLE `ss13_admin`
	DROP FOREIGN KEY `ckey`;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
DROP TABLE `ss13_admin`;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;--
-- Allow null in path_old and set the default to null for suppliers_old and path_old
--
ALTER TABLE `ss13_cargo_items`
	CHANGE COLUMN `suppliers_old` `suppliers_old` TEXT NULL DEFAULT NULL COMMENT 'JSON list of suppliers' AFTER `deleted_at`,
	CHANGE COLUMN `path_old` `path_old` VARCHAR(150) NULL DEFAULT NULL AFTER `suppliers_old`;

--
-- Fixes a bug by allowing the "Taken by" admin to be null.
--

ALTER TABLE `ss13_tickets`
  MODIFY `taken_by` VARCHAR(32) NULL DEFAULT NULL;
--
-- Allows to add a link to the poll
--

ALTER TABLE `ss13_poll_question`
  ADD COLUMN `link` VARCHAR(250) NULL DEFAULT NULL AFTER `createdby_ip`;
--
-- Combines the ss13_admin and ss13_player table
--
ALTER TABLE `ss13_cargo_items`
	ADD COLUMN `created_by` VARCHAR(50) NULL DEFAULT NULL AFTER `order_by`,
	ADD COLUMN `approved_by` VARCHAR(50) NULL DEFAULT NULL AFTER `created_by`,
	ADD COLUMN `approved_at` DATETIME NULL DEFAULT NULL AFTER `created_at`;

UPDATE ss13_cargo_items SET approved_at = NOW()--
-- Adds a new table to load the regulations ("laws") from
--
CREATE TABLE `ss13_law` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`law_id` VARCHAR(4) NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`description` VARCHAR(500) NOT NULL,
	`min_fine` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`max_fine` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`min_brig_time` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`max_brig_time` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`severity` INT(10) UNSIGNED NULL DEFAULT '0',
	`felony` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`deleted_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `UNIQUE_LAW` (`law_id`)
)
ENGINE=InnoDB;--
-- Adds a new table to load news from
--
CREATE TABLE `ss13_news_channels` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	`author` VARCHAR(50) NOT NULL,
	`locked` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
	`is_admin_channel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
	`announcement` VARCHAR(200) NOT NULL,
	`created_by` VARCHAR(50) NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`deleted_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB;

CREATE TABLE `ss13_news_stories` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`channel_id` INT(11) NOT NULL,
	`author` VARCHAR(50) NOT NULL,
	`body` TEXT NOT NULL,
	`message_type` VARCHAR(50) NOT NULL DEFAULT 'Story',
	`is_admin_message` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
	`time_stamp` DATETIME NULL DEFAULT NULL,
	`created_by` VARCHAR(50) NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`deleted_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_ss13_news_stories_ss13_news_channels` (`channel_id`),
	CONSTRAINT `FK_ss13_news_stories_ss13_news_channels` FOREIGN KEY (`channel_id`) REFERENCES `ss13_news_channels` (`id`)
)
ENGINE=InnoDB;--
-- Serverside changes to allow News published by players
--
ALTER TABLE `ss13_news_stories`
	CHANGE COLUMN `time_stamp` `publish_at` DATETIME NULL DEFAULT NULL AFTER `is_admin_message`,
	ADD COLUMN `publish_until` DATETIME NULL DEFAULT NULL AFTER `publish_at`,
	ADD COLUMN `ic_timestamp` DATETIME NULL DEFAULT NULL AFTER `publish_until`,
	ADD COLUMN `approved_by` VARCHAR(50) NULL DEFAULT NULL AFTER `created_at`,
	ADD COLUMN `approved_at` DATETIME NULL DEFAULT NULL AFTER `approved_by`,
	ADD COLUMN `url` VARCHAR(250) NULL DEFAULT NULL AFTER `publish_until`;

ALTER TABLE `ss13_news_channels`
	CHANGE COLUMN `announcement` `announcement` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_bin' AFTER `is_admin_channel`;--
-- Notifications for Players
--
CREATE TABLE `ss13_player_notifications` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ckey` VARCHAR(50) NOT NULL COLLATE 'utf8_bin',
	`type` ENUM('player_greeting','player_greeting_chat','admin','ccia') NOT NULL COLLATE 'utf8_bin',
	`message` VARCHAR(50) NOT NULL COLLATE 'utf8_bin',
	`created_by` VARCHAR(50) NOT NULL COLLATE 'utf8_bin',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`acked_by` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_bin',
	`acked_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_bin'
ENGINE=InnoDB;--
-- Adds HTML style value to the player preferences table.
--

ALTER TABLE `ss13_player_preferences`
	ADD `html_UI_style` VARCHAR(32) DEFAULT 'Nano';
--
-- Adds HTML style value to the player preferences table.
--

ALTER TABLE `ss13_ccia_actions`
	CHANGE COLUMN `type` `type` ENUM('injunction','suspension','warning','reprimand','demotion','other') NOT NULL COLLATE 'utf8_unicode_ci' AFTER `title`;

UPDATE ss13_ccia_actions SET type = "reprimand" WHERE type = "warning";

ALTER TABLE `ss13_ccia_actions`
	CHANGE COLUMN `type` `type` ENUM('injunction','suspension','reprimand','demotion','other') NOT NULL COLLATE 'utf8_unicode_ci' AFTER `title`;--
-- Adds alt_title logging to the ss13_characters_log
--

ALTER TABLE `ss13_characters_log`
	ADD COLUMN `alt_title` VARCHAR(32) NULL DEFAULT NULL AFTER `job_name`;
--
-- Renaming colomn because we are fixing spelling
--

ALTER TABLE `ss13_characters_flavour`
    CHANGE COLUMN `robot_miner` `robot_mining` TEXT NULL DEFAULT NULL AFTER `robot_rescue`;
--
-- Adds a new table specifically for tracking antagonist assignments
--

ALTER TABLE `ss13_characters_log`
	DROP COLUMN `special_role`;

CREATE TABLE `ss13_antag_log` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`ckey` VARCHAR(32) NOT NULL,
	`char_id` INT(11) NULL DEFAULT NULL,
	`game_id` VARCHAR(50) NOT NULL,
	`char_name` VARCHAR(50) NOT NULL,
	`datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`special_role_name` VARCHAR(50) NOT NULL,
	`special_role_added` TIME NOT NULL,
	`special_role_removed` TIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_ss13_antag_log_ss13_characters` (`char_id`),
	CONSTRAINT `FK_ss13_antag_log_ss13_characters` FOREIGN KEY (`char_id`) REFERENCES `ss13_characters` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;--
-- Adds a game_id column to the connection log
--

ALTER TABLE `ss13_connection_log`
	ADD COLUMN `game_id` VARCHAR(50) NULL DEFAULT NULL AFTER `byond_build`;--
-- Create the Documents database.
--

CREATE TABLE `ss13_documents` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL,
	`title` VARCHAR(26) NOT NULL,
	`chance` FLOAT UNSIGNED NOT NULL DEFAULT '1',
	`content` VARCHAR(3072) NOT NULL,
	`tags` JSON NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`deleted_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name` (`name`)
)
COLLATE='utf8_bin'
ENGINE=InnoDB
;
--
-- Sets the faction variable to NanoTrasen for the factions PR.
--

UPDATE ss13_characters SET faction = "NanoTrasen";
--
-- Adds tables to store ccia interviews
--

CREATE TABLE `ss13_ccia_reports` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`report_date` DATE NOT NULL,
	`title` VARCHAR(200) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`status` ENUM('new','approved','rejected','completed') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`deleted_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
;

CREATE TABLE `ss13_ccia_reports_transcripts` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`report_id` INT(11) NOT NULL,
	`character_id` INT(11) NOT NULL,
	`interviewer` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`text` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`deleted_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `report_id` (`report_id`),
	INDEX `character_id` (`character_id`),
	CONSTRAINT `report_id` FOREIGN KEY (`report_id`) REFERENCES `ss13_ccia_reports` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
;
--
-- Tables for holding stickyban/PRISM stuff.
--

CREATE TABLE `ss13_stickyban` (
	`ckey` VARCHAR(32) NOT NULL,
	`reason` VARCHAR(2048) NOT NULL,
	`banning_admin` VARCHAR(32) NOT NULL,
	`datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`ckey`)
) ENGINE=InnoDB;

CREATE TABLE `ss13_stickyban_matched_ckey` (
	`stickyban` VARCHAR(32) NOT NULL,
	`matched_ckey` VARCHAR(32) NOT NULL,
	`first_matched` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`last_matched` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`exempt` TINYINT(1) NOT NULL DEFAULT '0',
	PRIMARY KEY (`stickyban`, `matched_ckey`)
) ENGINE=InnoDB;

CREATE TABLE `ss13_stickyban_matched_ip` (
	`stickyban` VARCHAR(32) NOT NULL,
	`matched_ip` INT UNSIGNED NOT NULL,
	`first_matched` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`last_matched` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`stickyban`, `matched_ip`)
) ENGINE=InnoDB;

CREATE TABLE `ss13_stickyban_matched_cid` (
	`stickyban` VARCHAR(32) NOT NULL,
	`matched_cid` VARCHAR(32) NOT NULL,
	`first_matched` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`last_matched` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`stickyban`, `matched_cid`)
) ENGINE=InnoDB;
--
-- Create the Custom Synths database.
--

CREATE TABLE `ss13_customsynths` (
    `synthname` VARCHAR(128) NOT NULL,
    `synthckey` varchar(32) CHARACTER SET latin1 NOT NULL,
    `synthicon` VARCHAR(26) NOT NULL,
    `aichassisicon` VARCHAR(100) NOT NULL,
    `aiholoicon` VARCHAR(100) NOT NULL,
    `paiicon` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`synthname`),
    CONSTRAINT `fk_ss13_custom_synths_ss13_players` FOREIGN KEY (`synthckey`) REFERENCES `ss13_player` (`ckey`) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
;
--
-- Cleans up the database
--

-- This is specifically created for the current Aurorastation Database.
-- IF YOU RUN THIS ON YOUR DOWNSTREAM SERVER IT IS STRONGLY ADVICED TO EXECUTE THIS IN A TEST SYTEM FIRST AND FIX POTENTIAL ERRORS

-- Delete unused git_pull tables
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `ss13_git_pull_todo_stats`;
DROP TABLE IF EXISTS `ss13_git_pull_todos`;
DROP TABLE IF EXISTS `ss13_git_pull_requests`;
DROP TABLE IF EXISTS `ss13_santa`;
DROP TABLE IF EXISTS `ss13_contest_participants`;
DROP TABLE IF EXISTS `ss13_contest_reports`;
DROP TABLE IF EXISTS `ss13_directives`;


-- Fix data issues
UPDATE ss13_ban SET expiration_time = bantime WHERE expiration_time = 0;
UPDATE ss13_library SET uploadtime = "2015-04-26" WHERE uploadtime = 0;
UPDATE 
	ss13_news_stories 
SET 
	publish_at = created_at, 
	publish_until = DATE_ADD(created_at, INTERVAL 7 DAY), 
	ic_timestamp = DATE_ADD(created_at, INTERVAL 442 YEAR)
WHERE
	publish_at = 0 OR
	publish_until = 0 OR 
	ic_timestamp = 0;

-- Update charset and collation
ALTER TABLE `discord_bans`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `discord_bans`
	ALTER `user_id` DROP DEFAULT,
	ALTER `user_name` DROP DEFAULT,
	ALTER `server_id` DROP DEFAULT,
	ALTER `ban_type` DROP DEFAULT;
ALTER TABLE `discord_bans`
	CHANGE COLUMN `user_id` `user_id` VARCHAR(45) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `user_name` `user_name` VARCHAR(45) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `user_id`,
	CHANGE COLUMN `server_id` `server_id` VARCHAR(45) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `user_name`,
	CHANGE COLUMN `ban_type` `ban_type` VARCHAR(45) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `server_id`,
	CHANGE COLUMN `ban_reason` `ban_reason` LONGTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ban_duration`,
	CHANGE COLUMN `admin_id` `admin_id` VARCHAR(45) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `expiration_time`,
	CHANGE COLUMN `admin_name` `admin_name` VARCHAR(45) NULL DEFAULT 'BOREALIS' COLLATE 'utf8mb4_unicode_ci' AFTER `admin_id`;

ALTER TABLE `discord_channels`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `discord_channels`
	ALTER `channel_group` DROP DEFAULT;
ALTER TABLE `discord_channels`
	CHANGE COLUMN `channel_group` `channel_group` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `channel_id` `channel_id` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `channel_group`,
	CHANGE COLUMN `server_id` `server_id` VARCHAR(45) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci' AFTER `pin_flag`;

ALTER TABLE `discord_log`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `discord_log`
	CHANGE COLUMN `action` `action` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `action_time`,
	CHANGE COLUMN `admin_id` `admin_id` VARCHAR(45) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `action`,
	CHANGE COLUMN `user_id` `user_id` VARCHAR(45) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `admin_id`;

ALTER TABLE `discord_strikes`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `discord_strikes`
	ALTER `user_id` DROP DEFAULT,
	ALTER `user_name` DROP DEFAULT,
	ALTER `admin_id` DROP DEFAULT,
	ALTER `admin_name` DROP DEFAULT;
ALTER TABLE `discord_strikes`
	CHANGE COLUMN `user_id` `user_id` VARCHAR(45) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `user_name` `user_name` VARCHAR(45) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `user_id`,
	CHANGE COLUMN `action_type` `action_type` VARCHAR(45) NOT NULL DEFAULT 'WARNING' COLLATE 'utf8mb4_unicode_ci' AFTER `user_name`,
	CHANGE COLUMN `admin_id` `admin_id` VARCHAR(45) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `strike_time`,
	CHANGE COLUMN `admin_name` `admin_name` VARCHAR(45) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `admin_id`;

ALTER TABLE `discord_subscribers`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `discord_subscribers`
	ALTER `user_id` DROP DEFAULT;
ALTER TABLE `discord_subscribers`
	CHANGE COLUMN `user_id` `user_id` VARCHAR(45) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`;

ALTER TABLE `ss13_admin_log`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_admin_log`
	ALTER `adminckey` DROP DEFAULT,
	ALTER `adminip` DROP DEFAULT;
ALTER TABLE `ss13_admin_log`
	CHANGE COLUMN `adminckey` `adminckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `datetime`,
	CHANGE COLUMN `adminip` `adminip` VARCHAR(18) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `adminckey`,
	CHANGE COLUMN `log` `log` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `adminip`;

ALTER TABLE `ss13_antag_log`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_antag_log`
	ALTER `ckey` DROP DEFAULT,
	ALTER `game_id` DROP DEFAULT,
	ALTER `special_role_name` DROP DEFAULT;
ALTER TABLE `ss13_antag_log`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `game_id` `game_id` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `char_id`,
	CHANGE COLUMN `char_name` `char_name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `game_id`,
	CHANGE COLUMN `special_role_name` `special_role_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `datetime`;

ALTER TABLE `ss13_api_commands`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_api_commands`
	ALTER `command` DROP DEFAULT;
ALTER TABLE `ss13_api_commands`
	CHANGE COLUMN `command` `command` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `description` `description` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `command`;

ALTER TABLE `ss13_api_tokens`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_api_tokens`
	ALTER `token` DROP DEFAULT,
	ALTER `creator` DROP DEFAULT,
	ALTER `description` DROP DEFAULT;
ALTER TABLE `ss13_api_tokens`
	CHANGE COLUMN `token` `token` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `ip` `ip` VARCHAR(16) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `token`,
	CHANGE COLUMN `creator` `creator` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`,
	CHANGE COLUMN `description` `description` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `creator`;

ALTER TABLE `ss13_api_token_command`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;

ALTER TABLE `ss13_ban`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_ban`
	ALTER `serverip` DROP DEFAULT,
	ALTER `bantype` DROP DEFAULT,
	ALTER `ckey` DROP DEFAULT,
	ALTER `computerid` DROP DEFAULT,
	ALTER `ip` DROP DEFAULT,
	ALTER `a_ckey` DROP DEFAULT,
	ALTER `a_computerid` DROP DEFAULT,
	ALTER `a_ip` DROP DEFAULT;
ALTER TABLE `ss13_ban`
	CHANGE COLUMN `serverip` `serverip` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `bantime`,
	CHANGE COLUMN `bantype` `bantype` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `serverip`,
	CHANGE COLUMN `reason` `reason` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `bantype`,
	CHANGE COLUMN `job` `job` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `reason`,
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `expiration_time`,
	CHANGE COLUMN `computerid` `computerid` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `ip` `ip` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `computerid`,
	CHANGE COLUMN `a_ckey` `a_ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`,
	CHANGE COLUMN `a_computerid` `a_computerid` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `a_ckey`,
	CHANGE COLUMN `a_ip` `a_ip` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `a_computerid`,
	CHANGE COLUMN `who` `who` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `a_ip`,
	CHANGE COLUMN `adminwho` `adminwho` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `who`,
	CHANGE COLUMN `edits` `edits` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `adminwho`,
	CHANGE COLUMN `unbanned_reason` `unbanned_reason` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `unbanned_datetime`,
	CHANGE COLUMN `unbanned_ckey` `unbanned_ckey` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `unbanned_reason`,
	CHANGE COLUMN `unbanned_computerid` `unbanned_computerid` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `unbanned_ckey`,
	CHANGE COLUMN `unbanned_ip` `unbanned_ip` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `unbanned_computerid`;

ALTER TABLE `ss13_ban_mirrors`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_ban_mirrors`
	ALTER `ckey` DROP DEFAULT,
	ALTER `ip` DROP DEFAULT,
	ALTER `computerid` DROP DEFAULT,
	ALTER `source` DROP DEFAULT;
ALTER TABLE `ss13_ban_mirrors`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ban_id`,
	CHANGE COLUMN `ip` `ip` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `computerid` `computerid` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`,
	CHANGE COLUMN `source` `source` ENUM('legacy','conninfo','isbanned') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `datetime`,
	CHANGE COLUMN `extra_info` `extra_info` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `source`;

ALTER TABLE `ss13_cargo_categories`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_cargo_categories`
	ALTER `name` DROP DEFAULT,
	ALTER `display_name` DROP DEFAULT,
	ALTER `description` DROP DEFAULT,
	ALTER `icon` DROP DEFAULT;
ALTER TABLE `ss13_cargo_categories`
	CHANGE COLUMN `name` `name` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `display_name` `display_name` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `description` `description` VARCHAR(300) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `display_name`,
	CHANGE COLUMN `icon` `icon` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `description`,
	CHANGE COLUMN `order_by` `order_by` VARCHAR(5) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `price_modifier`;

ALTER TABLE `ss13_cargo_items`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_cargo_items`
	CHANGE COLUMN `name` `name` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `supplier` `supplier` VARCHAR(50) NOT NULL DEFAULT 'nt' COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `description` `description` VARCHAR(300) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `supplier`,
	CHANGE COLUMN `container_type` `container_type` VARCHAR(50) NOT NULL DEFAULT 'crate' COLLATE 'utf8mb4_unicode_ci' AFTER `access`,
	CHANGE COLUMN `order_by` `order_by` VARCHAR(5) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `groupable`,
	CHANGE COLUMN `created_by` `created_by` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `order_by`,
	CHANGE COLUMN `approved_by` `approved_by` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `created_by`,
	DROP COLUMN `suppliers_old`,
	DROP COLUMN `path_old`;
ALTER TABLE `ss13_cargo_items`
	ALTER `categories` DROP DEFAULT;
ALTER TABLE `ss13_cargo_items`
	CHANGE COLUMN `categories` `categories` JSON NOT NULL AFTER `description`,
	CHANGE COLUMN `items` `items` JSON NULL DEFAULT NULL AFTER `price`;

ALTER TABLE `ss13_cargo_suppliers`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_cargo_suppliers`
	ALTER `short_name` DROP DEFAULT,
	ALTER `name` DROP DEFAULT,
	ALTER `description` DROP DEFAULT,
	ALTER `tag_line` DROP DEFAULT;
ALTER TABLE `ss13_cargo_suppliers`
	CHANGE COLUMN `short_name` `short_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `name` `name` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `short_name`,
	CHANGE COLUMN `description` `description` VARCHAR(300) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `tag_line` `tag_line` VARCHAR(300) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `description`;

ALTER TABLE `ss13_ccia_actions`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_ccia_actions`
	ALTER `type` DROP DEFAULT,
	ALTER `issuedby` DROP DEFAULT,
	ALTER `url` DROP DEFAULT;
ALTER TABLE `ss13_ccia_actions`
	CHANGE COLUMN `title` `title` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `type` `type` ENUM('injunction','suspension','reprimand','demotion','other') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `title`,
	CHANGE COLUMN `issuedby` `issuedby` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `type`,
	CHANGE COLUMN `details` `details` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `issuedby`,
	CHANGE COLUMN `url` `url` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `details`;

ALTER TABLE `ss13_ccia_action_char`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;

ALTER TABLE `ss13_ccia_general_notice_list`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_ccia_general_notice_list`
	ALTER `title` DROP DEFAULT;
ALTER TABLE `ss13_ccia_general_notice_list`
	CHANGE COLUMN `title` `title` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `message` `message` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `title`;

ALTER TABLE `ss13_ccia_reports`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_ccia_reports`
	ALTER `title` DROP DEFAULT,
	ALTER `status` DROP DEFAULT;
ALTER TABLE `ss13_ccia_reports`
	CHANGE COLUMN `title` `title` VARCHAR(200) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `report_date`,
	CHANGE COLUMN `status` `status` ENUM('new','in progress','review required','approved','rejected','completed') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `title`;

ALTER TABLE `ss13_ccia_reports_transcripts`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_ccia_reports_transcripts`
	ALTER `interviewer` DROP DEFAULT;
ALTER TABLE `ss13_ccia_reports_transcripts`
	CHANGE COLUMN `interviewer` `interviewer` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `character_id`,
	CHANGE COLUMN `text` `text` LONGTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `character_id`;
  
ALTER TABLE `ss13_characters`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_characters`
	ALTER `ckey` DROP DEFAULT;
ALTER TABLE `ss13_characters`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `name` `name` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `metadata` `metadata` VARCHAR(512) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `be_special_role` `be_special_role` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `metadata`,
	CHANGE COLUMN `gender` `gender` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `be_special_role`,
	CHANGE COLUMN `species` `species` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `age`,
	CHANGE COLUMN `language` `language` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `species`,
	CHANGE COLUMN `hair_colour` `hair_colour` VARCHAR(7) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `language`,
	CHANGE COLUMN `facial_colour` `facial_colour` VARCHAR(7) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `hair_colour`,
	CHANGE COLUMN `skin_colour` `skin_colour` VARCHAR(7) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `skin_tone`,
	CHANGE COLUMN `hair_style` `hair_style` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `skin_colour`,
	CHANGE COLUMN `facial_style` `facial_style` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `hair_style`,
	CHANGE COLUMN `eyes_colour` `eyes_colour` VARCHAR(7) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `facial_style`,
	CHANGE COLUMN `underwear` `underwear` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `eyes_colour`,
	CHANGE COLUMN `undershirt` `undershirt` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `underwear`,
	CHANGE COLUMN `socks` `socks` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `undershirt`,
	CHANGE COLUMN `b_type` `b_type` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `backbag_style`,
	CHANGE COLUMN `spawnpoint` `spawnpoint` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `b_type`,
	CHANGE COLUMN `jobs` `jobs` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `spawnpoint`,
	CHANGE COLUMN `alternate_titles` `alternate_titles` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `alternate_option`,
	CHANGE COLUMN `disabilities` `disabilities` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `alternate_titles`,
	CHANGE COLUMN `skills` `skills` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `disabilities`,
	CHANGE COLUMN `skill_specialization` `skill_specialization` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `skills`,
	CHANGE COLUMN `home_system` `home_system` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `skill_specialization`,
	CHANGE COLUMN `citizenship` `citizenship` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `home_system`,
	CHANGE COLUMN `faction` `faction` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `citizenship`,
	CHANGE COLUMN `religion` `religion` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `faction`,
	CHANGE COLUMN `nt_relation` `nt_relation` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `religion`,
	CHANGE COLUMN `uplink_location` `uplink_location` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `nt_relation`,
	CHANGE COLUMN `organs_data` `organs_data` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `uplink_location`,
	CHANGE COLUMN `organs_robotic` `organs_robotic` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `organs_data`,
	CHANGE COLUMN `body_markings` `body_markings` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `organs_robotic`,
	CHANGE COLUMN `gear` `gear` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `body_markings`;

ALTER TABLE `ss13_characters_flavour`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_characters_flavour`
	CHANGE COLUMN `signature` `signature` TEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `char_id`,
	CHANGE COLUMN `signature_font` `signature_font` TEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `signature`,
	CHANGE COLUMN `records_employment` `records_employment` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `signature_font`,
	CHANGE COLUMN `records_medical` `records_medical` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `records_employment`,
	CHANGE COLUMN `records_security` `records_security` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `records_medical`,
	CHANGE COLUMN `records_exploit` `records_exploit` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `records_security`,
	CHANGE COLUMN `records_ccia` `records_ccia` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `records_exploit`,
	CHANGE COLUMN `flavour_general` `flavour_general` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `records_ccia`,
	CHANGE COLUMN `flavour_head` `flavour_head` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flavour_general`,
	CHANGE COLUMN `flavour_face` `flavour_face` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flavour_head`,
	CHANGE COLUMN `flavour_eyes` `flavour_eyes` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flavour_face`,
	CHANGE COLUMN `flavour_torso` `flavour_torso` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flavour_eyes`,
	CHANGE COLUMN `flavour_arms` `flavour_arms` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flavour_torso`,
	CHANGE COLUMN `flavour_hands` `flavour_hands` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flavour_arms`,
	CHANGE COLUMN `flavour_legs` `flavour_legs` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flavour_hands`,
	CHANGE COLUMN `flavour_feet` `flavour_feet` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flavour_legs`,
	CHANGE COLUMN `robot_default` `robot_default` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flavour_feet`,
	CHANGE COLUMN `robot_standard` `robot_standard` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_default`,
	CHANGE COLUMN `robot_engineering` `robot_engineering` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_standard`,
	CHANGE COLUMN `robot_construction` `robot_construction` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_engineering`,
	CHANGE COLUMN `robot_medical` `robot_medical` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_construction`,
	CHANGE COLUMN `robot_rescue` `robot_rescue` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_medical`,
	CHANGE COLUMN `robot_mining` `robot_mining` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_rescue`,
	CHANGE COLUMN `robot_custodial` `robot_custodial` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_mining`,
	CHANGE COLUMN `robot_service` `robot_service` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_custodial`,
	CHANGE COLUMN `robot_clerical` `robot_clerical` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_service`,
	CHANGE COLUMN `robot_security` `robot_security` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_clerical`,
	CHANGE COLUMN `robot_research` `robot_research` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `robot_security`;

ALTER TABLE `ss13_characters_log`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_characters_log`
	ALTER `game_id` DROP DEFAULT;
ALTER TABLE `ss13_characters_log`
	CHANGE COLUMN `game_id` `game_id` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `char_id`,
	CHANGE COLUMN `job_name` `job_name` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `datetime`,
	CHANGE COLUMN `alt_title` `alt_title` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `job_name`;

ALTER TABLE `ss13_character_incidents`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_character_incidents`
	ALTER `UID` DROP DEFAULT,
	ALTER `datetime` DROP DEFAULT,
	ALTER `game_id` DROP DEFAULT;
ALTER TABLE `ss13_character_incidents`
	CHANGE COLUMN `UID` `UID` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `char_id`,
	CHANGE COLUMN `datetime` `datetime` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `UID`,
	CHANGE COLUMN `notes` `notes` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `datetime`,
	CHANGE COLUMN `charges` `charges` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `notes`,
	CHANGE COLUMN `evidence` `evidence` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `charges`,
	CHANGE COLUMN `arbiters` `arbiters` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `evidence`,
	CHANGE COLUMN `created_by` `created_by` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `felony`,
	CHANGE COLUMN `deleted_by` `deleted_by` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `created_by`,
	CHANGE COLUMN `game_id` `game_id` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `deleted_by`;

ALTER TABLE `ss13_connection_log`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_connection_log`
	ALTER `ckey` DROP DEFAULT,
	ALTER `serverip` DROP DEFAULT,
	ALTER `ip` DROP DEFAULT,
	ALTER `computerid` DROP DEFAULT;
ALTER TABLE `ss13_connection_log`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `serverip` `serverip` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `datetime`,
	CHANGE COLUMN `ip` `ip` VARCHAR(18) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `serverip`,
	CHANGE COLUMN `computerid` `computerid` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`,
	CHANGE COLUMN `game_id` `game_id` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `byond_build`;

ALTER TABLE `ss13_customsynths`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_customsynths`
	ALTER `synthname` DROP DEFAULT,
	ALTER `synthckey` DROP DEFAULT,
	ALTER `synthicon` DROP DEFAULT,
	ALTER `aichassisicon` DROP DEFAULT,
	ALTER `aiholoicon` DROP DEFAULT,
	ALTER `paiicon` DROP DEFAULT;
ALTER TABLE `ss13_customsynths`
	CHANGE COLUMN `synthname` `synthname` VARCHAR(128) NOT NULL COLLATE 'utf8mb4_unicode_ci' FIRST,
	CHANGE COLUMN `synthckey` `synthckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `synthname`,
	CHANGE COLUMN `synthicon` `synthicon` VARCHAR(26) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `synthckey`,
	CHANGE COLUMN `aichassisicon` `aichassisicon` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `synthicon`,
	CHANGE COLUMN `aiholoicon` `aiholoicon` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `aichassisicon`,
	CHANGE COLUMN `paiicon` `paiicon` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `aiholoicon`;

ALTER TABLE `ss13_death`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_death`
	CHANGE COLUMN `pod` `pod` MEDIUMTEXT NOT NULL COMMENT 'Place of death' COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `coord` `coord` MEDIUMTEXT NOT NULL COMMENT 'X, Y, Z POD' COLLATE 'utf8mb4_unicode_ci' AFTER `pod`,
	CHANGE COLUMN `job` `job` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `tod`,
	CHANGE COLUMN `special` `special` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `job`,
	CHANGE COLUMN `name` `name` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `special`,
	CHANGE COLUMN `byondkey` `byondkey` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `laname` `laname` MEDIUMTEXT NOT NULL COMMENT 'Last attacker name' COLLATE 'utf8mb4_unicode_ci' AFTER `byondkey`,
	CHANGE COLUMN `lakey` `lakey` MEDIUMTEXT NOT NULL COMMENT 'Last attacker key' COLLATE 'utf8mb4_unicode_ci' AFTER `laname`,
	CHANGE COLUMN `gender` `gender` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `lakey`;

ALTER TABLE `ss13_documents`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_documents`
	ALTER `name` DROP DEFAULT,
	ALTER `title` DROP DEFAULT,
	ALTER `content` DROP DEFAULT;
ALTER TABLE `ss13_documents`
	CHANGE COLUMN `name` `name` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `title` `title` VARCHAR(26) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `content` `content` VARCHAR(3072) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `chance`,
	CHANGE COLUMN `tags` `tags` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `content`;

ALTER TABLE `ss13_feedback`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_feedback`
	ALTER `game_id` DROP DEFAULT,
	ALTER `var_name` DROP DEFAULT;
ALTER TABLE `ss13_feedback`
	CHANGE COLUMN `game_id` `game_id` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `time`,
	CHANGE COLUMN `var_name` `var_name` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `game_id`,
	CHANGE COLUMN `details` `details` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `var_value`;

ALTER TABLE `ss13_forms`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_forms`
	ALTER `id` DROP DEFAULT,
	ALTER `name` DROP DEFAULT,
	ALTER `department` DROP DEFAULT;
ALTER TABLE `ss13_forms`
	CHANGE COLUMN `id` `id` VARCHAR(4) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `form_id`,
	CHANGE COLUMN `name` `name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `department` `department` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `data` `data` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `department`,
	CHANGE COLUMN `info` `info` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `data`;

ALTER TABLE `ss13_ipc_tracking`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_ipc_tracking`
	ALTER `player_ckey` DROP DEFAULT,
	ALTER `character_name` DROP DEFAULT;
ALTER TABLE `ss13_ipc_tracking`
	CHANGE COLUMN `player_ckey` `player_ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `character_name` `character_name` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `player_ckey`;

ALTER TABLE `ss13_ipintel`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;

ALTER TABLE `ss13_law`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_law`
	ALTER `law_id` DROP DEFAULT,
	ALTER `name` DROP DEFAULT,
	ALTER `description` DROP DEFAULT;
ALTER TABLE `ss13_law`
	CHANGE COLUMN `law_id` `law_id` VARCHAR(4) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `name` `name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `law_id`,
	CHANGE COLUMN `description` `description` VARCHAR(500) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`;

ALTER TABLE `ss13_library`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_library`
	ALTER `uploader` DROP DEFAULT;
ALTER TABLE `ss13_library`
	CHANGE COLUMN `author` `author` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `title` `title` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `author`,
	CHANGE COLUMN `content` `content` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `title`,
	CHANGE COLUMN `category` `category` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `content`,
	CHANGE COLUMN `uploader` `uploader` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `uploadtime`;

ALTER TABLE `ss13_news_channels`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_news_channels`
	ALTER `name` DROP DEFAULT,
	ALTER `author` DROP DEFAULT,
	ALTER `created_by` DROP DEFAULT;
ALTER TABLE `ss13_news_channels`
	CHANGE COLUMN `name` `name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `author` `author` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `announcement` `announcement` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `is_admin_channel`,
	CHANGE COLUMN `created_by` `created_by` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `announcement`;

ALTER TABLE `ss13_news_stories`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_news_stories`
	ALTER `author` DROP DEFAULT,
	ALTER `created_by` DROP DEFAULT;
ALTER TABLE `ss13_news_stories`
	CHANGE COLUMN `author` `author` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `channel_id`,
	CHANGE COLUMN `body` `body` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `author`,
	CHANGE COLUMN `message_type` `message_type` VARCHAR(50) NOT NULL DEFAULT 'Story' COLLATE 'utf8mb4_unicode_ci' AFTER `body`,
	CHANGE COLUMN `url` `url` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `publish_until`,
	CHANGE COLUMN `created_by` `created_by` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ic_timestamp`,
	CHANGE COLUMN `approved_by` `approved_by` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `created_at`;

ALTER TABLE `ss13_notes`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_notes`
	ALTER `ckey` DROP DEFAULT,
	ALTER `a_ckey` DROP DEFAULT;
ALTER TABLE `ss13_notes`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `adddate`,
	CHANGE COLUMN `ip` `ip` VARCHAR(18) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `computerid` `computerid` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`,
	CHANGE COLUMN `a_ckey` `a_ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `computerid`,
	CHANGE COLUMN `content` `content` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `a_ckey`,
	CHANGE COLUMN `lasteditor` `lasteditor` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `edited`;

ALTER TABLE `ss13_player`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_player`
	ALTER `ckey` DROP DEFAULT,
	ALTER `ip` DROP DEFAULT,
	ALTER `computerid` DROP DEFAULT;
ALTER TABLE `ss13_player`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `ip` `ip` VARCHAR(18) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `lastseen`,
	CHANGE COLUMN `computerid` `computerid` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`,
	CHANGE COLUMN `lastadminrank` `lastadminrank` VARCHAR(32) NOT NULL DEFAULT 'Player' COLLATE 'utf8mb4_unicode_ci' AFTER `byond_build`,
	CHANGE COLUMN `rank` `rank` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `migration_status`,
	CHANGE COLUMN `discord_id` `discord_id` VARCHAR(45) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flags`;

ALTER TABLE `ss13_player_linking`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_player_linking`
	ALTER `forum_username_short` DROP DEFAULT,
	ALTER `forum_username` DROP DEFAULT,
	ALTER `player_ckey` DROP DEFAULT,
	ALTER `status` DROP DEFAULT;
ALTER TABLE `ss13_player_linking`
	CHANGE COLUMN `forum_username_short` `forum_username_short` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `forum_id`,
	CHANGE COLUMN `forum_username` `forum_username` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `forum_username_short`,
	CHANGE COLUMN `player_ckey` `player_ckey` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `forum_username`,
	CHANGE COLUMN `status` `status` ENUM('new','confirmed','rejected','linked') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `player_ckey`;

ALTER TABLE `ss13_player_notifications`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_player_notifications`
	ALTER `ckey` DROP DEFAULT,
	ALTER `type` DROP DEFAULT,
	ALTER `message` DROP DEFAULT,
	ALTER `created_by` DROP DEFAULT;
ALTER TABLE `ss13_player_notifications`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `type` `type` ENUM('player_greeting','player_greeting_chat','admin','ccia') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `message` `message` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `type`,
	CHANGE COLUMN `created_by` `created_by` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `message`,
	CHANGE COLUMN `acked_by` `acked_by` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `created_at`;

ALTER TABLE `ss13_player_pai`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_player_pai`
	ALTER `ckey` DROP DEFAULT;
ALTER TABLE `ss13_player_pai`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' FIRST,
	CHANGE COLUMN `name` `name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `description` `description` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `role` `role` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `description`,
	CHANGE COLUMN `comments` `comments` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `role`;

ALTER TABLE `ss13_player_preferences`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_player_preferences`
	ALTER `ckey` DROP DEFAULT;
ALTER TABLE `ss13_player_preferences`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' FIRST,
	CHANGE COLUMN `ooccolor` `ooccolor` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `lastchangelog` `lastchangelog` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ooccolor`,
	CHANGE COLUMN `UI_style` `UI_style` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `lastchangelog`,
	CHANGE COLUMN `UI_style_color` `UI_style_color` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `toggles`,
	CHANGE COLUMN `lastmotd` `lastmotd` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `asfx_togs`,
	CHANGE COLUMN `lastmemo` `lastmemo` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `lastmotd`,
	CHANGE COLUMN `language_prefixes` `language_prefixes` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `lastmemo`,
	CHANGE COLUMN `html_UI_style` `html_UI_style` VARCHAR(32) NULL DEFAULT 'Nano' COLLATE 'utf8mb4_unicode_ci' AFTER `parallax_speed`;


ALTER TABLE `ss13_poll_option`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_poll_option`
	ALTER `text` DROP DEFAULT;
ALTER TABLE `ss13_poll_option`
	CHANGE COLUMN `text` `text` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `pollid`,
	CHANGE COLUMN `descmin` `descmin` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `maxval`,
	CHANGE COLUMN `descmid` `descmid` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `descmin`,
	CHANGE COLUMN `descmax` `descmax` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `descmid`;

ALTER TABLE `ss13_poll_question`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_poll_question`
	ALTER `question` DROP DEFAULT;
ALTER TABLE `ss13_poll_question`
	CHANGE COLUMN `polltype` `polltype` VARCHAR(16) NOT NULL DEFAULT 'OPTION' COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `question` `question` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `endtime`,
	CHANGE COLUMN `viewtoken` `viewtoken` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `publicresult`,
	CHANGE COLUMN `createdby_ckey` `createdby_ckey` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `viewtoken`,
	CHANGE COLUMN `createdby_ip` `createdby_ip` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `createdby_ckey`,
	CHANGE COLUMN `link` `link` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `createdby_ip`;

ALTER TABLE `ss13_poll_textreply`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_poll_textreply`
	ALTER `ckey` DROP DEFAULT,
	ALTER `ip` DROP DEFAULT;
ALTER TABLE `ss13_poll_textreply`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `pollid`,
	CHANGE COLUMN `ip` `ip` VARCHAR(18) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `replytext` `replytext` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`,
	CHANGE COLUMN `adminrank` `adminrank` VARCHAR(32) NOT NULL DEFAULT 'Player' COLLATE 'utf8mb4_unicode_ci' AFTER `replytext`;

ALTER TABLE `ss13_poll_vote`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_poll_vote`
	ALTER `ckey` DROP DEFAULT,
	ALTER `ip` DROP DEFAULT,
	ALTER `adminrank` DROP DEFAULT;
ALTER TABLE `ss13_poll_vote`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `optionid`,
	CHANGE COLUMN `ip` `ip` VARCHAR(16) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `adminrank` `adminrank` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`;

ALTER TABLE `ss13_population`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;

ALTER TABLE `ss13_syndie_contracts`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_syndie_contracts`
	ALTER `contractee_name` DROP DEFAULT,
	ALTER `status` DROP DEFAULT,
	ALTER `title` DROP DEFAULT;
ALTER TABLE `ss13_syndie_contracts`
	CHANGE COLUMN `contractee_name` `contractee_name` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `contractee_id`,
	CHANGE COLUMN `status` `status` ENUM('new','open','mod-nok','completed','closed','reopened','canceled') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `contractee_name`,
	CHANGE COLUMN `title` `title` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `status`,
	CHANGE COLUMN `description` `description` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `title`,
	CHANGE COLUMN `reward_other` `reward_other` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `reward_credits`,
	CHANGE COLUMN `completer_name` `completer_name` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `completer_id`;

ALTER TABLE `ss13_syndie_contracts_comments`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_syndie_contracts_comments`
	ALTER `commentor_name` DROP DEFAULT,
	ALTER `title` DROP DEFAULT,
	ALTER `image_name` DROP DEFAULT,
	ALTER `type` DROP DEFAULT;
ALTER TABLE `ss13_syndie_contracts_comments`
	CHANGE COLUMN `commentor_name` `commentor_name` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `commentor_id`,
	CHANGE COLUMN `title` `title` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `commentor_name`,
	CHANGE COLUMN `comment` `comment` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `title`,
	CHANGE COLUMN `image_name` `image_name` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `comment`,
	CHANGE COLUMN `type` `type` ENUM('mod-author','mod-ooc','ic','ic-comprep','ic-failrep','ic-cancel','ooc') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `image_name`,
	CHANGE COLUMN `report_status` `report_status` ENUM('waiting-approval','accepted','rejected') NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `deleted_at`;

ALTER TABLE `ss13_syndie_contracts_comments_completers`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;

ALTER TABLE `ss13_syndie_contracts_comments_objectives`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;

ALTER TABLE `ss13_syndie_contracts_objectives`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_syndie_contracts_objectives`
	ALTER `status` DROP DEFAULT,
	ALTER `title` DROP DEFAULT;
ALTER TABLE `ss13_syndie_contracts_objectives`
	CHANGE COLUMN `status` `status` ENUM('open','closed','deleted') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `contract_id`,
	CHANGE COLUMN `title` `title` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `status`,
	CHANGE COLUMN `description` `description` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `title`,
	CHANGE COLUMN `reward_other` `reward_other` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `reward_credits_update`,
	CHANGE COLUMN `reward_other_update` `reward_other_update` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `reward_other`;

ALTER TABLE `ss13_syndie_contracts_subscribers`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;

ALTER TABLE `ss13_tickets`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_tickets`
	ALTER `game_id` DROP DEFAULT,
	ALTER `opened_by` DROP DEFAULT,
	ALTER `closed_by` DROP DEFAULT;
ALTER TABLE `ss13_tickets`
	CHANGE COLUMN `game_id` `game_id` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `admin_list` `admin_list` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `admin_count`,
	CHANGE COLUMN `opened_by` `opened_by` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `admin_list`,
	CHANGE COLUMN `taken_by` `taken_by` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `opened_by`,
	CHANGE COLUMN `closed_by` `closed_by` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `taken_by`;

ALTER TABLE `ss13_warnings`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4; 
ALTER TABLE `ss13_warnings`
	ALTER `ckey` DROP DEFAULT,
	ALTER `computerid` DROP DEFAULT,
	ALTER `ip` DROP DEFAULT,
	ALTER `a_ckey` DROP DEFAULT;
ALTER TABLE `ss13_warnings`
	CHANGE COLUMN `reason` `reason` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `severity`,
	CHANGE COLUMN `notes` `notes` MEDIUMTEXT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `reason`,
	CHANGE COLUMN `ckey` `ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `notes`,
	CHANGE COLUMN `computerid` `computerid` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `ip` `ip` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `computerid`,
	CHANGE COLUMN `a_ckey` `a_ckey` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`,
	CHANGE COLUMN `a_computerid` `a_computerid` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `a_ckey`,
	CHANGE COLUMN `a_ip` `a_ip` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `a_computerid`,
	CHANGE COLUMN `lasteditor` `lasteditor` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `edited`;

ALTER TABLE `ss13_webhooks`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_webhooks`
	CHANGE COLUMN `url` `url` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `tags` `tags` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `url`,
	CHANGE COLUMN `mention` `mention` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `tags`;

ALTER TABLE `ss13_web_sso`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_web_sso`
	ALTER `ckey` DROP DEFAULT,
	ALTER `token` DROP DEFAULT,
	ALTER `ip` DROP DEFAULT;
ALTER TABLE `ss13_web_sso`
	CHANGE COLUMN `ckey` `ckey` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `token` `token` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `ip` `ip` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `token`;

ALTER TABLE `ss13_whitelist_log`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_whitelist_log`
	ALTER `user` DROP DEFAULT;
ALTER TABLE `ss13_whitelist_log`
	CHANGE COLUMN `user` `user` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `datetime`,
	CHANGE COLUMN `action_method` `action_method` VARCHAR(32) NOT NULL DEFAULT 'Game Server' COLLATE 'utf8mb4_unicode_ci' AFTER `user`,
	CHANGE COLUMN `action` `action` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `action_method`;

ALTER TABLE `ss13_whitelist_statuses`
	COLLATE='utf8mb4_unicode_ci',
	CONVERT TO CHARSET utf8mb4;
ALTER TABLE `ss13_whitelist_statuses`
	ALTER `status_name` DROP DEFAULT;
ALTER TABLE `ss13_whitelist_statuses`
	CHANGE COLUMN `status_name` `status_name` VARCHAR(32) NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `flag`;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

-- Allows the char name of the antag log to be nulled
ALTER TABLE `ss13_antag_log`
	ALTER `char_name` DROP DEFAULT;
ALTER TABLE `ss13_antag_log`
	CHANGE COLUMN `char_name` `char_name` VARCHAR(50) NULL AFTER `game_id`;

-- Allows ip and computerid in the ss13_player table to be nulled
ALTER TABLE `ss13_player`
	ALTER `ip` DROP DEFAULT,
	ALTER `computerid` DROP DEFAULT;
ALTER TABLE `ss13_player`
	CHANGE COLUMN `ip` `ip` VARCHAR(18) NULL COLLATE 'utf8mb4_unicode_ci' AFTER `lastseen`,
	CHANGE COLUMN `computerid` `computerid` VARCHAR(32) NULL COLLATE 'utf8mb4_unicode_ci' AFTER `ip`;

-- Allows the ss13_library uploader to be nulled
ALTER TABLE `ss13_library`
	CHANGE COLUMN `uploader` `uploader` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `uploadtime`;

-- Add/Update forein keys for ckeys
ALTER TABLE `ss13_admin_log`
	ADD CONSTRAINT `FK_ss13_admin_log_ss13_player` FOREIGN KEY (`adminckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;

ALTER TABLE `ss13_antag_log`
	ADD CONSTRAINT `FK_ss13_antag_log_ss13_player` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;


INSERT INTO ss13_player (ckey, firstseen, lastseen, ip, computerid)
SELECT ss13_ban.ckey, ss13_ban.bantime AS first, ss13_ban.bantime AS last, ss13_ban.computerid, ss13_ban.ip
FROM ss13_ban 
LEFT JOIN ss13_player 
  ON ss13_player.ckey = ss13_ban.ckey 
WHERE ss13_player.ckey IS NULL
ON DUPLICATE KEY UPDATE byond_version = null;

ALTER TABLE `ss13_ban`
	ADD CONSTRAINT `FK_ss13_ban_ss13_player_ckey` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;

ALTER TABLE `ss13_ban`
	ADD CONSTRAINT `FK_ss13_ban_ss13_player_a_ckey` FOREIGN KEY (`a_ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;

ALTER TABLE `ss13_ccia_reports_transcripts`
	ADD CONSTRAINT `FK_ss13_ccia_reports_transcripts_ss13_characters` FOREIGN KEY (`character_id`) REFERENCES `ss13_characters` (`id`) ON UPDATE CASCADE;

ALTER TABLE `ss13_ipc_tracking`
	ADD CONSTRAINT `FK_ss13_ipc_tracking_ss13_player` FOREIGN KEY (`player_ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;


UPDATE `ss13_library` SET `uploader` = NULL WHERE `uploader` = "";
UPDATE `ss13_library` SET `uploader` = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(`uploader`),' ',''),'_',''),'-',''),'.',''),'@','');

ALTER TABLE `ss13_library`
	ADD CONSTRAINT `FK_ss13_library_ss13_player` FOREIGN KEY (`uploader`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;


UPDATE `ss13_notes` SET `ckey` = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(`ckey`),' ',''),'_',''),'-',''),'.',''),'@','');

INSERT INTO ss13_player (ckey, firstseen, lastseen, ip, computerid)
SELECT ss13_notes.ckey, ss13_notes.adddate AS first, ss13_notes.adddate AS lst, ss13_notes.computerid, ss13_notes.ip
FROM ss13_notes 
LEFT JOIN ss13_player 
  ON ss13_player.ckey = ss13_notes.ckey
WHERE ss13_player.ckey IS NULL
ON DUPLICATE KEY UPDATE ss13_player.byond_version = NULL;

ALTER TABLE `ss13_notes`
	ADD CONSTRAINT `FK_ss13_notes_ss13_player_ckey` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;

UPDATE `ss13_notes` SET `a_ckey` = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(`a_ckey`),' ',''),'_',''),'-',''),'.',''),'@','');

ALTER TABLE `ss13_notes`
	ADD CONSTRAINT `FK_ss13_notes_ss13_player_a_ckey` FOREIGN KEY (`a_ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;

ALTER TABLE `ss13_player_notifications`
	ADD CONSTRAINT `FK_ss13_player_notifications_ss13_player` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;

ALTER TABLE `ss13_poll_textreply`
	ADD CONSTRAINT `FK_ss13_poll_textreply_ss13_player` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;

ALTER TABLE `ss13_poll_vote`
	ADD CONSTRAINT `FK_ss13_poll_vote_ss13_player` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;

ALTER TABLE `ss13_warnings`
	ADD CONSTRAINT `FK_ss13_warnings_ss13_player_ckey` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;

ALTER TABLE `ss13_warnings`
	ADD CONSTRAINT `FK_ss13_warnings_ss13_player_a_ckey` FOREIGN KEY (`a_ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;--
-- Removes the Random Job Option
--

UPDATE ss13_characters SET alternate_option = 0 WHERE alternate_option = 1;
UPDATE ss13_characters SET alternate_option = 1 WHERE alternate_option = 2;--
-- Adds HTML style value to the player preferences table.
--

ALTER TABLE `ss13_player_preferences`
	ADD `skin_theme` VARCHAR(32) DEFAULT 'Light';
--
-- Complimentary of PR #7127
--

ALTER TABLE `ss13_player_preferences`
    ADD `clientfps` INT DEFAULT '0' AFTER `ooccolor`;
--
-- Adds support for underwear updates in PR #6973.
-- This collates all underwear data into one column, with an additional column for custom colours.
-- 

ALTER TABLE `ss13_characters`
	ADD COLUMN `all_underwear` JSON NULL DEFAULT NULL AFTER `eyes_colour`,
	DROP COLUMN `underwear`,
	DROP COLUMN `undershirt`,
	DROP COLUMN `socks`,
	ADD COLUMN `all_underwear_metadata` JSON NULL DEFAULT NULL AFTER `all_underwear`;
--
-- Adds support for underwear updates in PR #8710.
-- What else do you think this does?
-- 

ALTER TABLE `ss13_player_preferences`
    ADD `tooltip_style` ENUM('Midnight', 'Plasmafire', 'Retro', 'Slimecore', 'Operative', 'Clockwork') NULL DEFAULT 'Midnight';
--
-- Reworks how IPC tags work in PR #6973.
-- This drops the old ss13_ipc_tracking table in favour of ss13_characters_ipc_tags with new fresh information.
-- 

DROP TABLE `ss13_ipc_tracking`;

CREATE TABLE `ss13_characters_ipc_tags` (
  `char_id` int(11) NOT NULL,
  `tag_status` tinyint(1) NOT NULL DEFAULT '0',
  `serial_number` varchar(12) DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
  `ownership_status` enum('Self Owned','Company Owned','Privately Owned') DEFAULT 'Company Owned' COLLATE 'utf8mb4_unicode_ci',
  PRIMARY KEY (`char_id`),
  CONSTRAINT `char_id` FOREIGN KEY (`char_id`) REFERENCES `ss13_characters` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB COLLATE='utf8mb4_unicode_ci';--
-- Further Changes to the CCIA Report Tables
--

ALTER TABLE `ss13_ccia_reports`
	ALTER `status` DROP DEFAULT;
ALTER TABLE `ss13_ccia_reports`
	ADD COLUMN `public_topic` VARCHAR(200) NULL DEFAULT NULL AFTER `title`,
	ADD COLUMN `internal_topic` VARCHAR(200) NULL DEFAULT NULL AFTER `public_topic`,
	ADD COLUMN `game_id` VARCHAR(20) NULL DEFAULT NULL AFTER `internal_topic`;
ALTER TABLE `ss13_ccia_reports`
	CHANGE COLUMN `status` `status` ENUM('new','in progress','review required','approved','rejected','completed') NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `game_id`;

ALTER TABLE `ss13_ccia_reports_transcripts`
	ADD COLUMN `antag_involvement` TINYINT(4) NOT NULL DEFAULT '1' AFTER `interviewer`,
	ADD COLUMN `antag_involvement_text` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `antag_involvement`,
	CHANGE COLUMN `text` `text` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `antag_involvement_text`;
--
-- Adds support for loadout slots in PR #8813.
-- 

ALTER TABLE `ss13_characters`
    ADD COLUMN `gear_slot` TINYINT NULL DEFAULT NULL AFTER `gear`;
--
-- Drops the SQL table for news in lieu of using the forums.
--

DROP TABLE `ss13_news_stories`;
DROP TABLE `ss13_news_channels`;
--
-- Adds support for accents as a character option in PR #9196.
-- 

ALTER TABLE `ss13_characters`
	ADD COLUMN `accent` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `religion`;--
-- Adds support for character setup backgrounds in #9300
-- 

ALTER TABLE `ss13_characters`
	ADD COLUMN `bgstate` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `accent`; --
-- Adds foreign keys to a few tables and add gameid to notes/warnings/bans
--

ALTER TABLE `ss13_poll_option`
	ADD CONSTRAINT `FK_ss13_poll_option_ss13_poll_question` FOREIGN KEY (`pollid`) REFERENCES `ss13_poll_question` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `ss13_poll_textreply`
	ADD CONSTRAINT `FK_ss13_poll_textreply_ss13_poll_question` FOREIGN KEY (`pollid`) REFERENCES `ss13_poll_question` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `ss13_poll_vote`
	ADD CONSTRAINT `FK_ss13_poll_vote_ss13_poll_question` FOREIGN KEY (`pollid`) REFERENCES `ss13_poll_question` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `ss13_poll_vote`
	ADD CONSTRAINT `FK_ss13_poll_vote_ss13_poll_option` FOREIGN KEY (`optionid`) REFERENCES `ss13_poll_option` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;


UPDATE `ss13_death` SET `byondkey` = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(`byondkey`),' ',''),'_',''),'-',''),'.',''),'@','');
UPDATE `ss13_death` SET `lakey` = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(`lakey`),' ',''),'_',''),'-',''),'.',''),'@','');

ALTER TABLE `ss13_death`
	CHANGE COLUMN `pod` `pod` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Place of death' COLLATE 'utf8mb4_unicode_ci' AFTER `id`,
	CHANGE COLUMN `coord` `coord` VARCHAR(255) NULL DEFAULT NULL COMMENT 'X, Y, Z POD' COLLATE 'utf8mb4_unicode_ci' AFTER `pod`,
	CHANGE COLUMN `job` `job` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `tod`,
	CHANGE COLUMN `special` `special` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `job`,
	CHANGE COLUMN `name` `name` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `special`,
	CHANGE COLUMN `byondkey` `ckey` VARCHAR(32) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `name`,
	CHANGE COLUMN `laname` `laname` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Last attacker name' COLLATE 'utf8mb4_unicode_ci' AFTER `ckey`,
	CHANGE COLUMN `lakey` `lackey` VARCHAR(32) NULL DEFAULT NULL COMMENT 'Last attacker key' COLLATE 'utf8mb4_unicode_ci' AFTER `laname`,
	CHANGE COLUMN `gender` `gender` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `lackey`;

UPDATE ss13_death SET pod = NULL WHERE pod = '';
UPDATE ss13_death SET coord = NULL WHERE coord = '';
UPDATE ss13_death SET job = NULL WHERE job = '';
UPDATE ss13_death SET special = NULL WHERE special = '';
UPDATE ss13_death SET name = NULL WHERE name = '';
UPDATE ss13_death SET ckey = NULL WHERE ckey = '';
UPDATE ss13_death SET laname = NULL WHERE laname = '';
UPDATE ss13_death SET lackey = NULL WHERE lackey = '';
UPDATE ss13_death SET gender = NULL WHERE gender = '';

ALTER TABLE `ss13_death`
	ADD COLUMN `char_id` INT NULL DEFAULT NULL AFTER `ckey`;

ALTER TABLE `ss13_death`
	ADD CONSTRAINT `FK_ss13_death_ss13_player` FOREIGN KEY (`ckey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `ss13_death`
	ADD CONSTRAINT `FK_ss13_death_ss13_player_lackey` FOREIGN KEY (`lackey`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `ss13_death`
	ADD CONSTRAINT `FK_ss13_death_ss13_characters` FOREIGN KEY (`char_id`) REFERENCES `ss13_characters` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;


ALTER TABLE `ss13_ban`
	CHANGE COLUMN `id` `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT FIRST;

ALTER TABLE `ss13_ban_mirrors`
	ADD CONSTRAINT `FK_ss13_ban_mirrors_ss13_ban` FOREIGN KEY (`ban_id`) REFERENCES `ss13_ban` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE `ss13_stickyban_matched_cid`
	ADD CONSTRAINT `FK_ss13_stickyban_matched_cid_ss13_stickyban` FOREIGN KEY (`stickyban`) REFERENCES `ss13_stickyban` (`ckey`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `ss13_stickyban_matched_ckey`
	ADD CONSTRAINT `FK_ss13_stickyban_matched_ckey_ss13_stickyban` FOREIGN KEY (`stickyban`) REFERENCES `ss13_stickyban` (`ckey`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `ss13_stickyban_matched_ip`
	ADD CONSTRAINT `FK_ss13_stickyban_matched_ip_ss13_stickyban` FOREIGN KEY (`stickyban`) REFERENCES `ss13_stickyban` (`ckey`) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE `ss13_character_incidents`
	ADD CONSTRAINT `FK_ss13_character_incidents_ss13_characters` FOREIGN KEY (`char_id`) REFERENCES `ss13_characters` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE `ss13_player_notifications`
	ADD CONSTRAINT `FK_ss13_player_notifications_ss13_player_2` FOREIGN KEY (`created_by`) REFERENCES `ss13_player` (`ckey`) ON UPDATE CASCADE;


ALTER TABLE `ss13_ban`
	ADD COLUMN `game_id` VARCHAR(32) NULL DEFAULT NULL AFTER `serverip`;

ALTER TABLE `ss13_notes`
	ADD COLUMN `game_id` VARCHAR(50) NULL DEFAULT NULL AFTER `adddate`;

ALTER TABLE `ss13_warnings`
	ADD COLUMN `game_id` VARCHAR(50) NULL DEFAULT NULL AFTER `time`;
--
-- Set default 'On' for 'asfx_instruments'
-- 

UPDATE `ss13_player_preferences` SET `asfx_togs` = `asfx_togs` | 128;--
-- Adds a column to ss13_cargo_items which enables the storage of load errors
--

ALTER TABLE `ss13_cargo_items`
	ADD COLUMN `error_message` TEXT NULL DEFAULT NULL AFTER `order_by`;
--
-- Adds the ss13_admins SQL table again.
--

CREATE TABLE `ss13_admins` (
  `ckey` VARCHAR(50) NOT NULL,
  `rank` TEXT NOT NULL,
  `flags` INT NOT NULL,
  `status` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`ckey`),
  CONSTRAINT `FK_ss13_admins_ss13_player_ckey` FOREIGN KEY(`ckey`) REFERENCES  `ss13_player` (`ckey`) ON UPDATE CASCADE
) ENGINE=InnoDB COLLATE='utf8mb4_unicode_ci';

ALTER TABLE `ss13_player`
  DROP COLUMN `rank`,
  DROP COLUMN `flags`;

DROP TABLE `ss13_admin_log`;
--
-- Adds the cargo logging tables
--

CREATE TABLE `ss13_cargo_orderlog` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`game_id` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
	`order_id` INT(11) NOT NULL,
	`status` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
	`price` INT(11) NOT NULL DEFAULT '0',
	`ordered_by_id` INT(11) NULL DEFAULT NULL,
	`ordered_by` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`authorized_by_id` INT(11) NULL DEFAULT NULL,
	`authorized_by` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`received_by_id` INT(11) NULL DEFAULT NULL,
	`received_by` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`paid_by_id` INT(11) NULL DEFAULT NULL,
	`paid_by` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`time_submitted` TIME NULL DEFAULT NULL,
	`time_approved` TIME NULL DEFAULT NULL,
	`time_shipped` TIME NULL DEFAULT NULL,
	`time_delivered` TIME NULL DEFAULT NULL,
	`time_paid` TIME NULL DEFAULT NULL,
	`reason` TEXT(65535) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB;

CREATE TABLE `ss13_cargo_orderlog_items` (
	`cargo_orderlog_id` INT(11) UNSIGNED NOT NULL,
	`cargo_item_id` INT(11) UNSIGNED NOT NULL,
	`amount` INT(11) NOT NULL,
	PRIMARY KEY (`cargo_orderlog_id`, `cargo_item_id`) USING BTREE,
	INDEX `index_orderlog_id` (`cargo_orderlog_id`) USING BTREE,
	INDEX `index_item_id` (`cargo_item_id`) USING BTREE,
	CONSTRAINT `FK_ss13_cargo_orderlog_items_ss13_cargo_items` FOREIGN KEY (`cargo_item_id`) REFERENCES `ss13_cargo_items` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_ss13_cargo_orderlog_items_ss13_cargo_orderlog` FOREIGN KEY (`cargo_orderlog_id`) REFERENCES `ss13_cargo_orderlog` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB;
--
-- Puts autohiss in character setup
--

ALTER TABLE `ss13_characters`
	ADD COLUMN `autohiss` TINYINT NOT NULL DEFAULT 0 AFTER `accent`;
--
-- Implemented in PR #10319.
-- Adds a `pda_choice` column for PDA type preferences.
--

ALTER TABLE `ss13_characters`
	ADD COLUMN `pda_choice` INT(11) NULL DEFAULT NULL AFTER `backbag_style`;
--
-- Implemented in PR #10540.
-- Adds a `headset_choice` column for headset type preferences.
--

ALTER TABLE `ss13_characters`
	ADD COLUMN `headset_choice` TINYINT NULL DEFAULT NULL AFTER `pda_choice`;
--
-- Implemented in PR TODO.
-- Adds a `ss13_characters_custom_items` table to replace the old custom item system.
--

CREATE TABLE `ss13_characters_custom_items` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`char_id` INT(11) NOT NULL,
	`item_path` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`item_data` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	`req_titles` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`additional_data` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `FK_ss13_characters_custom_items_ss13_characters` (`char_id`) USING BTREE,
	CONSTRAINT `FK_ss13_characters_custom_items_ss13_characters` FOREIGN KEY (`char_id`) REFERENCES `ss13_characters` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
;
--
-- Implemented in PR #10718.
-- Adds a `Hair Gradient Style and Hair Gradient Color` columns for hair gradient preferences.
--

ALTER TABLE `ss13_characters`
	ADD COLUMN `grad_colour` varchar(7) DEFAULT NULL AFTER `facial_colour`,
  ADD COLUMN `gradient_style` varchar(32) DEFAULT NULL AFTER `facial_style`;
--
-- Adds a deleted_by and deleted reason to ss13_characters in preparation for player-permitted un-delete
--

ALTER TABLE `ss13_characters`
	ADD COLUMN `deleted_by` ENUM('player','staff') NULL DEFAULT NULL AFTER `gear_slot`,
	ADD COLUMN `deleted_reason` TEXT NULL AFTER `deleted_by`;
--
-- Increase the message length of the ss13_player_notifications
--

ALTER TABLE `ss13_player_notifications`
	CHANGE COLUMN `message` `message` MEDIUMTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `type`;
--
-- Implemented in PR #11207.
-- Adds the ability for players to select their character's pronouns, only affects what gender they appear as when examined and in visible messages.
--

ALTER TABLE `ss13_characters`
	ADD COLUMN `pronouns` varchar(12) DEFAULT NULL AFTER `gender`;--
-- Set default 'On' for 'HOTKEY_DEFAULT in toggles_secondary'
-- 

UPDATE `ss13_player_preferences` SET `toggles_secondary` = `toggles_secondary` | 32;--
-- Add a new floating chat color field
-- 

ALTER TABLE `ss13_characters`
	ADD COLUMN `floating_chat_color` char(7) DEFAULT NULL AFTER `pronouns`;--
-- Add a new primary radio slot field
-- 

ALTER TABLE `ss13_characters`
	ADD COLUMN `primary_radio_slot` char(9) DEFAULT 'Left Ear' AFTER `floating_chat_color`;--
-- Set default 'On' for 'GOONCHAT_ON in toggles_secondary'
-- 

UPDATE `ss13_player_preferences` SET `toggles_secondary` = `toggles_secondary` | 64;--
-- Implemented in PR #11967.
-- Renames NanoTrasen Relation into Economic Status.
--

ALTER TABLE `ss13_characters` ADD COLUMN `economic_status` ENUM('Wealthy', 'Well-off', 'Average', 'Underpaid', 'Poor') DEFAULT "Average" AFTER `religion`;

UPDATE `ss13_characters` SET `economic_status` = 'Wealthy' WHERE nt_relation = 'Loyal';
UPDATE `ss13_characters` SET `economic_status` = 'well-off' WHERE nt_relation = 'Supportive';
UPDATE `ss13_characters` SET `economic_status` = 'Average' WHERE nt_relation = 'Neutral';
UPDATE `ss13_characters` SET `economic_status` = 'Underpaid' WHERE nt_relation = 'Skeptical';
UPDATE `ss13_characters` SET `economic_status` = 'Poor' WHERE nt_relation = 'Opposed';

ALTER TABLE `ss13_characters` DROP COLUMN `nt_relation`;--
-- Implemented in PR #13400.
-- Add cultures and origins
--

ALTER TABLE `ss13_characters` ADD COLUMN `culture` VARCHAR(48) DEFAULT NULL AFTER `economic_status`;
ALTER TABLE `ss13_characters` ADD COLUMN `origin` VARCHAR(48) DEFAULT NULL AFTER `culture`;
--
-- Implemented in PR #14329.
-- Adds the impoverished option to the economic status in the database so it saves correctly.
--

ALTER TABLE `ss13_characters` MODIFY COLUMN `economic_status` ENUM('Wealthy', 'Well-off', 'Average', 'Underpaid', 'Poor', 'Impoverished');--
-- Implemented in PR #14716.
-- Clear unused "SOUND_AMBIENCE" (0x4) flag from "prefs.toggles".
-- Rename "asfx_togs" to "sfx_toggles".
-- 

UPDATE `ss13_player_preferences` SET `toggles` = `toggles` & ~0x4;
ALTER TABLE `ss13_player_preferences` CHANGE COLUMN `asfx_togs` `sfx_toggles` INT(11) NULL DEFAULT '0' AFTER `UI_style_alpha`;--
-- Implemented in PR #14531.
-- Adds Backbag colors.
--

ALTER TABLE `ss13_characters`
	ADD COLUMN `backbag_color` INT(11) NULL DEFAULT NULL AFTER `backbag_style`,
 	ADD COLUMN `backbag_strap` INT(11) NULL DEFAULT NULL AFTER `backbag_color`;
--
-- Edit cultures and origins to have a higher character limit
--

ALTER TABLE `ss13_characters` MODIFY COLUMN `culture` VARCHAR(128);
ALTER TABLE `ss13_characters` MODIFY COLUMN `origin` VARCHAR(128);
--
-- Implemented in PR #15577.
-- Adds the ability for players to select their species' tail, instead of each species only having one stock type of tail.
--

ALTER TABLE `ss13_characters`
	ADD COLUMN `tail_style` varchar(20) DEFAULT NULL AFTER `skin_colour`;
--
-- Implemented in PR #14591.
-- Removes the decrepit, unused skills in the loadout.
-- 

ALTER TABLE `ss13_characters` DROP COLUMN `skills`;
ALTER TABLE `ss13_characters` DROP COLUMN `skill_specialization`;--
-- Implemented in PR #16169.
-- Adds a speech bubble pref.
-- 

ALTER TABLE `ss13_characters` ADD COLUMN `speech_bubble_type` VARCHAR(16) DEFAULT NULL AFTER `floating_chat_color`;--
-- Adds character heights
--

ALTER TABLE `ss13_characters` ADD COLUMN `height` INT(3) NOT NULL DEFAULT 0 AFTER `species`;
--
-- Adds tgui prefs
--

ALTER TABLE `ss13_player_preferences` ADD COLUMN `tgui_fancy` INT(1) NOT NULL DEFAULT 1 AFTER `html_UI_style`;
ALTER TABLE `ss13_player_preferences` ADD COLUMN `tgui_lock` INT(1) NOT NULL DEFAULT 0 AFTER `tgui_fancy`;
ALTER TABLE `ss13_player_preferences` DROP COLUMN `html_UI_style`;
