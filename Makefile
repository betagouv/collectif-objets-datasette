install:
	poetry install

prepare_sqlite:
	rm -rf data/collectif-objets.sqlite
	poetry run csvs-to-sqlite data/palissy.csv data/collectif-objets.sqlite --index DPT
	poetry run csvs-to-sqlite data/mairies.csv data/collectif-objets.sqlite --index code_insee

datasette:
	poetry run datasette data/collectif-objets.sqlite

publish_datasette:
	poetry run datasette publish cloudrun data/collectif-objets.sqlite --memory 1024Mi --service datasette
