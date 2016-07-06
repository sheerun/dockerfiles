#!/usr/bin/env bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	CREATE USER sheerun;
	CREATE DATABASE sheerun;
	CREATE DATABASE sheerun_history;
	GRANT ALL PRIVILEGES ON DATABASE sheerun TO sheerun;
	GRANT ALL PRIVILEGES ON DATABASE sheerun_history TO sheerun;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d sheerun <<-EOSQL
CREATE EXTENSION pglogical;
SELECT pglogical.create_node(
	node_name := 'provider',
	dsn := 'host=0.0.0.0 port=5432 dbname=sheerun'
);
CREATE OR REPLACE FUNCTION pglogical_assign_repset()
RETURNS event_trigger AS \$$
DECLARE obj record;
BEGIN
		FOR obj IN SELECT * FROM pg_event_trigger_ddl_commands()
		LOOP
				IF obj.object_type = 'table' THEN
						IF obj.schema_name = 'config' THEN
								PERFORM pglogical.replication_set_add_table('configuration', obj.objid, synchronize_structure := true);
						ELSIF NOT obj.in_extension THEN
								PERFORM pglogical.replication_set_add_table('default', obj.objid, synchronize_structure := true);
						END IF;
				END IF;
		END LOOP;
END;
\$$ LANGUAGE plpgsql;
CREATE EVENT TRIGGER pglogical_assign_repset_trg
		ON ddl_command_end
		WHEN TAG IN ('CREATE TABLE', 'CREATE TABLE AS')
		EXECUTE PROCEDURE pglogical_assign_repset();
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d sheerun_history <<-EOSQL
CREATE EXTENSION pglogical;
SELECT pglogical.create_node(
	node_name := 'subscriber',
	dsn := 'host=0.0.0.0 port=5432 dbname=sheerun_history'
);
SELECT pglogical.create_subscription(
	subscription_name := 'subscription1',
	provider_dsn := 'host=0.0.0.0 port=5432 dbname=sheerun',
	synchronize_structure := true
);
EOSQL
