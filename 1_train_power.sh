#!/bin/bash

maxjob=6 

data="power_demand" 
declare -a filenames=("power_data.pkl" )

for filename in "${filenames[@]}"
do
    while [[ $(jobs -p | wc -l) -ge $maxjob ]]
    do
        wait
    done

    CUDA_VISIBLE_DEVICES=0 python3 1_train.py --data $data --filename $filename&
    CUDA_VISIBLE_DEVICES=0 python3 1_train.py --data $data --filename $filename --gated&
    CUDA_VISIBLE_DEVICES=0 python3 1_train.py --data $data --filename $filename --gated --feedback&
    CUDA_VISIBLE_DEVICES=0 python3 1_train.py --data $data --filename $filename --hidden_tied&
    CUDA_VISIBLE_DEVICES=0 python3 1_train.py --data $data --filename $filename --feedback --gated --hidden_tied&

done

