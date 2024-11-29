## Case Study 2 (Data set T)

This directory contains parameters and analysis steps to reproduce the result from the paper.

### Prerequisites

Due to the nature of the data, the BAM files from Paracchini *et al.* 2021 are under controlled access at the [EGA](https://ega-archive.org/studies/EGAS00001004670), so to download them you need to request access. Notice that you do not need the entire data set, but only these samples:

- 21614-PL1
- 21627-PL1
- 21553-PL1
- 21557-PL1
- 21624-PL1
- 21569-PL1
- 21572-PL1
- 21611-PL1
- 21531-PL1
- 21564-PL1
- 21566-PL1
- 21580-PL1

You also need to download the hg38 files required by ichorCNA:

- [hg38 mappability](https://raw.githubusercontent.com/GavinHaLab/ichorCNA/refs/heads/master/inst/extdata/map_hg38_500kb.wig)
- [hg38 GC content](https://raw.githubusercontent.com/GavinHaLab/ichorCNA/refs/heads/master/inst/extdata/map_hg38_500kb.wig)
- [hg38 centromeres](https://raw.githubusercontent.com/GavinHaLab/ichorCNA/refs/heads/master/inst/extdata/GRCh38.GCA_000001405.2_centromere_acen.txt)

### Analysis steps

1. Modify `samplesheet.csv` to point to the files that you have downloaded for EGA.
2. Adjust `parameters.yaml` to point to the various ichorCNA files you have to downloaded
3. Run the pipeline with (you can substitute `docker` with `singularity` or `apptainer`)

```
nextflow run DIncalciLab/samurai -profile docker -params parameters.yaml --samplesheet samplesheet.csv --genome hg38 --outdir /your/path/of/choice
```

As a reference, some result files are provided to allow comparing local runs with the expected results.
