#!/bin/bash

#parse

INSULT=()
insult="$(cat matijevic.json)"
echo "Found a total of: "$(echo "${insult}" | jq -r '. | length') "Elements"
echo "${insult}" | jq -c '.[]'
counter=0
for row in $(echo "${insult}" | jq -r '.[] | @base64'); do
    _jq() {
     echo ${row} | base64 --decode | jq -r ${1}
    }

   echo "reading: "$(_jq '.') "into ARRAY[$counter] as: $(_jq '.name') "
   INSULT+=(\"$(_jq '.name')\")
   counter=$(($counter+1))
done
echo "${INSULT[0]}"
echo "${INSULT[1]}"
echo "${INSULT[2]}"
echo "${INSULT[3]}"
echo "${INSULT[4]}"
echo "${INSULT[5]}"
echo "${INSULT[6]}"

for ((i=1; i<=10; i++))
do
rand=$[$RANDOM % ${#INSULT[@]}]
echo $i
   if [ ${INSULT[$rand]} != "null" ]
   then echo ${INSULT[$rand]}
   #   {
   #      echo Subject: ${INSULT[$rand]}
   #      echo "This is an automatic generated email with a random insult in the subject - please enjoy"
   #   } | ssmtp some@mail.com
   #sleep 5
   else echo "was null"
   fi
done

echo "${INSULT[1]}"