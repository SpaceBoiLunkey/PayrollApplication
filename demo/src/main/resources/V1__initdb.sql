CREATE TABLE [IF NOT EXISTS] employee
(
 id int NOT NULL,
 first_name varchar(100) NOT NULL,
 last_name varchar(100) NOT NULL,
 role varchar(255) NOT NULL,
 created_at timestamp NOT NULL DEFAULT NOW()
 PRIMARY KEY (id)
);

CREATE TABLE [IF NOT EXISTS] customer_order
(
 id int NOT NULL,
 description varchar(255) NOT NULL,
 status int NOT NULL,
 created_at timestamp NOT NULL DEFAULT NOW()
 PRIMARY KEY (id)
);

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