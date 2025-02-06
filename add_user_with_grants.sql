-- Create user "dev1" with password "dev123"
CREATE USER dev1 WITH PASSWORD 'dev123';

-- Allow "dev1" to connect to "test_db_1" database
GRANT CONNECT ON DATABASE test_db_1 TO dev1;

-- Allow "dev1" to access to "public" schema
GRANT USAGE ON SCHEMA public TO dev1;

-- Allow "dev1" to read only on all tables of "public" schema
GRANT SELECT ON ALL TABLES IN SCHEMA public TO dev1;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO dev1;


-- Allow "dev1" to read and write to all tables of "public" schema
GRANT INSERT, UPDATE, DELETE, SELECT ON ALL TABLES IN SCHEMA public TO dev1;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT, UPDATE, DELETE, SELECT ON TABLES TO dev1;

-- Allow "dev1" to full access to all tables of "public" schema
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO dev1;
-- I does the same actions to 'GRANT ALL' 
ALTER DEFAULT PRIVILEGES IN SCHEMA lmdev
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER ON TABLES TO dev1;


-- Allow "dev1" to full access to all sequences of "public" schema
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO dev1;


-- Check current login user and selected database
SELECT current_user, current_database();

-- List all granted tables
SELECT grantor, grantee, table_catalog, table_schema, table_name, 
  array_agg(privilege_type ORDER BY privilege_type ASC)
FROM information_schema.role_table_grants
WHERE grantee = 'dev1'
GROUP BY 1,2,3,4,5;
