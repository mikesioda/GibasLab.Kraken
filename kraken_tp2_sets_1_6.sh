#!/bin/bash
#PBS -N kraken_tp2_1to6
#PBS -l nodes=1:ppn=12
#PBS -l vmem=95GB
#PBS -l walltime=48:00:00
start=$(date +%s)
FILES=/group/gibaslab/working_files/trimmed_reads/time_point_2/metagenome/*
OUT=/group/gibaslab/working_files/kraken_reports/tp2
KDB=/group/gibaslab/krakenDB
SUF=Set2
TEST_SETS=( {1..6} )
echo
echo SCRIPT EXECUTING KRAKEN ON TEST SETS: ${TEST_SETS[@]}

for i in ${TEST_SETS[@]}
do
	testSet=$i$SUF
	fileR1=null
	fileR2=null
	for f in $FILES 
	do
		if [[ $f == *-paired* && $f == *_$testSet* ]]; then
			if [[ $f == *R1* ]]; then
				echo $i R1 is $f
				fileR1=$f
			elif [[ $f == *R2* ]]; then
				echo $i R2 is $f
				fileR2=$f
			else
				echo ERROR - $f IS NOT A PAIRED FILE - MISSING R1/R2
			fi
		fi
	done
	if [[ $fileR1 != null && $fileR2 != null && SUF == NEVER ]]; then
		kraken --gzip-compressed --fastq-input --DB $KDB --paired $fileR1 $fileR2 > $OUT/$testSet.txt
		kraken-report --DB $KDB $OUT/$testSet > $OUT/$testSet.report.txt
	fi
done
echo KRAKEN REPORTS AVAILABLE FOR TEST SETS: ${TEST_SETS[@]}
end=$(date +%s)
runtime="$(($end - $start))"
echo SCRIPT COMPLETE: RUNTIME is $runtime seconds