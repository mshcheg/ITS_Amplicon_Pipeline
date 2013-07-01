ITS_Amplicon_Pipeline
=====================
Pipeline for Zanne lab ITS amplicon analysis.

1. Install PandaSeq
        
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

2. Install Qiime. More notes on installing Qiime can be found [here] (http://qiime.org/install/install.html#rdp-install).

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
        
3. Align paired end reads in [PandaSeq] (https://github.com/neufeld/pandaseq).

        pandaseq -f R1_file.fastq -r R2_file.fast2 -u unpaired.fasta > paired.fasta
        
4. PandaSeq inserts a “-” between high-quality paired end reads that do not overlap. These sequences are placed in the unpaired.fastq file. For down stream analyses the “-” needs to be replaced with an “N”.
        
        #replace '-' only on lines that do not contain '>HWI-'
        sed '/>HWI\-/!s/\-/N/' unpaired.fasta > unpaired_N.fasta

5. Combine aligned and unaligned paired end reads into one file.

        cat unpaired_N.fasta paired.fasta > both.fasta 

6. Extraxt ITS reads using HMMs through [ITSx] (http://microbiology.se/software/itsx/)
  
        ITSx -i both.fasta -o ITSx_out -t F -cpu 15 -p /etc/system_scripts/ITSx_1.0b/ITSx_db/HMMs/

7. Format ITS fasta file for use with Qiime pipeline. The targets file maps sequences to barcodes and is provided by the sequenceing center.
        
        python format_for_qiime.py ITSx_out.full.fasta targets.txt

8. Download and uncompress UNITE reference OTUs. 
        
        wget https://github.com/downloads/qiime/its-reference-otus/its_12_11_otus.tar.gz   
        tar -xzf its_12_11_otus.tar.gz   
        gunzip ./its_12_11_otus/rep_set/97_otus.fasta.gz   
        gunzip ./its_12_11_otus/taxonomy/97_otu_taxonomy.txt.gz

9. Create a parameters file called params.txt.
    
        echo -e "assign_taxonomy:rdp_max_memory 8000\npick_otus:enable_rev_strand_match True\npick_otus:max_accepts 1\npick_otus:max_rejects 8\npick_otus:stepwords 8\npick_otus:word_length 8\nassign_taxonomy:id_to_taxonomy_fp its_12_11_otus/taxonomy/97_otu_taxonomy.txt\nassign_taxonomy:reference_seqs_fp its_12_11_otus/rep_set/97_otus.fasta\nbeta_diversity:metrics bray_curtis" > params.txt

10. Create a mapping file with metadata for each sample called map.txt. This file can be created maually according the the [specifications] (http://qiime.org/documentation/file_formats.html) on the Qiime website. Or automatically using the following script.

        
