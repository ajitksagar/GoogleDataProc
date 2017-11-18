#Author: Ajit Kshirsagar
#Cluster Deletion

echo "Enter cluster name to delete:"
read CLUSTER_NAME

echo "Enter region of the cluster:"
read REGION

echo "Deleting Cluster wait for sometime  ..... !!!"
echo y | gcloud dataproc clusters delete ${CLUSTER_NAME} --region ${REGION}

if [ $? -eq 0 ];
then
echo "Cluster Deletion Completed !!!"
fi
