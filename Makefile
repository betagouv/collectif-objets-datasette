install:
	poetry install

prepare_sqlite:
	./scripts/prepare_sqlite.sh

dev:
	poetry run datasette ./app

publish_datasette:
	poetry run datasette publish fly \
		--app collectif-objets-datasette \
		--extra-options="--setting suggest_facets off" \
		--metadata app/metadata.yml \
		app/*.sqlite

