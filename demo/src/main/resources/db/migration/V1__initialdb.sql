CREATE TABLE employee
(
 id int PRIMARY KEY NOT NULL,
 first_name varchar(100) NOT NULL,
 last_name varchar(100) NOT NULL,
 role varchar(255) NOT NULL
);

CREATE TABLE customer_order
(
 id int PRIMARY KEY NOT NULL,
 description varchar(255) NOT NULL,
 status int NOT NULL
);

ALTER TABLE employee
    ADD COLUMN deleted BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT NOW();

ALTER TABLE customer_order
    ADD COLUMN deleted BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN created_at timestamp NOT NULL DEFAULT NOW();

CREATE OR REPLACE RULE "_soft_deletion" AS ON DELETE TO "employee" DO INSTEAD (
  UPDATE employee SET deleted = true WHERE id = old.id AND NOT deleted
);

CREATE OR REPLACE RULE "_soft_deletion" AS ON DELETE TO "customer_order" DO INSTEAD (
  UPDATE customer_order SET deleted = true WHERE id = old.id AND NOT deleted
);

ALTER TABLE customer_order RENAME TO _customer_order;
CREATE VIEW customer_order AS SELECT * FROM _customer_order WHERE NOT deleted;
SELECT * FROM customer_order ORDER BY id;

ALTER TABLE employee RENAME TO _employee;
CREATE VIEW employee AS SELECT * FROM _employee WHERE NOT deleted;
SELECT * FROM employee ORDER BY id;

INSERT INTO "payrollApplication"._customer_order(
	id, description, status, deleted, created_at)
	VALUES (1, 'Apple Watch', 1, FALSE, default), (2, 'iPad Pro', 0, TRUE, default);

INSERT INTO "payrollApplication"._employee(
	id, first_name, last_name, role, deleted, created_at)
	VALUES (1, 'Kalvin', 'McClure', 'Developer', FALSE, default), (2, 'John', 'Smith', 'Guinea Pig', TRUE, default);