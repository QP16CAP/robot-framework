import csv

def read_csv_skip_empty(file_path):
    """
    Lit un CSV et ignore les lignes où une colonne est vide.
    Retourne une liste de dictionnaires (ou listes) pour Robot Framework.
    """
    cleaned_rows = []

    with open(file_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile, skipinitialspace=True)
        for row in reader:
            # Si une colonne est vide, on ignore la ligne
            if any(v.strip() == '' for v in row.values()):
                continue
            cleaned_rows.append(row)

    return cleaned_rows