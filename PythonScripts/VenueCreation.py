import random

# Generate a txt file with all the wine types used for
index = 1

title = ["", "The"]
venueName = ["Red", "Green", "Blue", "Purple", "Rose", "Flowers", "Historic", "Moonlight", "Pale Moon", "Tasting",
             "Sampling", "Pink", "Chocolate", "Gallery", "Blues", "Jazz"]

venueType = ["", "Room", "Gardens", "Farm", "Estate", "Club", "Hall", "Suite", "Park", "Center", "Building", "Reserve"]

# initialFile = open("WINE_TYPE.csv", "w")

fo = open("VENUES.csv", "w")

i = 0
while i < 50:
    venueCapacity = random.randrange(50, 1400)
    venueDimensions = venueCapacity * 8
    wineryID = random.randrange(1, 6)

    temp = random.randrange(0, 2)
    name = title[temp]
    if temp != 0:
        name += " "

    name += venueName[random.randrange(0, len(venueName))]

    temp = random.randrange(0, len(venueType))
    if temp != 0:
        name += " "
    name += venueType[temp]

    fo.write("%i,%s,%i,%i,%i" % (index, name, venueCapacity, venueDimensions, wineryID))
    if index < 50:
        fo.write("\n")
    index += 1
    i += 1

fo.close()

print("CSV files with venues")