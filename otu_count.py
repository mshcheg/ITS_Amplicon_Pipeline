'''

creates a file summarizing read counts and OTU counts per sample 

'''
import sys

OTUfile = sys.argv[1]
inDir = sys.argv[2]
outDir = sys.argv[3]

TempFile = "%s/temp_read_dictionary.txt" %inDir
OTUs = {}
Counts = open(TempFile,'r').read() 
Counts = eval(Counts)

if 'PrimerType' in Counts: del Counts['PrimerType']

with open(OTUfile, 'r') as INfile:
    for line in INfile:
        line = line.strip('\n').split('\t')
        for item in line[1:]:
            item = item.split('_')[0]
            try:
                if line[0] in OTUs[item]:
                    continue
                else:
                    OTUs[item].append(line[0])
            except KeyError:
                OTUs[item] = [line[0]]

outFile = "%s/Read_OTU_Counts.csv" %outDir
with open(outFile,'w') as outfile:
    outfile.write('Sample, Reads, OTUs\n')
    for sample in Counts.keys():
        try:
            outfile.write("%s, %s, %s\n" %(sample, str(Counts[sample]), str(len(OTUs[sample]))))
        except KeyError:
            outfile.write("%s, %s, 0\n" %(sample, str(Counts[sample])))
