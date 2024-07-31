# SAMURAI_paper_scripts

This repository includes all the scripts used for the paper "[SAMURAI](https://github.com/DIncalciLab/samurai): Shallow Analysis of copy nuMber Using a Reproducible And Integrated bioinformatics pipeline". 

## Case Study 1 - Evaluation of SAMURAI on simulated data: Download and dilution of Test data from [Smolander et al.](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-021-07686-z)

### Step 1: Download Simulated Sample
The original simulated sample files (```simulated_L001_R1_001.fastq.gz```, ```simulated_L001_R2_001.fastq.gz```) can be downloaded from [Zenodo](https://zenodo.org/records/4727293#.YIq0FGhRW-y)
### Step 2: Align FASTQ Files
Align the downloaded FASTQ files to ```hg38``` using ```BWA-MEM```. You can use the following Singularity [container](https://depot.galaxyproject.org/singularity/mulled-v2-fe8faa35dbf6dc65a0f7f5d4ea12e31a79f73e40:a34558545ae1413d94bde4578787ebef08027945-0) for BWA-MEM.
### Step 3: Downsample BAM Files
Downsampling is performed using ```Picard DownsampleSam```m. You can install Picard locally or use a Singularity [container](https://depot.galaxyproject.org/singularity/picard:3.1.1--hdfd78af_0):
### Step 4: Produce Diluted Samples
To produce diluted samples, use the following command, changing the parameter  ```P``` to simulate different coverages (e.g., 0.1, 0.3, 0.5, 0.7):
```
java -jar picard.jar DownsampleSam \
            I=input.bam \
            O=downsampled.bam \
            P=0.5
```



## Case Study 1 - Evaluation of SAMURAI on simulated data: Dilution of normal samples to build the Panel of normals (PoN) for liquid biopsy test


The script ```download_normal_gatk.sh``` can be used to download [GATK data](https://42basepairs.com/download/s3/gatk-test-data/cnv/somatic/SM-74NEG.bam) to build a simulated panel of normal. 
Data need to be downsampled at different coverages. 

The script contains the automatic download of three ```singularity``` images for ```sambamba```, ```samtools``` and ```bedtools``` that are needed for the in-silico dilution.  

The function ```Subsample``` takes as input:
 1. ```input_bam```: Original downloaded ```BAM``` normal file (```SM-74NEG.bam```)
 2. ```desired_read_count```: Desired read count for subsampling
 3. ```output_bam```: Final diluted ```BAM``` normal file

Within the script, you can adjust the following parameters:
- ```CORES ```: Number of cores to use
- ```READ_COUNT```: Number of reads for subsampling
- ```NUM_SAMPLES ```: Number of samples to generate
  
The script then converts diluted samples from ```BAM``` to ```fastq``` format. 

You can use the script by launching ```bash download_normal_gatk.sh``` after ajusting the parameters as you like. Alternatively, you can download data and singularity images on your own and use the different part of the script separately. 

