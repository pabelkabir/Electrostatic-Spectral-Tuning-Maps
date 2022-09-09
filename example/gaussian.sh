#!/bin/bash
#SBATCH -J Nombre
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 240:00:00
#SBATCH --mem=45000MB 
#SBATCH -p qPHO
#SBATCH --exclude photongpu01,photongpu02
#--------------------------------------------------------------#
#NPROCS=`wc -l < $SLURM_JOB_NODELIST`
cd $SLURM_SUBMIT_DIR
#--------------------------------------------------------------#
#  Change the Project!!!
#--------------------------------------------------------------#
export Project=$SLURM_JOB_NAME
#export WorkDir=/home/users/yorozcogonzalez/RS10237/Scratch/$SLURM_JOB_ID
export WorkDir=/runjobs/RS10237/$SLURM_JOB_ID
mkdir -p $WorkDir
mkdir -p $WorkDir/scr
export InpDir=$SLURM_SUBMIT_DIR
echo $SLURM_JOB_NODELIST > $InpDir/nodename_$Project
echo $SLURM_JOB_ID > $InpDir/jobid
#--------------------------------------------------------------#
# Copy of the files - obsolete
#--------------------------------------------------------------#
#cp $InpDir/$Project.xyz $WorkDir/$Project.xyz
#cp $InpDir/$Project.key $WorkDir/$Project.key
#cp $InpDir/*.prm $WorkDir/
#--------------------------------------------------------------#
# Start job
#--------------------------------------------------------------#
g03root=/home/users/mkabir2/bin
GAUSS_SCRDIR=$WorkDir/scr
#GAUSS_SCRDIR=$HOME/scr
export g03root GAUSS_SCRDIR
source $g03root/g03/bsd/g03.profile

cp ${Project}.com $WorkDir
cd $WorkDir
g03 ${Project}.com
cp $WorkDir/* $InpDir
rm -r $WorkDir

