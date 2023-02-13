# Usage: submit a series of SynthSeg+ jobs (global regions only)
# bash [filename] [BIDS rawdata directory]

DATADIR=$1

BASE=/mnt/isilon/bgdlab_resnas03/code/synthseg

# for subject in directory
for subj in $DATADIR/sub-* ; do
    # for session in directory
    for session in $subj/ses-* ; do

        # Check that an MPR exists in the session 
        for fn in $session/anat/* ; do 
            if [[ $fn == *"T1w.nii.gz"* ]] ; then      # Cool an MPR exists
           
	         echo $fn
                 # Set up the output directory
                 OUTDIR="${fn/rawdata/derivatives/synthseg+}"
                 OUTDIR="${OUTDIR/anat/}"
                 OUTDIR=${OUTDIR%%.nii.gz}
                 echo $OUTDIR
       
                 # If the ouput directory doesn't exist, then make it
                 if [ ! -d $OUTDIR ] ; then
                     mkdir -p $OUTDIR
                 fi

                 # Submit the FS job
                 sbatch $BASE/jobSynthSeg.sh $OUTDIR $fn 
            fi
        done # end for fn in session/anat/*.nii.gz
    done # end for session in subject
done # end for subject
