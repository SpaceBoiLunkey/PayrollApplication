-- let's suggest we are at the initial stage with employee and customer_order

ALTER TABLE employee RENAME TO _employee;
CREATE VIEW employee AS SELECT * FROM employee WHERE deleted IS NULL OR NOT deleted;

ALTER TABLE customer_order RENAME TO _customer_order;
CREATE VIEW customer_order AS SELECT * FROM _customer_order WHERE deleted IS NULL OR NOT deleted;

CREATE OR REPLACE RULE _soft_deletion AS ON DELETE TO customer_order DO INSTEAD (
  UPDATE _customer_order SET deleted = true WHERE id = old.id
);

CREATE OR REPLACE RULE _soft_deletion AS ON DELETE TO employee DO INSTEAD (
  UPDATE employee SET deleted = true WHERE id = old.id
);

-- FOR RELATED TABLES WITH PK AND FK --
-- here we deal with updates in _employee table, not with a view
--CREATE RULE _delete_customer_order AS ON UPDATE TO _employee
--  WHERE old.deleted IS NULL OR NOT old.deleted AND new.deleted
--  DO ALSO UPDATE _employee SET deleted = true WHERE user_id = old.id;