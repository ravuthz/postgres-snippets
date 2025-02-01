# Just PostgreSQL (psql) shared snippets




[Generate Added Columns](generate_added_cols.sql)

```sql
SELECT
    'ALTER TABLE ' || table_schema || '.' || table_name ||
    ' ADD COLUMN ' || column_name || ' ' || data_type ||
    COALESCE('(' || character_maximum_length || ')', '') ||
    CASE WHEN is_nullable = 'NO' THEN ' NOT NULL' ELSE '' END ||
    COALESCE(' DEFAULT ' || column_default, '') || ';' AS create_column_sql
FROM information_schema.columns
WHERE table_schema = '<schema_name>'
  AND table_name = '<table_name>'
  AND column_name IN (
    '<col_name_1>', '<col_name_2>'
  );

```
