#!/bin/ksh
echo "calculating..."
name="project_batch"
echo "which excited state ESTM you would like to calculate?
   example 1,2,3,4....."
read stateA
stateB=$((stateA+1))
rm -f temp*
rm -f osca
rm -f oscb
rm -f Exc_energy
rm -f Energy

for i in {1..38}; do
   grep "Excited State   $stateA:" ${name}_$i.log >> osca
   grep "Excited State   $stateB:" ${name}_$i.log >> oscb
done
lines=`wc -l osca | awk '{ print $1 }'`

for i in $(eval echo "{1..$lines}") 
   do 
   osa=`head -n $i osca | tail -n1 | awk '{ print $9 }'`
   osca=`echo ${osa:2:6}`
   echo "$osca" >> ost_8
   enera=`head -n $i osca | tail -n1 | awk '{ print $5 }'`
   osb=`head -n $i oscb | tail -n1 | awk '{ print $9 }'`
   oscb=`echo ${osb:2:6}`
   echo "$oscb" >> ost_9
   enerb=`head -n $i oscb | tail -n1 | awk '{ print $5 }'`
   a=$(( enera * osca + enerb * oscb ))
   echo "$a"
   b=$(( osca + oscb ))
   echo "$b"
   echo $(( a / b )) >> Exc_energy
   comp=`echo $osca'>'$oscb | bc -l`

done 

echo ""
echo ""
echo ""
echo "run 5.estm.sh"
echo ""
echo ""
echo ""


