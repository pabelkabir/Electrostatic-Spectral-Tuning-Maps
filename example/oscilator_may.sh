name="Quinone_neutral_batch"
stateA=1
stateB=2

rm -f osca
rm -f oscb
rm -f Exc_energy

for i in {1..40}; do
   grep "Excited State   $stateA:   Singlet-?Sym" ${name}_$i.log >> osca
   grep "Excited State   $stateB:   Singlet-?Sym" ${name}_$i.log >> oscb
done

lines=`wc -l osca | awk '{ print $1 }'`

for i in $(eval echo "{1..$lines}") 
   do 
   osa=`head -n $i osca | tail -n1 | awk '{ print $9 }'`
   osca=`echo ${osa:2:6}`
   enera=`head -n $i osca | tail -n1 | awk '{ print $5 }'`
   osb=`head -n $i oscb | tail -n1 | awk '{ print $9 }'`
   oscb=`echo ${osb:2:6}`
   enerb=`head -n $i oscb | tail -n1 | awk '{ print $5}'`
   comp=`echo $osca'>'$oscb | bc -l`
#   comp2=`echo $osca'>'0.06 | bc -l`
   if [[ $comp -eq 1 ]]; then
      echo "$enera" >> Exc_energy
      echo $osca
   else
      echo "$enerb" >> Exc_energy
      echo $oscb
   fi
done
echo ""
echo ""
echo ""
echo "run estm.sh"
echo ""
echo ""
echo ""


