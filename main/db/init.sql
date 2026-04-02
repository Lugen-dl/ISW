
CREATE TABLE targets AS
SELECT 'Max Connections' as target, current_setting('max_connections') as value
UNION ALL SELECT 'Shared Buffers' , current_setting('shared_buffers')
UNION ALL SELECT 'Autovacuum Status', current_setting('autovacuum')
UNION ALL SELECT 'Data Directory', current_setting('data_directory');

CREATE TABLE vulnerabilities AS

SELECT 'Empty passwords' as check_name, count(*)::text as result FROM pg_shadow WHERE passwd IS NULL
UNION ALL

SELECT 'Superusers count', count(*)::text FROM pg_authid WHERE rolsuper = true
UNION ALL

SELECT 'Public schema access', count(*)::text FROM information_schema.usage_privileges 
WHERE grantee = 'PUBLIC' AND object_schema = 'public'
UNION ALL

SELECT 'Non-SSL sessions', count(*)::text FROM pg_stat_ssl WHERE ssl = false;

CREATE TABLE scanlogs AS

SELECT 'Cache Hit Rate (%)' as metric, round(sum(blks_hit)*100 / nullif(sum(blks_hit+blks_read),0), 2)::text as value FROM pg_stat_database
UNION ALL

SELECT 'Active sessions', count(*)::text FROM pg_stat_activity WHERE state = 'active'
UNION ALL

SELECT 'Temp files (MB)', (sum(temp_bytes)/(1024*1024))::text FROM pg_stat_database
UNION ALL

SELECT 'Waiting queries', count(*)::text FROM pg_stat_activity WHERE wait_event IS NOT NULL;
