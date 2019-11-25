# Generate a txt file with all the wine types used for
index = 1

# Based on what we wrote in the document
colorRange = ["Rose", "White", "Red"]
grapeVariety = ["Riesling", "Chardonnay", "Sauvignon Blanc", "Gewurztraminer", "Semillon", "Pinot Gris", "Viognier",
    "Chenin Blanc", "Muller-Thurgau", "Madeleine Angevine", "Siegerrebe", "Muscat Ottonel", "Orange Muscat", "Aligote",
    "Cabernet Sauvignon", "Merlot", "Syrah", "Cabernet Franc", "Malbec", "Pinot Noir", "Sangiovese", "Lemberger",
    "Grenache", "Zinfandel", "Barbera", "Petit Verdot", "Nebbiolo", "Mourvdre", "Petit Sirah"]
tierRange = ["Production", "Distribution", "Retail"]

fo = open("WINE_TYPE.csv", "w")

for variety in grapeVariety:
    for color in colorRange:
        for tier in tierRange:
            # If these are not the necessary wines, just change this write statement
            fo.write("%i, %s, %s, %s" %(index, variety, color, tier))
            if index < 261:
                fo.write("\n")
            index += 1
fo.close()

print("CSV files with wine types")