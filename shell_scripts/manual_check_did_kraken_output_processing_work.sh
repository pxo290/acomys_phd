#!/bin/bash
locale=$(pwd)
for f in *
do
  if [ -d "$f/Kraken2_output" ]; then
    cd $f/Kraken2_output
    ls -l | grep -q "*Kraken2-confidence_score_0.10_report.txt" && printf "\n" || printf "\n $f\n"
    cd ..
    cd ..
  else
    printf "\n"
  fi
done

#AC11J_run_1630
#AC11N_run_9383
#AC12J_run_21483
#AC14J_run_8004
#AC14N_run_32374
#AC15J_run_17161
#AC15J_run_3287
#AC15N_run_3810
#AC16J_run_24595
#AC16N_run_13196
#AC18J_run_30562
#AC18N_run_25205
#AC19J_run_10101
#srun manual_krak_report_to_phyla_counts.sh AC19J_run_13029
#srun manual_krak_report_to_phyla_counts.sh AC19N_run_210
#srun manual_krak_report_to_phyla_counts.sh AC22J_run_9948
#srun manual_krak_report_to_phyla_counts.sh AC23J_run_19352
#srun manual_krak_report_to_phyla_counts.sh AC23N_run_17295
# srun manual_krak_report_to_phyla_counts.sh AC25J_run_29210
# srun manual_krak_report_to_phyla_counts.sh AC25N_run_17569
#srun manual_krak_report_to_phyla_counts.sh AC28J_run_10402
# srun manual_krak_report_to_phyla_counts.sh AC28N_run_16078
# srun manual_krak_report_to_phyla_counts.sh AC32J_run_17281
# srun manual_krak_report_to_phyla_counts.sh AC32N_run_28790
# srun manual_krak_report_to_phyla_counts.sh AC33J_run_22901
# srun manual_krak_report_to_phyla_counts.sh AC33N_run_15372
# srun manual_krak_report_to_phyla_counts.sh AC35J_run_1894
# srun manual_krak_report_to_phyla_counts.sh AC36J_run_16750
#srun manual_krak_report_to_phyla_counts.sh AC36N_run_19595
srun manual_krak_report_to_phyla_counts.sh AC37J_run_11081
srun manual_krak_report_to_phyla_counts.sh AC37N_run_32170
srun manual_krak_report_to_phyla_counts.sh AC40J_run_27191
srun manual_krak_report_to_phyla_counts.sh AC40N_run_30497
srun manual_krak_report_to_phyla_counts.sh AC44J_run_14475
srun manual_krak_report_to_phyla_counts.sh AC44N_run_4124
srun manual_krak_report_to_phyla_counts.sh AC4J_run_14363
srun manual_krak_report_to_phyla_counts.sh AC5J_run_10988
srun manual_krak_report_to_phyla_counts.sh AC5N_run_31094
srun manual_krak_report_to_phyla_counts.sh AC6J_run_12016
srun manual_krak_report_to_phyla_counts.sh AC6N_run_24349
srun manual_krak_report_to_phyla_counts.sh AC7N_run_20237
srun manual_krak_report_to_phyla_counts.sh AC8J_run_15988
srun manual_krak_report_to_phyla_counts.sh AR10J_run_12600
srun manual_krak_report_to_phyla_counts.sh AR10N_run_1896
srun manual_krak_report_to_phyla_counts.sh AR13J_run_637
srun manual_krak_report_to_phyla_counts.sh AR1J_run_30905
srun manual_krak_report_to_phyla_counts.sh AR1N_run_400
srun manual_krak_report_to_phyla_counts.sh AR20J_run_30590
srun manual_krak_report_to_phyla_counts.sh AR20N_run_27020
srun manual_krak_report_to_phyla_counts.sh AR21J_run_1303
srun manual_krak_report_to_phyla_counts.sh AR21N_run_21923
srun manual_krak_report_to_phyla_counts.sh AR24J_run_2932
srun manual_krak_report_to_phyla_counts.sh AR26J_run_22131
srun manual_krak_report_to_phyla_counts.sh AR26N_run_29068
srun manual_krak_report_to_phyla_counts.sh AR27J_run_23644
srun manual_krak_report_to_phyla_counts.sh AR27N_run_30273
srun manual_krak_report_to_phyla_counts.sh AR29J_run_24906
srun manual_krak_report_to_phyla_counts.sh AR29N_run_607
srun manual_krak_report_to_phyla_counts.sh AR2J_run_766
srun manual_krak_report_to_phyla_counts.sh AR2N_run_10974
srun manual_krak_report_to_phyla_counts.sh AR30J_run_3964
srun manual_krak_report_to_phyla_counts.sh AR30N_run_2961
srun manual_krak_report_to_phyla_counts.sh AR31J_run_15794
srun manual_krak_report_to_phyla_counts.sh AR34J_run_28226
srun manual_krak_report_to_phyla_counts.sh AR34N_run_17610
