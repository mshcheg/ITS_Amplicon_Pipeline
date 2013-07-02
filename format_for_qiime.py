'''

OLD HEADER: >HWI-M01380:15:000000000-D008W:1:1101:12265:3735:|Echo194|F fungi ITS sequence (372 bp) on main strand

NEW HEADER: >PC.634_1 FLP3FBN01ELBSX orig_bc=ACAGAGTCGGCT new_bc=ACAGAGTCGGCT bc_diffs=0


'''
import sys

File = sys.argv[1]
Targets = sys.argv[2]
counter = {}

#build a dictionary mapping barcode to sample 

EchoDic = {}
with open(Targets,'r') as infile:
    for line in infile:
        line = line.split()
        EchoDic[line[0]] = line[3]

for i in EchoDic:
    counter[EchoDic[i]]=0

with open(File, 'r') as FastaFile:
    while 1: #initiate infinite loop
    #read 4 lines of the fasta file
        SequenceHeader = FastaFile.readline()
        if SequenceHeader == '':
            break
        SequenceHeader = SequenceHeader.split('|')
        Barcode = SequenceHeader[1]
        Sample = EchoDic[Barcode]
        counter[Sample]+=1
        SequenceID = SequenceHeader[0].strip('>').strip(':')
        Sequence = FastaFile.readline()
        SampleID = '%s_%s' %(Sample, str(counter[Sample]))
        NewFile = 'qiime_formated.fasta' 
        with open(NewFile, 'a') as OutFile:
            OutFile.write('>%s %s orig_bc=%s new_bc=%s bc_diffs=0\n' %(SampleID, SequenceID, Barcode, Barcode))
            OutFile.write(Sequence)

with open('temp_read_dictionary.txt', 'w') as DICTfile:
    DICTfile.write(str(counter))
