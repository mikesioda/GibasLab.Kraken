#!/bin/bash
start=$(date +%s)
set -o nounset
set -o errexit
module load jellyfish
module load kraken
echo SCRIPT BUILDING KRAKEN DB 
KDB=/group/gibaslab/krakenDB
kraken-build --db $KDB --download-taxonomy
kraken-build --db $KDB --download-library bacteria
kraken-build --db $KDB --download-library viruses
kraken-build --db $KDB --download-library plasmids
kraken-build --db $KDB --build --threads 16 \
               --jellyfish-hash-size "" \
               --max-db-size "" \
               --minimizer-len 15 \
               --kmer-len 31 
kraken-build --db $KDB --clean
chmod -R 775 $KDB
echo KRAKEN DB BUILD IS COMPLETE
end=$(date +%s)
runtime="$(($end - $start))"
echo SCRIPT COMPLETE: RUNTIME is $runtime seconds


















































































