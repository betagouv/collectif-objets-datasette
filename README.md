# Collectif Objets Datasette

Serveur web public publiant des données utilisées par Collectif Objets

1. Tous les objets de Palissy
2. Les informations publiques des mairies (email, coordonnées)

## Installation

- installer Poetry
- `poetry install`

## Origine des CSV sources

Il faut récupérer plusieurs fichiers CSV :

- `data_scrapped/palissy.csv`
- `data_scrapped/palissy_to_memoire.csv`
- `data_scrapped/palissy_to_merimee.csv`
- `data_scrapped/merimee.csv`
- `data_scrapped/merimee_to_memoire.csv`

Ces 5 CSVs proviennent de scrapings de POP lancé sur leur API ElasticSearch via [pop-scraper](https://github.com/adipasquale/pop-scraper)

- `metadata/memoire.csv`
- `metadata/merimee.csv`
- `metadata/palissy.csv`

Ces fichiers décrivant les colonnes des tables POP proviennent du code source de POP : [github.com/betagouv/pop/tree/master/apps/api/csv](https://github.com/betagouv/pop/tree/master/apps/api/csv).

Enfin `data_scrapped/mairies.csv` est récupérable depuis le repo [data](https://github.com/adipasquale/collectif-objets-data). Le fichier original est récupéré via [ce fork d'annuaire-api](https://github.com/BaseAdresseNationale/annuaire-api) puis transformé par un notebook python.

## Scripts

- `make prepare_sqlite` regénère `/data.sqlite` et `/metadata.sqlite` à partir des fichiers CSV sources.
- `make dev` démarre un serveur local
- `make publish_datasette` déploie sur Google Cloud Run (qui permet de scaler à 0 entre les requêtes peu fréquentes)

## Exemples de requêtes

http://127.0.0.1:8001/collectif-objets.json?_shape=objects&sql=select+%0D%0A++mairies.code_insee%2C+%0D%0A++mairies.nom%2C+%0D%0A++COUNT(palissy.REF)+as+objets_count%2C%0D%0A++mairies.latitude%2C+%0D%0A++mairies.longitude%0D%0Afrom+palissy%0D%0AINNER+JOIN+mairies+ON+mairies.code_insee+%3D+palissy.INSEE%0D%0AGROUP+BY+mairies.code_insee%0D%0AORDER+BY+mairies.code_insee+ASC

SELECT DPT as departement, count(REF) as objets_count
FROM palissy
WHERE DPT IS NOT NULL
GROUP BY DPT
ORDER BY DPT ASC;
