#!/bin/ksh
echo "calculating..."
if [ -f temp ]; then
  rm temp
fi
  ref=`tail -1 Exc_energy`
  awk '{print $1 - '$ref'}' Exc_energy > abc
  awk '{ printf  " %9f\n", $1}' abc > temp
  sed -i '$ d' temp
  numpoints=`wc -l temp | awk '{ print $1 }'`
  a=`head -n 1 temp | awk '{ print $1 }'`
for i in $(eval echo "{1..$numpoints}"); do
   b=`head -n $i temp | tail -n1 | awk '{ print $1 }'`
   #echo $b
if [ "$(echo "if (${a} < ${b}) 1" | bc)" -eq 1 ] ; then
   #if $b < $a; then
   a=$b
fi
done
   max=$a
   echo "max=$max" > Infos.data
   a=`head -n 1 temp | awk '{ print $1 }'`
for i in $(eval echo "{1..$numpoints}"); do
   b=`head -n $i temp | tail -n1 | awk '{ print $1 }'`
 #echo $b
if [ "$(echo "if (${a} > ${b}) 1" | bc)" -eq 1 ] ; then
   #if $b < $a; then
   a=$b
fi
done
   min=$a
   echo "min=$min" >> Infos.data
#min=`awk 'BEGIN{a=1000}{if ($1<0+a) a=$1} END{print a}' temp`
#max=`awk 'BEGIN{a=   0}{if ($1>0+a) a=$1} END{print a}' temp`
#echo "max=$max" >> Infos.data
#echo "min=$min" >> Infos.data
echo "reference=$ref" >> Infos.data
#Normalization
#b=`head -n 1 temp | awk '{ print $1 }'`
b=0
c=-1
for i in $(eval echo "{1..$numpoints}"); do
   point=`head -n $i temp | tail -n1 | awk '{ print $1 }'`
if [ "$(echo "if (${point} < ${b}) 1" | bc)" -eq 1 ] ; then
echo $(( point * c / min )) >> temp1
else
echo $(( point / max )) >> temp1
fi
done
awk '{ printf  " %9f\n", $1}' temp1 > normalized_value
rm temp*
echo "@<TRIPOS>MOLECULE
*****
 $numpoints 0 0 0 0
SMALL
GASTEIGER

@<TRIPOS>ATOM" > temp
for i in $(eval echo "{1..$numpoints}"); do
echo "$i   C" | awk '{ printf  " %7s %5s\n", $1, $2}' >> temp1
head -n $i points.txt | tail -n1 | awk '{ printf  " %7s %10s %10s\n", $1, $2, $3}' >> temp3
echo "  C3      1    UNL1" >> temp4
done
paste temp1 temp3 temp4 normalized_value > temp5
cat temp temp5 > sample.mol2
rm temp*

