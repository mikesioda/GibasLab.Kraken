#!/bin/bash
#PBS -N kraken_build_db
#PBS -l nodes=1:ppn=12
#PBS -l vmem=95GB
#PBS -l walltime=12:00:00
# BUILD STANDARD KRAKEN DATABASE
start=$(date +%s)
echo SCRIPT BUILDING KRAKEN DB 
KDB=/group/gibaslab/krakenDB
mkdir $KDB
kraken-build --db $KDB --download-library plasmids
kraken-build --db $KDB --download-library human
kraken-build --standard --threads 12 --db $KDB
chmod -R 775 $KDB
echo KRAKEN DB BUILD IS COMPLETE
end=$(date +%s)
runtime=$"($end - $start)"
echo SCRIPT COMPLETE: RUNTIME is $runtime seconds
