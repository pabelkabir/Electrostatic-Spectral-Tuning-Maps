for i in {1..40}; do
   cp gaussian.sh gaussian_$i.sh
   sed -i -e "s/Nombre/project_batch_$i/g" gaussian_$i.sh
   sbatch gaussian_$i.sh 
done

echo ""
echo ""
echo ""
echo "once the jobs are finished, run oscilator_may.sh"
echo ""
echo ""
echo ""
