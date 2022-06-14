# Collectif Objets Datasette

Serveur web public publiant des données utilisées par Collectif Objets

- les tables scrappées depuis l'API de POP via [pop-scraper](https://github.com/adipasquale/pop-scraper)
- les informations des mairies récupérées depuis les exports de service-public.fr

## Scripts

- `make datasette` démarre un serveur local
- `make prepare_sqlite` recrée la DB SQlite locale à partir des fichiers CSVs
- `make publish_datasette` déploie sur Google Cloud Run (qui permet de scaler à 0 entre les requêtes peu fréquentes)


##

http://127.0.0.1:8001/collectif-objets.json?_shape=objects&sql=select+%0D%0A++mairies.code_insee%2C+%0D%0A++mairies.nom%2C+%0D%0A++COUNT(palissy.REF)+as+objets_count%2C%0D%0A++mairies.latitude%2C+%0D%0A++mairies.longitude%0D%0Afrom+palissy%0D%0AINNER+JOIN+mairies+ON+mairies.code_insee+%3D+palissy.INSEE%0D%0AGROUP+BY+mairies.code_insee%0D%0AORDER+BY+mairies.code_insee+ASC

SELECT DPT as departement, count(REF) as objets_count
FROM palissy
WHERE DPT IS NOT NULL
GROUP BY DPT
ORDER BY DPT ASC;
