name="project"
  
charge=" 0.10"
batch=12

j=0
cont=1
numpoints=`wc -l points.txt | awk '{ print $1 }'`
ref_points=$(($numpoints+1))
echo "generating input..."
for i in $(eval echo "{1..$ref_points}"); do
   j=$(($j+1))
   if [[ $i -ne $ref_points ]]; then
      point=`head -n $i points.txt | tail -n1 | awk '{ print $0 }'`    
      echo "$point   $charge" > temp
   if [[ $j -lt $batch ]]; then
      cat ${name}.com temp >> ${name}_batch_${cont}.com
      echo "" >> ${name}_batch_${cont}.com
      echo "--link1--" >> ${name}_batch_${cont}.com
   fi
   if [[ $j -eq $batch ]]; then
      cat ${name}.com temp >> ${name}_batch_${cont}.com
      echo "" >> ${name}_batch_${cont}.com
      j=0
      cont=$(($cont+1))
   fi
   else
   cat ${name}.com >> ${name}_batch_${cont}.com
   fi
   rm temp
done
   echo ""
   echo ""
   echo "run script_gaussian.sh"
   echo ""
   echo ""

