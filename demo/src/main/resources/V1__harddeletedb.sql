CREATE OR REPLACE RULE "_soft_deletion"
  AS ON DELETE TO "employee"
  WHERE current_setting('rules.soft_deletion') = 'on'
  DO INSTEAD UPDATE employee SET deleted = true WHERE id = old.id;

CREATE OR REPLACE RULE "_soft_deletion"
  AS ON DELETE TO "customer_order"
  WHERE current_setting('rules.soft_deletion') = 'on'
  DO INSTEAD UPDATE employee SET deleted = true WHERE id = old.id;