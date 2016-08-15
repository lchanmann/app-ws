seed:
	echo "DROP ROLE IF EXISTS postgres; CREATE ROLE postgres LOGIN;" | psql -p 6432 `whoami` -d postgres
	psql -p 6432 -f booktown.sql postgres `whoami`

db_test_prepare:
	psql -p 6432 -f db/test_prepare.sql postgres `whoami`

