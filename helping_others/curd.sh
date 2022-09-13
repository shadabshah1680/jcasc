#!/bin/env  sh
# nurse=( "lubna" "ruksana" )
# updatedNurse=( "lubna" "alia" )
# declare -a replacedName=()
# echo "Enter Value to update"
# read name
# for upd in ${nurse[@]}  ${updatedNurse[@]}; do
#         echo ${upd[1]}
#         replacedName+=("${upd}")
#         if [[ $[nurse[upd]] == $[updatedNurse[upd]] ]]; then
#             replacedName+=("${name}")
#         elif [[ $upd == $updatedNurse ]]; then
#             replacedName+=("${upd}")
#         fi
# done
# echo "${replacedName}" #Testing Purpose

nurse=("lubna" "ruksana")
updateNurse=("lubna" "khala")

echo "Enter Value to update"
read name
updateVal=()
for upd in "${updateNurse[@]}" "${!nurse[@]}"; do
        if test "${updateNurse[upd]}" = "${nurse[upd]}"; then
         updateVal+=" \"${name}\" "
         else
         updateVal+="\"${updateNurse[upd]}\" "
        fi
done
a="(${updateVal[@]})"
b=`echo "${a[@]}" | sort | uniq`
echo "Nuress: ${b[@]}" #Testing Purpose


