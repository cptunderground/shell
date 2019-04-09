#!/bin/bash

ARRAY=(IT 
Matijewix 
Gayan 
"Dini Muetter" 
Spasst 
Mongo 
Schwuchtel 
Muschel)

insult="$(cat matijevic.json)"
echo "${insult}" | jq '.'
insult="$(cat matijevic.json)"
for row in $(echo "${insult}" | jq -r '.[] | @base64'); do
    _jq() {
     echo ${row} | base64 --decode | jq -r ${1}
    }

   echo $(_jq '.name')
done

for ((i=1; i<=10; i++))
do
rand=$[$RANDOM % ${#ARRAY[@]}]
echo ${ARRAY[$rand]}
echo $i
##{
##    echo Subject: ${ARRAY[$rand]}
##    echo "This is an automatic generated email with a random insult in the subject - please enjoy"
##} | ssmtp dejan.matijevic@unibas.ch
##sleep 30
done
#echo "hello World" | ssmtp -s "test" dejan.matijevic@unibas.ch