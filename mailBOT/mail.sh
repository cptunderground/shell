#!/bin/bash

#parse

INSULT=()
insult="$(cat insult.json)"
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


for ((i=1; i<=30; i++))
do
rand=$[$RANDOM % ${#INSULT[@]}]
echo $i
   if [ ${INSULT[$rand]} != "null" ]
   then echo ${INSULT[$rand]}
      {
         echo Subject: ${INSULT[$rand]}
         echo "This is an automatic generated email with a random insult in the subject - sincerely your beloved MasterScripter"
      } | ssmtp some@mail.com
   sleep 2
   else echo "was null"
   fi
done

echo "Job done"