install:
	poetry install

prepare_sqlite:
	./scripts/prepare_sqlite.sh

datasette:
	poetry run datasette data/collectif-objets.sqlite --setting sql_time_limit_ms 10000 --setting max_returned_rows 50000

publish_datasette:
	poetry run datasette publish fly data/collectif-objets.sqlite --app collectif-objets-datasette

