\connect postgres postgres

DROP TABLE IF EXISTS "tbl_1";
CREATE TABLE "tbl_1" (
  "column_1" integer
);

CREATE SCHEMA IF NOT EXISTS "app-ws_test";
CREATE TABLE IF NOT EXISTS "app-ws_test"."tbl_1" (
  "column_1" integer,
  "column_2" text
);
