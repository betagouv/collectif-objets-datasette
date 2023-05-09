install:
	poetry install

prepare_sqlite:
	./scripts/prepare_sqlite.sh

dev:
	poetry run datasette ./app

deploy:
	poetry run datasette publish fly \
		--app collectif-objets-datasette \
		--extra-options="--setting suggest_facets off --setting sql_time_limit_ms 10000" \
		--metadata app/metadata.yml \
		app/*.sqlite

