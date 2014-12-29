BEGIN;
CREATE TABLE `project_index_codes` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `project_id` integer NOT NULL,
    `indexcode_id` integer NOT NULL,
    UNIQUE (`project_id`, `indexcode_id`)
)
;
CREATE TABLE `project_subjects` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `project_id` integer NOT NULL,
    `subject_id` integer NOT NULL,
    UNIQUE (`project_id`, `subject_id`)
)
;
CREATE TABLE `project_tags` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `project_id` integer NOT NULL,
    `tag_id` integer NOT NULL,
    UNIQUE (`project_id`, `tag_id`)
)
;
CREATE TABLE `project_keywords` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `project_id` integer NOT NULL,
    `keyword_id` integer NOT NULL,
    UNIQUE (`project_id`, `keyword_id`)
)
;
CREATE TABLE `project` (
    `project_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `internal_project_id` varchar(50) NOT NULL,
    `trb_rip_number` integer UNSIGNED,
    `title` varchar(255) NOT NULL,
    `created_date` datetime NOT NULL,
    `modified_date` datetime NOT NULL,
    `cost` numeric(32, 2),
    `abstract` longtext NOT NULL,
    `grant_type_id` varchar(32),
    `research_type_id` varchar(32),
    `start_date` date,
    `end_date` date,
    `is_research_data_proposal` bool NOT NULL,
    `is_project` bool NOT NULL,
    `is_abstract_submitted` bool NOT NULL,
    `abstract_submitted_date` datetime,
    `is_proposal_submitted` bool NOT NULL,
    `proposal_submitted_date` datetime,
    `is_due_date_reminder_sent` bool NOT NULL,
    `is_past_due_reminder_sent` bool NOT NULL,
    `is_locked` bool NOT NULL,
    `is_highlighted` bool NOT NULL,
    `grant_cycle_id` integer NOT NULL,
    `is_published` bool NOT NULL,
    `photo` varchar(100)
)
;
CREATE TABLE `keyword` (
    `keyword_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(50) NOT NULL
)
;
CREATE TABLE `project_grant_type` (
    `grant_type_id` varchar(32) NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL UNIQUE,
    `is_displayed` bool NOT NULL,
    `is_restricted` bool NOT NULL,
    `rank` integer UNSIGNED NOT NULL
)
;
CREATE TABLE `project_research_type` (
    `research_type_id` varchar(32) NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL UNIQUE,
    `is_displayed` bool NOT NULL,
    `is_restricted` bool NOT NULL,
    `rank` integer UNSIGNED NOT NULL
)
;
CREATE TABLE `index_code` (
    `index_code_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `index_code` varchar(255) NOT NULL UNIQUE
)
;
CREATE TABLE `tag` (
    `tag_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL UNIQUE
)
;
CREATE TABLE `project_user` (
    `project_users_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `user_id` integer NOT NULL,
    `project_id` integer NOT NULL,
    `org_id` integer NOT NULL,
    `project_role_id` varchar(64) NOT NULL,
    `position_id` varchar(63) NOT NULL
)
;
CREATE TABLE `position` (
    `position_id` varchar(63) NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL UNIQUE,
    `is_displayed` bool NOT NULL,
    `rank` integer UNSIGNED NOT NULL,
    `is_faculty` bool NOT NULL,
    `is_student` bool NOT NULL
)
;
CREATE TABLE `project_role` (
    `role_id` varchar(64) NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL UNIQUE,
    `is_displayed` bool NOT NULL,
    `rank` integer UNSIGNED NOT NULL
)
;
CREATE INDEX `project_index_codes_37952554` ON `project_index_codes` (`project_id`);
CREATE INDEX `project_index_codes_822c0382` ON `project_index_codes` (`indexcode_id`);
CREATE INDEX `project_subjects_37952554` ON `project_subjects` (`project_id`);
CREATE INDEX `project_subjects_56bb4187` ON `project_subjects` (`subject_id`);
CREATE INDEX `project_tags_37952554` ON `project_tags` (`project_id`);
CREATE INDEX `project_tags_5659cca2` ON `project_tags` (`tag_id`);
CREATE INDEX `project_keywords_37952554` ON `project_keywords` (`project_id`);
CREATE INDEX `project_keywords_0e202173` ON `project_keywords` (`keyword_id`);
CREATE INDEX `project_5536e93b` ON `project` (`grant_type_id`);
CREATE INDEX `project_9bcc955d` ON `project` (`research_type_id`);
CREATE INDEX `project_a7422f2c` ON `project` (`grant_cycle_id`);
CREATE INDEX `project_user_6340c63c` ON `project_user` (`user_id`);
CREATE INDEX `project_user_37952554` ON `project_user` (`project_id`);
CREATE INDEX `project_user_4be46b53` ON `project_user` (`org_id`);
CREATE INDEX `project_user_67b4d01d` ON `project_user` (`project_role_id`);
CREATE INDEX `project_user_1f456125` ON `project_user` (`position_id`);
CREATE TABLE `user_expertise` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `user_id` integer NOT NULL,
    `subject_id` integer NOT NULL,
    UNIQUE (`user_id`, `subject_id`)
)
;
CREATE TABLE `user_roles` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `user_id` integer NOT NULL,
    `userrole_id` integer NOT NULL,
    UNIQUE (`user_id`, `userrole_id`)
)
;
CREATE TABLE `user` (
    `password` varchar(128) NOT NULL,
    `last_login` datetime NOT NULL,
    `user_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `email` varchar(255) NOT NULL UNIQUE,
    `first_name` varchar(63) NOT NULL,
    `last_name` varchar(63) NOT NULL,
    `should_invite_again` bool NOT NULL,
    `date_joined` datetime NOT NULL,
    `is_active` bool NOT NULL,
    `is_staff` bool NOT NULL,
    `is_displayed` bool NOT NULL,
    `is_highlighted` bool NOT NULL,
    `contact_info_id` integer UNIQUE,
    `title` varchar(255) NOT NULL,
    `primary_discipline_id` varchar(32),
    `department_id` integer,
    `org_id` integer,
    `profile` longtext NOT NULL,
    `photo` varchar(100) NOT NULL,
    `profile_type` integer,
    `website` varchar(255) NOT NULL
)
;
CREATE TABLE `user_role` (
    `user_role_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL,
    `machine_name` varchar(255) NOT NULL,
    `rank` integer NOT NULL
)
;
CREATE TABLE `user_education` (
    `user_education_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `education` varchar(255) NOT NULL,
    `user_id` integer NOT NULL
)
;
CREATE TABLE `subject` (
    `subject_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(63) NOT NULL
)
;
ALTER TABLE `user_expertise` ADD CONSTRAINT `subject_id_refs_subject_id_27ed26a2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`);
CREATE TABLE `discipline` (
    `discipline_id` varchar(32) NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL UNIQUE,
    `is_displayed` bool NOT NULL,
    `rank` integer UNSIGNED NOT NULL
)
;
ALTER TABLE `user` ADD CONSTRAINT `primary_discipline_id_refs_discipline_id_ff8854d7` FOREIGN KEY (`primary_discipline_id`) REFERENCES `discipline` (`discipline_id`);
CREATE TABLE `department` (
    `department_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL UNIQUE,
    `is_displayed` bool NOT NULL
)
;
ALTER TABLE `user` ADD CONSTRAINT `department_id_refs_department_id_ec104bf2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`);
CREATE TABLE `contact_info` (
    `contact_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `mailing_1` varchar(255) NOT NULL,
    `mailing_2` varchar(255) NOT NULL,
    `city` varchar(255) NOT NULL,
    `state` varchar(2) NOT NULL,
    `zip` varchar(32) NOT NULL,
    `email` varchar(255) NOT NULL,
    `phone` varchar(20) NOT NULL,
    `fax` varchar(20) NOT NULL
)
;
ALTER TABLE `user` ADD CONSTRAINT `contact_info_id_refs_contact_id_5acac01a` FOREIGN KEY (`contact_info_id`) REFERENCES `contact_info` (`contact_id`);
CREATE INDEX `user_expertise_6340c63c` ON `user_expertise` (`user_id`);
CREATE INDEX `user_expertise_56bb4187` ON `user_expertise` (`subject_id`);
CREATE INDEX `user_roles_6340c63c` ON `user_roles` (`user_id`);
CREATE INDEX `user_roles_888765e5` ON `user_roles` (`userrole_id`);
CREATE INDEX `user_758d2aed` ON `user` (`primary_discipline_id`);
CREATE INDEX `user_69d14838` ON `user` (`department_id`);
CREATE INDEX `user_4be46b53` ON `user` (`org_id`);
CREATE INDEX `user_education_6340c63c` ON `user_education` (`user_id`);
CREATE TABLE `grant_program` (
    `grant_program_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(50) NOT NULL,
    `is_displayed` bool NOT NULL
)
;
CREATE TABLE `grant_cycle_execs` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `grantcycle_id` integer NOT NULL,
    `user_id` integer NOT NULL,
    UNIQUE (`grantcycle_id`, `user_id`)
)
;
ALTER TABLE `grant_cycle_execs` ADD CONSTRAINT `user_id_refs_user_id_e23d0ca6` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
CREATE TABLE `grant_cycle` (
    `grant_cycle_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(50) NOT NULL,
    `program_id` integer NOT NULL,
    `type` integer UNSIGNED NOT NULL,
    `begin_date` date NOT NULL,
    `end_date` date NOT NULL,
    `is_default` bool NOT NULL,
    `is_active` bool NOT NULL,
    `show_peer_reviews` bool NOT NULL,
    `show_programmatic_reviews` bool NOT NULL,
    `abstract_due_date` datetime NOT NULL,
    `proposal_due_date` datetime NOT NULL,
    `review_due_date` datetime NOT NULL,
    `final_report_review_due_date` datetime NOT NULL,
    `proposal_form` varchar(100),
    `budget_form` varchar(100),
    `peer_review_id` integer,
    `programmatic_review_id` integer,
    `final_report_review_id` integer
)
;
CREATE INDEX `grant_cycle_execs_ff46c78c` ON `grant_cycle_execs` (`grantcycle_id`);
CREATE INDEX `grant_cycle_execs_6340c63c` ON `grant_cycle_execs` (`user_id`);
CREATE INDEX `grant_cycle_cdb5484e` ON `grant_cycle` (`program_id`);
CREATE INDEX `grant_cycle_1413c7fb` ON `grant_cycle` (`peer_review_id`);
CREATE INDEX `grant_cycle_0170ceb6` ON `grant_cycle` (`programmatic_review_id`);
CREATE INDEX `grant_cycle_7a7a63f9` ON `grant_cycle` (`final_report_review_id`);
CREATE TABLE `org` (
    `org_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL,
    `org_type` integer UNSIGNED NOT NULL,
    `is_match_org` bool NOT NULL,
    `is_affiliation_org` bool NOT NULL,
    `is_displayed` bool NOT NULL,
    `website` varchar(200) NOT NULL,
    `aliases` longtext NOT NULL,
    `contact_info_id` integer UNIQUE
)
;
CREATE TABLE `project_match_special_role` (
    `match_special_role_id` varchar(32) NOT NULL PRIMARY KEY,
    `name` varchar(255) NOT NULL UNIQUE,
    `is_displayed` bool NOT NULL,
    `rank` integer UNSIGNED NOT NULL
)
;
CREATE TABLE `project_match_special_roles` (
    `id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `projectmatch_id` integer NOT NULL,
    `specialrole_id` varchar(32) NOT NULL,
    UNIQUE (`projectmatch_id`, `specialrole_id`)
)
;
CREATE TABLE `project_match` (
    `project_match_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `project_id` integer NOT NULL,
    `org_id` integer NOT NULL,
    `begin_date` date NOT NULL,
    `end_date` date NOT NULL,
    `cash_amount` numeric(32, 2) NOT NULL,
    `in_kind_amount` numeric(32, 2) NOT NULL,
    `in_kind_comment` varchar(255) NOT NULL,
    `type` integer UNSIGNED,
    `role_comment` varchar(200) NOT NULL,
    `user_id` integer NOT NULL
)
;
CREATE INDEX `project_match_special_roles_26fc6ef2` ON `project_match_special_roles` (`projectmatch_id`);
CREATE INDEX `project_match_special_roles_79ec6fff` ON `project_match_special_roles` (`specialrole_id`);
CREATE INDEX `project_match_37952554` ON `project_match` (`project_id`);
CREATE INDEX `project_match_4be46b53` ON `project_match` (`org_id`);
CREATE INDEX `project_match_6340c63c` ON `project_match` (`user_id`);
CREATE TABLE `doc` (
    `doc_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `title` varchar(500) NOT NULL,
    `type_id` varchar(32) NOT NULL,
    `file` varchar(512),
    `upload_date` datetime NOT NULL,
    `description` longtext NOT NULL,
    `citation` longtext NOT NULL,
    `report_number` varchar(32) NOT NULL,
    `lulu_number` integer,
    `pub_date` date,
    `report_order_url` varchar(200) NOT NULL,
    `event_type` integer UNSIGNED,
    `publication_type` integer UNSIGNED,
    `primary_audience` integer UNSIGNED,
    `number_attending` integer UNSIGNED,
    `location` varchar(256) NOT NULL,
    `event_title` varchar(256) NOT NULL,
    `url` varchar(200) NOT NULL,
    `project_id` integer NOT NULL,
    `original_filename` varchar(255) NOT NULL
)
;
CREATE TABLE `doc_type` (
    `type_id` varchar(32) NOT NULL PRIMARY KEY,
    `name` varchar(50) NOT NULL,
    `is_displayed` bool NOT NULL,
    `is_proposal_doc` bool NOT NULL,
    `is_restricted` bool NOT NULL,
    `is_published` bool NOT NULL,
    `are_downloads_tracked` bool NOT NULL,
    `is_downloader_info_tracked` bool NOT NULL,
    `has_description` bool NOT NULL,
    `has_citation` bool NOT NULL,
    `has_report_number` bool NOT NULL,
    `has_lulu_number` bool NOT NULL,
    `has_pub_date` bool NOT NULL,
    `has_report_order_url` bool NOT NULL,
    `has_event_type` bool NOT NULL,
    `has_event_title` bool NOT NULL,
    `has_publication_type` bool NOT NULL,
    `has_primary_audience` bool NOT NULL,
    `has_number_attending` bool NOT NULL,
    `has_location` bool NOT NULL,
    `has_url` bool NOT NULL
)
;
CREATE TABLE `file_download` (
    `download_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `doc_id` integer NOT NULL,
    `date` datetime NOT NULL,
    `ip` varchar(50) NOT NULL,
    `user_id` integer
)
;
CREATE INDEX `doc_403d8ff3` ON `doc` (`type_id`);
CREATE INDEX `doc_37952554` ON `doc` (`project_id`);
CREATE INDEX `file_download_fbbb6049` ON `file_download` (`doc_id`);
CREATE INDEX `file_download_6340c63c` ON `file_download` (`user_id`);

COMMIT;
