install:
	poetry install

prepare_sqlite:
	rm -rf data/collectif-objets.sqlite
	poetry run csvs-to-sqlite data/palissy.csv data/collectif-objets.sqlite --index DPT --index INSEE
	poetry run csvs-to-sqlite data/mairies.csv data/collectif-objets.sqlite --index code_insee --index departement

datasette:
	poetry run datasette data/collectif-objets.sqlite --setting sql_time_limit_ms 10000 --setting max_returned_rows 50000


publish_datasette:
	poetry run datasette publish cloudrun data/collectif-objets.sqlite --memory 1024Mi --service collectif-objets-datasette
