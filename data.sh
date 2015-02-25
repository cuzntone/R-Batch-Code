# R-Batch-Code
#!/bin/sh
#PBS -q planck
source /share/apps/Modules/3.2.10/init/sh
module load R/3.1.0
R --vanilla < /home/tongx/hello_world/data.r >  /home/tongx/hello_world/output/sample_$PBS_ARRAYID.txt

