#!/bin/bash
hosts="13.235.134.115 13.233.231.99 13.233.129.88"
script="df -h | awk '{print $5}' | tail -2 | head -1 | cut -c1-2; exit"
scripts="df -h| awk '{print $5}'"
for i in ${hosts}
do
echo "running for host: " ${i};
ssh -i devops.pem ec2-user@${i} "${scripts}" >>${i}.txt;
awk '{print $5}' ${i}.txt | tail -2 | head -1 | cut -c1-2 >${i}-final.txt
if [ $(cat ${i}-final.txt) -le 18 ]
then
        echo "Memory is less that 18%";
else
        echo "Memory is more than 18%";
		
fi
done
