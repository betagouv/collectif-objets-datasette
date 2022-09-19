install:
	poetry install

prepare_sqlite:
	./scripts/prepare_sqlite.sh

datasette:
	poetry run datasette data/collectif-objets.sqlite

publish_datasette:
	poetry run datasette publish fly data/collectif-objets.sqlite --app collectif-objets-datasette

