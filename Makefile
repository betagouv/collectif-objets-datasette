install:
	poetry install

prepare_sqlite:
	./scripts/prepare_sqlite.sh

datasette:
	poetry run datasette \
		--setting allow_facet off \
		--setting default_page_size 20 \
		--setting sql_time_limit_ms 10000 \
		--metadata metadata.yml \
		data.sqlite \
		metadata.sqlite

publish_datasette:
	poetry run datasette publish fly \
		--app collectif-objets-datasette \
		--setting allow_facet off \
		--setting default_page_size 20 \
		--metadata metadata.yml \
		data.sqlite \
		metadata.sqlite

