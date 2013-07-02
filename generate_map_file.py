'''

#SampleID       BarcodeSequence LinkerPrimerSequence    Plot    TreeSpCode      Description
#mapping file for plot 3H
#first sequencing test run at the University of Idaho
A6tz                    3H      ACRU    Acer_rubrum
A6bz                    3H      ACRU    Acer_rubrum
B6tz                    3H      AEGL    Aesculus_glabra
B6bz                    3H      AEGL    Aesculus_glabra
C6tz                    3H      AMAR    Amelanchier_arborea
C6bz                    3H      AMAR    Amelanchier_arborea

to use

generate_map_file.py -p list of plots in experiment -d experiment description

example:

    python generate_map_file.py -p 3H 4H 1L -d first sequencing run for plots 3H, 4H and 1L at the University of Idaho
'''

import argparse

Letter = {"A": ("ACRU", "Acer_rubrum"), 
          "B": ("AEGL", "Aesculus_glabra"), 
          "C":("AMAR", "Amelanchier_arborea"), 
          "D":("ASTR", "Asimina_triloba"), 
          "E":("CATO", "Carya_tomentosa"),  
          "F":("CEOC", "Celtis_occidentalis"), 
          "G":("CEOC2", "Celtis_occidentalis"), 
          "H":("COFL", "Cornus_florida"), 
          "I":("DIVI", "Diospyros_virginiana"), 
          "J":("FRAM", "Fraxinus_americana"),  
          "K":("GLTR", "Gleditsia_triacanthos"), 
          "L":("JUNI", "Juglans_nigra"), 
          "M":("JUVI", "Juniperus_virginiana"), 
          "N":("JUVI2", "Juniperus_virginiana"), 
          "O":("LOMA", "Lonicera_maackii"), 
          "P":("PIEC", "Pinus_echinata"), 
          "Q":("PIST", "Pinus_strobus"), 
          "R":("PLOC", "Platanus_occidentalis"), 
          "S":("PRSE/PRVI", "Prunus_serotina"), 
          "T":("QUAL", "Quercus_alba"), 
          "U":("QUVE", "Quercus_velutina"), 
          "V":("QUVE2", "Quercus_velutina"), 
          "W":("ULRU", "Ulmus_rubra"), 
          "X":("VIVU", "Vitis_vulpina")}

Number = {"1H":2,"2H":4,"3H":6,"4H":8,"1L":1,"2L":3,"3L":5,"4L":7}

parser=argparse.ArgumentParser(description='Generate metadata mapping file for Qiime.')
parser.add_argument('-p', type=str, nargs='+')
parser.add_argument('-d', type=str, nargs='+')

args = parser.parse_args()
Plot = args.p
Description = args.d

print 'A mapping file for plots %s will be generated with the following columns: SampleID, BarcodeSequence, LinkerPrimerSequence, Plot, TreeSpCode, Description. The BarcodeSequence and LinkerPrimerSequence columns will be left blank. The Description column will contain tree species names for each sample. The description for this experiment will be: %s.' %(', '.join(Plot), ' '.join(Description))

with open('map.txt', 'w') as outfile:
    outfile.write("#SampleID\tBarcodeSequence\tLinkerPrimerSequence\tPlot\tTreeSpCode\tDescription\n#%s\n" %' '.join(Description))
    for myPlot in Plot:
        for myLetter, myList in Letter.items():
            IDT = '%s%stz' %(myLetter, str(Number[myPlot]))
            IDB = '%s%sbz' %(myLetter, str(Number[myPlot]))
            outfile.write('%s\t\t\t%s\t%s\t%s\n' %(IDT, myPlot, myList[0], myList[1]))
            outfile.write('%s\t\t\t%s\t%s\t%s\n' %(IDB, myPlot, myList[0], myList[1]))
            
    
