#!/bin/bash
#
#SBATCH --job-name=bgd-synthseg
#SBATCH --time=1-00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G

OUTDIR=$1     # string specifying where the output of recon-all should live when it's done
INFN=$2      # file name

echo $INPUT

BASE=/mnt/isilon/bgdlab_resnas03/code/SynthSeg-lib

# Set up conda
source /home/youngjm/miniconda3/etc/profile.d/conda.sh
conda activate synthseg-env

OUTFN=$OUTDIR/synthseg_segmentations.nii.gz
VOLSCSV=$OUTDIR/volumes.csv
QCCSV=$OUTDIR/qc_scores.csv
POSTFN=$OUTDIR/posterior_probability_maps.nii.gz

time python $BASE/scripts/commands/SynthSeg_predict.py --i $INFN --o $OUTDIR --vol $VOLSCSV --qc $QCCSV --post $POSTFN --robust

# Done!
echo "Job finished running!"
