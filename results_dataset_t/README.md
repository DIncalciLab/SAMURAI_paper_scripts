## Case Study 2 (Data set T)

This directory contains parameters and analysis steps to reproduce the result from the paper.

### Prerequisites

Due to the nature of the data, the BAM files from Pesenti, Beltrame *et al.* 2021 are under controlled access at the [EGA](https://ega-archive.org/studies/EGAS00001004961), so to download them you need to request access. Notice that you only need the shallow whole-genome data, not the mutation data. 

### Analysis steps

1. Modify `samplesheet.csv` to point to the files that you have downloaded for EGA.
2. Run the pipeline with (you can substitute `docker` with `singularity` or `apptainer`)

```
nextflow run DIncalciLab/samurai -profile docker -params parameters.yaml --samplesheet samplesheet.csv --genome hg38 --outdir /your/path/of/choice
```

As a reference, some result files are provided to allow comparing local runs with the expected results.
