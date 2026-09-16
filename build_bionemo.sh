#!/bin/bash -e

#group/project I want to make data and the container accessible to
GROUP=uoa04517

#Set up cache folders
unset APPTAINER_BIND
APPTAINER_CACHEDIR=$(mktemp -d)
APPTAINER_TMPDIR=${APPTAINER_CACHEDIR}

#Build container and make readable to everyone 
apptainer build --force bionemo.sif bionemo.def
chmod 640 bionemo.sif

#Should also be available via
# apptainer pull bionemo.sif oras://ghcr.io/acsrc-shoc2/bionemo/bionemo:latest

module load JupyterLab/2026.7.0-foss-2026-4.6.0

rm -rf /nesi/project/uoa04517/.jupyter/share/jupyter/kernels/bionemo
nesi-add-kernel bionemo -cp bionemo.sif --container-args="--nv" --shared -a $GROUP
