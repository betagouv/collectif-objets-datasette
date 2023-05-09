import json
import os
import sys
import pandas as pd

# eg: poetry run python scripts/prepare_mairies_csv.py ../../annuaire-api/dataset.json

# run yarn build in https://github.com/BaseAdresseNationale/annuaire-api to get this dataset


def relpath(path):
    return os.path.join(os.path.dirname(__file__), path)


dataset_path = os.path.join(os.getcwd(), sys.argv[1])
if not os.path.isfile(dataset_path):
    raise Exception("first argument should be a path to the dataset json file")

f = open(dataset_path, "r")
df = pd.json_normalize(json.loads(f.read()))
f.close()

df2 = df[
    (df["properties.pivotLocal"] == "mairie") &
    (~df["properties.nom"].str.startswith("Mairie déléguée"))
].rename(columns={
    "properties.codeInsee": "code_insee",
    "properties.nom": "nom",
    "properties.email": "email",
    "properties.telephone": "telephone",
    "properties.url": "url",
    "geometry.coordinates": "coordinates",
    "properties.horaires": "horaires",
    "properties.url": "url"
})
# df2["latitude"] = df2["coordinates"].apply(lambda r: r[0])
# df2["longitude"] = df2["coordinates"].apply(lambda r: r[1])
df2["departement"] = df2["code_insee"].apply(lambda r: r[0:2])
df2.nom = df2.nom.apply(lambda r: r.replace("Mairie - ", ""))
df2.set_index("code_insee", inplace=True)
df2.sort_values(by="code_insee", inplace=True)
df2 = df2[["nom", "departement",
           "email", "telephone", "url", "coordinates"]]
df2

df2.to_csv(relpath("../data_scrapped/mairies.csv"))
