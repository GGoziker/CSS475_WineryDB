import random
import decimal

index = 1
names = ["quam", "eu", "auctor gravida", "fusce", "volutpat quam", "id ligula", "at", "varius", "mauris vulputate", "lorem", "tincidunt ante", "integer", "lobortis ligula", "diam", "donec", "non", "vivamus", "vel dapibus", "in lectus", "donec", "posuere cubilia", "vestibulum sed", "erat", "orci mauris", "a", "cubilia curae", "pellentesque", "ipsum primis", "hac habitasse", "primis in", "neque libero", "luctus et", "vitae", "maecenas leo", "velit donec", "viverra eget", "pellentesque quisque", "justo aliquam", "eros vestibulum", "tellus", "nec", "justo nec", "tellus nisi", "quam a", "eu interdum", "vestibulum sit", "purus aliquet", "diam id", "felis", "quam pharetra", "aliquet", "ipsum", "odio condimentum", "curae", "accumsan", "porttitor pede", "primis in", "tortor id", "nullam orci", "condimentum neque", "posuere cubilia", "justo", "ac", "id ornare", "mattis", "nullam orci", "pede", "duis bibendum", "at nunc", "ipsum", "volutpat", "interdum", "montes nascetur", "maecenas tincidunt", "montes", "non", "purus", "vivamus tortor", "ultrices posuere", "non sodales", "id turpis", "lobortis", "mauris ullamcorper", "nascetur", "tincidunt", "in quam", "a", "sit amet", "dignissim vestibulum", "fusce posuere", "tortor sollicitudin", "fermentum donec", "convallis", "morbi", "venenatis", "elementum", "elementum eu", "cubilia curae", "vestibulum eget", "eros", "id", "felis", "lorem", "ligula in", "vel", "nunc", "ultricies eu", "nec condimentum", "amet", "justo sit", "habitasse", "duis bibendum", "vitae nisi", "ipsum integer", "eget eros", "a feugiat", "turpis a", "odio", "congue", "ut mauris", "id", "nec euismod", "massa", "nulla ultrices", "volutpat erat", "ut", "faucibus", "nisl ut", "amet", "ac", "vivamus", "ullamcorper purus", "amet erat", "ultrices", "a nibh", "ipsum", "augue", "massa tempor", "vestibulum", "suspendisse ornare", "metus arcu", "at dolor", "a", "ac consequat", "placerat praesent", "duis faucibus", "nisl", "consectetuer", "orci", "arcu libero", "nec", "non quam", "id", "in sapien", "augue vel", "ut", "porttitor", "vel", "nullam orci", "eu orci", "adipiscing", "amet", "consequat", "ut massa", "cum", "at feugiat", "mi in", "suspendisse", "est", "posuere cubilia", "rutrum", "orci", "tellus", "tristique", "ultrices enim", "lobortis", "convallis duis", "non", "in faucibus", "libero quis", "lobortis ligula", "integer a", "nulla sed", "quis libero", "ac", "faucibus orci", "erat id", "iaculis diam", "elementum", "etiam", "laoreet", "dignissim", "semper interdum", "interdum mauris", "sit amet", "enim leo", "quisque", "curae", "potenti", "blandit mi", "interdum", "libero", "faucibus", "integer", "accumsan", "justo sollicitudin", "ac nibh", "amet diam", "luctus cum", "integer a", "lectus", "aliquet at", "eu", "vehicula condimentum", "sem", "vel accumsan", "odio", "quis", "turpis", "pellentesque viverra", "dui", "quam", "aenean", "maecenas", "nunc proin", "ac est", "velit", "pede", "nisi", "vel accumsan", "amet sapien", "odio odio", "facilisi", "lacus morbi", "eros", "id pretium", "velit", "vulputate", "porttitor", "consequat", "fermentum donec", "iaculis", "convallis", "risus", "ac", "duis faucibus", "eleifend donec", "morbi", "vestibulum sagittis", "lacinia eget", "ac", "magnis dis", "lorem quisque", "id massa", "habitasse platea", "amet eros", "potenti cras", "odio porttitor", "cursus urna", "faucibus accumsan", "ante ipsum", "justo", "turpis", "placerat", "sem", "dictumst", "a", "non", "duis", "quis", "ante vel", "faucibus", "cursus", "vestibulum ante", "nisi", "justo pellentesque", "et ultrices", "orci mauris", "luctus cum", "vitae mattis", "etiam", "nunc", "sed", "nulla", "posuere cubilia", "at turpis", "pede justo", "natoque", "nulla ut", "feugiat", "ut dolor", "venenatis", "amet nulla", "habitasse platea", "diam", "ultricies eu", "sem fusce", "elementum", "rutrum nulla", "id nulla", "lorem integer", "tortor quis", "amet sapien", "eget", "turpis nec", "amet", "tortor quis", "suscipit", "id ligula", "suscipit", "eu mi", "pretium nisl", "consequat dui", "odio in", "pulvinar", "diam nam", "lacus", "tempus", "ridiculus mus", "quis", "orci", "cursus", "phasellus", "aenean fermentum", "dolor vel", "faucibus", "varius", "ultrices libero", "magna", "eu sapien", "lacus morbi", "congue", "lacinia", "a libero", "vel", "volutpat convallis", "rutrum nulla", "neque", "convallis duis", "amet", "quam", "est", "mattis", "vel augue", "sit", "condimentum", "sociis", "duis bibendum", "vestibulum", "vitae nisi", "eget vulputate", "vel", "erat volutpat", "nullam", "placerat praesent", "sit amet", "donec", "pede justo", "enim", "vestibulum ante", "ac lobortis", "consectetuer adipiscing", "platea", "ullamcorper", "massa tempor", "pharetra magna", "eget", "in leo", "quisque", "aliquet ultrices", "tristique tortor", "in ante", "pede", "eu", "ultrices", "augue", "eu", "dui", "sagittis", "interdum", "nunc proin", "ridiculus mus", "at", "mattis", "quis orci", "ultrices", "posuere nonummy", "convallis", "orci", "tellus", "habitasse platea", "id", "massa tempor", "iaculis justo", "suspendisse ornare", "nascetur ridiculus", "eget", "odio porttitor", "justo", "pede", "cras mi", "ut mauris", "sed", "amet", "vestibulum", "ut suscipit", "varius", "lectus pellentesque", "venenatis turpis", "suspendisse", "in", "eleifend luctus", "ultrices", "pharetra magna", "at nulla", "cras", "mi", "elementum", "purus phasellus", "justo morbi", "nulla elit", "ac", "quam sapien", "ipsum", "proin", "in faucibus", "integer pede", "nulla", "consequat dui", "ut", "maecenas rhoncus", "ultrices", "in", "semper rutrum", "vehicula condimentum", "ullamcorper", "luctus", "nibh quisque", "pellentesque eget", "faucibus orci", "ut", "eget rutrum", "dapibus", "elit", "sodales", "lobortis convallis", "diam vitae", "iaculis congue", "est", "tortor sollicitudin", "ut", "fusce posuere", "id", "pharetra magna", "nonummy integer", "ullamcorper", "pellentesque", "eget vulputate", "quisque ut", "mauris", "sapien", "orci", "mauris eget", "risus auctor", "congue eget", "platea", "vel", "sit amet", "semper est", "nulla sed", "tincidunt", "tempor", "neque", "neque duis", "risus", "non", "erat", "ut", "sit", "commodo vulputate", "posuere", "ut", "eleifend", "ultrices vel", "non mi", "rhoncus aliquet", "nisl", "ut", "mi", "non", "non quam", "mauris", "consequat morbi", "mattis", "at ipsum", "leo odio", "vel", "in felis", "accumsan tellus", "accumsan tellus", "maecenas", "blandit", "scelerisque", "sociis natoque", "faucibus orci", "vivamus", "magna", "nec", "vitae ipsum", "morbi", "ut nunc", "id luctus", "quis orci", "sit amet", "nisi eu", "ultrices", "in libero", "habitasse", "sed sagittis", "luctus et", "nulla", "duis", "nec", "vulputate justo", "sapien", "quis justo", "rutrum rutrum", "ac", "faucibus orci", "aliquet at", "turpis elementum", "vestibulum", "dapibus", "etiam faucibus", "hendrerit at", "nibh", "nisl duis", "pede", "leo maecenas", "justo eu", "nec euismod", "amet diam", "sem fusce", "ut mauris", "tristique tortor", "luctus cum", "potenti", "amet turpis", "congue diam", "ipsum primis", "ipsum", "amet diam", "nec nisi", "adipiscing molestie", "lorem", "leo odio", "volutpat eleifend", "justo", "interdum", "sociis", "blandit", "luctus et", "sed", "potenti cras", "aliquet", "nulla eget", "in sapien", "donec ut", "congue risus", "a feugiat", "lobortis sapien", "at turpis", "nibh ligula", "ipsum", "lacus morbi", "eget rutrum", "aliquam", "nulla elit", "molestie nibh", "lobortis", "mauris", "tempor", "lacus", "sapien", "ligula sit", "lobortis sapien", "pede morbi", "porta volutpat", "faucibus orci", "justo maecenas", "porttitor", "nisi nam", "in", "massa", "vivamus in", "vitae nisi", "sapien dignissim", "est", "vulputate", "in leo", "porta volutpat", "leo", "primis", "nulla suscipit", "fermentum justo", "augue", "eleifend donec", "sit amet", "lacinia aenean", "donec", "rhoncus sed", "nec", "faucibus", "risus", "diam", "tincidunt eu", "lobortis", "nulla", "consequat in", "platea dictumst", "tortor", "accumsan tellus", "turpis", "vivamus", "nullam porttitor", "vitae consectetuer", "sollicitudin vitae", "integer", "placerat", "venenatis", "eget orci", "pellentesque ultrices", "integer non", "volutpat erat", "elementum ligula", "pede", "mauris morbi", "nulla", "tempus", "in", "vulputate", "quis odio", "porttitor lorem", "nulla", "sapien quis", "erat vestibulum", "primis", "metus", "blandit nam", "ut", "felis donec", "mauris", "justo", "dis parturient", "turpis", "lacus morbi", "molestie", "lobortis", "sed", "enim", "dapibus", "posuere felis", "magnis dis", "pede", "lacus at", "sapien", "condimentum curabitur", "sed ante", "lectus suspendisse", "cursus", "vestibulum ac", "mus etiam", "eu magna", "amet nulla", "convallis nulla", "ante", "sed accumsan", "diam in", "dolor", "vestibulum", "aliquet", "diam", "at nibh", "at", "molestie", "lobortis vel", "rutrum neque", "vulputate ut", "lobortis est", "rutrum", "quis odio", "ac", "pede morbi", "sit amet", "est quam", "blandit", "donec", "vivamus vestibulum", "vel dapibus", "hac habitasse", "nec", "quam", "feugiat", "tortor eu", "accumsan odio", "eros viverra", "aliquam", "nec", "eu nibh", "sit", "libero non", "libero convallis", "rutrum rutrum", "maecenas tincidunt", "est quam", "donec", "ultrices posuere", "sit amet", "ante vivamus", "dolor", "rutrum ac", "sit", "aliquam convallis", "sed vel", "libero quis", "pellentesque", "nisi nam", "odio consequat", "ante ipsum", "convallis nunc", "neque", "suspendisse", "sapien", "molestie", "porttitor", "bibendum", "consequat in", "libero", "magna", "mus etiam", "mauris", "nec", "augue a", "velit vivamus", "lectus", "pede", "sed", "vitae nisi", "adipiscing elit", "massa", "turpis elementum", "at", "nulla", "quis justo", "lacinia", "ante", "vel", "sed lacus", "montes", "consequat", "molestie nibh", "ac", "aliquam", "eu", "dolor sit", "massa volutpat", "primis", "volutpat", "est", "est", "nulla dapibus", "ut blandit", "tincidunt", "nulla", "eleifend donec", "vestibulum", "tincidunt", "mus", "maecenas tristique", "pharetra", "sapien", "eget nunc", "ut", "vitae mattis", "leo pellentesque", "nullam", "ultrices", "quam", "erat fermentum", "ante", "eget", "quisque id", "nec nisi", "augue", "est congue", "lacinia eget", "iaculis", "ante vestibulum", "et eros", "in", "sem", "nulla ultrices", "curabitur", "posuere", "congue eget", "sed lacus", "sit", "arcu", "pede", "et", "mauris", "interdum mauris", "adipiscing elit", "a suscipit", "mi", "eget", "erat eros", "metus", "erat volutpat", "turpis donec", "ut erat", "diam erat", "tortor", "quis", "molestie", "maecenas", "lectus", "donec", "nam nulla", "ac leo", "orci", "ipsum primis", "vel", "pede", "lacus", "quis turpis", "potenti", "et", "non", "nisl", "nulla", "cubilia curae", "quam", "fringilla", "lectus pellentesque", "morbi quis", "aliquet massa", "cras in", "a", "nunc commodo", "leo rhoncus", "vel pede", "non", "justo", "nulla neque", "nisi", "congue", "ligula", "justo", "habitasse platea", "ipsum primis", "diam", "massa", "pulvinar sed", "nulla eget", "magna vestibulum", "curabitur convallis", "in", "viverra dapibus", "mi", "rhoncus", "viverra dapibus", "faucibus accumsan", "aliquam sit", "habitasse", "nam tristique", "a feugiat", "sapien a", "justo", "platea", "in lacus", "platea", "consequat dui", "tincidunt nulla", "at", "at turpis", "rutrum at", "id pretium", "eget tincidunt", "sapien", "lorem", "tempus", "odio in", "in sapien", "felis donec", "in", "id", "condimentum neque", "dictumst morbi", "amet eleifend", "integer", "molestie sed", "condimentum curabitur", "posuere", "morbi ut", "auctor", "non mattis", "lobortis est", "nascetur ridiculus", "cubilia curae", "nisl nunc", "ipsum", "ultrices posuere", "id lobortis", "nam", "elit", "morbi porttitor", "id justo", "aliquet", "consectetuer eget", "nonummy integer", "in libero", "aliquam", "duis mattis", "hac", "vel lectus", "ornare consequat", "condimentum curabitur", "ut", "pede lobortis", "morbi", "arcu adipiscing", "turpis", "semper", "nunc proin", "vestibulum eget", "pulvinar lobortis", "turpis", "id", "a", "tellus in", "ut suscipit", "curabitur", "cubilia curae", "mattis pulvinar", "nulla tempus", "nulla", "ridiculus", "est", "nibh in", "ut", "etiam pretium", "at nibh", "enim in", "duis mattis", "tortor", "lacus purus", "morbi vel", "velit nec", "cubilia", "id", "parturient montes", "ipsum primis", "integer", "in purus", "pede ullamcorper", "ipsum", "aliquet massa", "feugiat", "nascetur ridiculus", "varius integer", "lectus in", "dolor quis", "dictumst", "pede", "ligula", "justo in", "sed justo", "magna vulputate", "ac nibh", "sed", "vitae", "non mi", "tortor", "ultrices", "in lectus", "nibh", "ante", "sem", "ut odio", "sem praesent", "quis", "orci eget", "primis", "nulla ultrices", "nulla", "nibh", "luctus ultricies", "nulla ultrices", "eros"]
volumes = [187.5, 375, 750, 1000, 1500, 3000, 4500, 6000, 9000, 12000, 15000]

fo = open("WINE_BOTTLE.csv", "w")

i = 0
while i < 1000:

    Name = names[i]
    Year = random.randrange(1980, 2019)
    Rating = random.randrange(0, 101)
    Alcohol = float(decimal.Decimal(random.randrange(55, 156)) / 10)
    Volume = volumes[random.randrange(0, len(volumes))]
    Price = float(decimal.Decimal(random.randrange(500, 1000001)) / 100)
    CellarID = random.randrange(1, 27)
    WineTypeID = random.randrange(1, 262)

    fo.write("%i,%s,%i,%i,%0.2f,%0.2f,%0.2f,%i,%i" %(index, Name, Year, Rating, Alcohol, Volume, Price, CellarID, WineTypeID))
    if i < 1000 - 1:
        fo.write("\n")

    i += 1
    index += 1

fo.close()
