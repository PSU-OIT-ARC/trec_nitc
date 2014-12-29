USE ppms_for_drupal;
BEGIN;
INSERT INTO project (title, created_date, cost, abstract, start_date, end_date, is_project, grant_cycle_id, is_published, grant_type_id, is_highlighted)
VALUES 
('Project FooBar', NOW(), '10000', 'This is the foobar project abstract statement', NOW(),DATE_ADD(NOW(), INTERVAL 2 MONTH), 1, 1, 1, 'RESEARCH', 1),
('Project LoremIpsum', NOW(), '5000', 'This is the loremipsum project abstract statement', NOW(), DATE_ADD(NOW(), INTERVAL 2 MONTH), 1, 2, 1, 'RESEARCH', 0),
('Project poremipIpsum', NOW(), '5000', 'This is the plorepmipsum project abstract statement', NOW(), DATE_ADD(NOW(), INTERVAL 4 MONTH), 1, 3, 1, 'EDUCATION', 1),
('Project about Transportation', NOW(), '5000', 'This is the about transportation project abstract statement', NOW(), DATE_ADD(NOW(), INTERVAL 5 MONTH), 1, 4, 1, 'TECH_TRANSFER', 1),
('SIaedrwalk vProject LoremIpsum', NOW(), '5000', 'This is the Siderwalker dproject abstract statement', NOW(), DATE_ADD(NOW(), INTERVAL 6 MONTH), 1, 2, 0, 'RESEARCH', 1),
('Project Transport Bus LoremIpsum', NOW(), '5000', 'This is the transport project abstract statement', NOW(), DATE_ADD(NOW(), INTERVAL 7 MONTH), 1, 4, 1, 'STUDENT_GROUP', 1);

INSERT INTO grant_cycle (name) VALUES 
('otrec 2007'),
('otrec 2008'),
('NITC round 1'),
('NITC round 2');

INSERT INTO project_grant_type (grant_type_id, name, is_displayed) 
 VALUES
('RESEARCH', 'Research', True),
('EDUCATION', 'Education', True),
('TECH_TRANSFER', 'Technology Transfer', True),
('STUDENT_GROUP', 'Student Groups', True);

INSERT INTO user (email, first_name, last_name, org_id )
VALUES
('bob@foobar.com', 'Bob', 'Builder', 1),
('le@fender.com', 'Leo', 'Fender', 1),
('hanky@foobar.edu', 'Hank', 'Toots', 2),
('mikey@foobar.edu', 'Mike', 'PowerToots', 2);

INSERT INTO project_user (user_id, project_id, org_id, project_role_id)
VALUES
(1,1,1,'PI'),
(1,2,2, 'PI'),
(2,4,1, 'PI'),
(3,4,1, 'CO_PI');

INSERT INTO org (name) VALUES
('Portland State University'),
('University of Oregon');

INSERT INTO project_subjects (project_id, subject_id) VALUES
(1,1),
(2,2),
(3,2);

INSERT INTO subject (name) VALUES ('Bicycling'), ('Walking'), ('Safety');    

COMMIT;
