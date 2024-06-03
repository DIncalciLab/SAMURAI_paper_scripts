#!/bin/bash

# Define Singularity image names on Quay.io (adjust names if needed)
singularity_images=(
  "quay.io/biocontainers/sambamba:0.8.2--h98b6b92_2"
  "quay.io/biocontainers/samtools:1.17--h00cdaf9_0"
  "quay.io/biocontainers/bedtools:2.31.1--hf5e1c6e_1"
)

# Local image names with potential suffixes (adjust if needed)
singularity_local_images=()
for image in "${singularity_images[@]}"; do
  # Extract the image name without path or version information
  image_name=$(basename "$image" | cut -d ':' -f2)
  # Consider potential suffixes based on your Singularity installation
  singularity_local_images+=("$image_name.sif" "$image_name")  # Adjust suffix order if needed
done

for image in "${singularity_local_images[@]}"; do
  if ! singularity list "$image"; then
    echo "Pulling Singularity image: $image"
    # Use correct format for pulling (original image name from Quay.io)
    # Loop through each image name in singularity_images and pull them individually
    for image_name in "${singularity_images[@]}"; do
      singularity pull docker://"$image_name"
    done
  else
    echo "Singularity image: $image already exists. Skipping pull."
  fi
done

# Note: Adjust eventual paths or if you want to pre-download them or use installed softwares
sambamba="singularity exec sambamba_0.8.2--h98b6b92_2.sif sambamba"
samtools="singularity exec samtools_1.17--h00cdaf9_0.sif samtools"
bedtools="singularity exec bedtools_2.31.1--hf5e1c6e_1.sif bedtools"

function SubSample {
    local input_bam="$1"
    local desired_read_count="$2"
    local output_bam="$3"

    ## Calculate the sampling factor based on the intended number of reads:
    local FACTOR=$($samtools idxstats "$input_bam" | cut -f3 | awk -v COUNT="$desired_read_count" 'BEGIN {total=0} {total += $1} END {print COUNT/total}')

    if (( $(bc <<< "$FACTOR > 1") )); then
        echo '[ERROR]: Requested number of reads exceeds total read count in' "$input_bam" '--exiting' && exit 1
    fi

    $sambamba view -f "not duplicated" -o "$output_bam" -t "$CORES" -p -s "$FACTOR" -f bam -l 5 "$input_bam" $chromosomes
}

ORIGINAL_SAMPLE=SM-74NEG.bam
SAMPLE_INDEX=SM-74NEG.bam.bai

# Download the sample (adjust path if needed)
if [ ! -f "$ORIGINAL_SAMPLE" ]; then
  wget https://42basepairs.com/download/s3/gatk-test-data/cnv/somatic/SM-74NEG.bam
 else
  echo "File '$ORIGINAL_SAMPLE' already exists. Skipping download."
fi

# Download the sample (adjust path if needed)
if [ ! -f "$SAMPLE_INDEX" ]; then
  wget https://42basepairs.com/download/s3/gatk-test-data/cnv/somatic/SM-74NEG.bam.bai
 else
  echo "File '$SAMPLE_INDEX' already exists. Skipping download."
fi

# Set number of cores (adjust as needed)
CORES=4

# Define desired read count for subsampling
READ_COUNT=10000000

# Specify the number of random samples (N)
NUM_SAMPLES=5  # Adjust this value according to your needs

# Loop to generate N random samples
for i in $(seq 1 $NUM_SAMPLES); do
  
  # Define output filenames with unique identifiers
  OUTPUT_FILE="subsampled_${READ_COUNT}_${i}_SM-74NEG.bam"
  OUTPUT_FQ="subsampled_${READ_COUNT}_${i}_SM-74NEG.fq"

  # Apply subsampling function with random seed (optional)
  SubSample $ORIGINAL_SAMPLE $READ_COUNT $OUTPUT_FILE
  

  # Convert to fastq and compress
  $bedtools bamtofastq -i $OUTPUT_FILE -fq $OUTPUT_FQ | gzip > "$OUTPUT_FQ.gz"

  echo "Subsampling completed for sample $i! Output file: $OUTPUT_FQ.gz"
done

echo "All $NUM_SAMPLES random subsamples generated!"
