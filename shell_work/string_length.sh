#!/usr/bin/bash
a=`sed 's/&q;/n/g' index.html`
echo -e $a > n
for i in `cat n`; do  j="${i}@#$"; len=`expr length "$j"`; if [ $len  -gt 25 ]; then echo $i; fi; done;
