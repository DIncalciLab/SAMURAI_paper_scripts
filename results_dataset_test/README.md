## Test profiles

This directory contains expected results for `test` and `test_ichorcna` profiles.

**Prerequisites:** Make sure you have Nextflow installed and configured. 

**Running the profiles:** 

The commands to execute the profiles are:
```
nextflow run DIncalciLab/samurai -profile test,docker --outdir /your/path/of/choice

nextflow run DIncalciLab/samurai -profile test_ichorna,docker --outdir /your/path/of/choice
```

**Note:**

* Replace `/your/path/of/choice` with your desired output directory.
* You can use either `docker` or `singularity` execution profiles.

For details on running these profiles, please refer to the [**Quick start example**](https://github.com/DIncalciLab/samurai?tab=readme-ov-file#quick-start) in the [SAMURAI Repository](https://github.com/DIncalciLab/samurai).
