import sys

otuFile = sys.argv[1]
UniteTaxonomy = sys.argv[2]
RDPTaxonomy = sys.argv[3]

OTUs = {}

with open(otuFile, 'r') as INfile:
    for line in INfile:
        line = line.strip('\n').split('\t')
        myOTU = line[0]
        OTUs[myOTU]=[]
        for item in line[1:]:
            OTUs[myOTU].append(item)
Tax = {}

with open(UniteTaxonomy, 'r') as INfile:
    for line in INfile:
        line = line.strip('\n').split('\t')
        name = line[0]
        taxa = line[1]
        Tax[name]=taxa

RDP = {}

with open(RDPTaxonomy,'r') as INfile:
    for line in INfile:
        line = line.strip('\n').split('\t')
        name = line[0]
        taxa = line[1]
        RDP[name]=taxa

with open("Taxonomy.csv", 'w') as outfile:
    outfile.write("sample, Sequence#, OTU, kingdom, phylum, class, order, family, genus, species\n")
    for sample in OTUs.keys():
        try:
            Taxonomy = [x.split('__')[1] for x in Tax[sample].split(';')]
            for TaxID in OTUs[sample]:
                TaxID, myNum = TaxID.split('_')[0], TaxID.split('_')[1]
                outfile.write("%s, %s, %s, %s\n" %(TaxID, myNum, sample, ','.join(Taxonomy)))
        except KeyError:
            Taxonomy = [x.split('__')[1] for x in RDP[sample].split(';')]
            for TaxID in OTUs[sample]:
                TaxID, myNum = TaxID.split('_')[0], TaxID.split('_')[1]
                outfile.write("%s, %s, %s, %s\n" %(TaxID, myNum, sample, ','.join(Taxonomy)))

