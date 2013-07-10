#Download and uncompress pandaseq
wget https://github.com/neufeld/pandaseq/archive/master.zip
unzip master.zip
#Install necessary packages for running pandaseq
sudo apt-get install build-essentials libtool automake zlib1g-dev
#Cange into the pandaseq directory and install pandaseq
cd pandaseq-master         
./autogen.sh && ./configure && make && sudo make install
#If you receive an error that libpandaseq.so.[number] is not found on Linux run:
sudo ldconfig     

#Install Qiime
sudo apt-get install Qiime
#Install UCLUST
wget http://www.drive5.com/uclust/uclustq1.2.22_i86linux64
sudo ln -s /path/to/uclustq1.2.22_i86linux64 /usr/local/bin/uclust
#Install RDP
wget -O rdp_classifier_2.2.zip "http://sourceforge.net/projects/rdp-classifier/files/rdp-classifier/rdp_classifier_2.2.zip/download"
unzip rdp_classifier_2.2.zip
echo "export RDP_JAR_PATH=/path/to/rdp_classifier-2.2.jar" >> $HOME/.bashrc
source $HOME/.bashrc
#Download and uncompress the biom-format library.
wget ftp://thebeast.colorado.edu/pub/biom-format-releases/biom-format-1.1.2.tar.gz
tar -xvzf biom-format-1.1.2.tar.gz
#Create a file pointing python to the location of the biom library
mkdir -p ~/.local/lib/python2.7/site-packages/
echo "/path/to/biom-format-1.1.2/python-code/" > ~/.local/lib/python2.7/site-packages/biom.pth

#Download and uncompress UNITE reference OTUs. 
wget https://github.com/downloads/qiime/its-reference-otus/its_12_11_otus. tar.gz
tar -xzf its_12_11_otus.tar.gz
gunzip ./its_12_11_otus/rep_set/97_otus.fasta.gz
gunzip ./its_12_11_otus/taxonomy/97_otu_taxonomy.txt.gz

#Make python scripts globally available

#Install R packages

#Install ITSx
