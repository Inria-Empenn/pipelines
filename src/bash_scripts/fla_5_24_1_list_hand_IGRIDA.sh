sub=($@)

DIR=$( dirname ${BASH_SOURCE})

for ((i=0; i<${#sub[@]};i++))
do
    oarsub -l /nodes=1/core=4,walltime=0:30:0 "$DIR/fla_5_24_1_list_hand.sh ${sub[i]}"
done
