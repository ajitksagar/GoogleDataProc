#!/bin/bash
#Author: Ajit Kshirsagar

echo "Enter cluster name:"
read CLUSTER_NAME

echo "Enter region of the cluster:"
read REGION

echo "Enter Zone:"
read ZONE

echo "Enter Number of workers:"
read WORKER_COUNT


BDP_INSTALLER_PATH='gs://shubhambdp/build/bdp_bootstrap_installer.sh'

echo "Cluster Creation Started ....... !!!"

#Cluster Creation

gcloud dataproc --region ${REGION} clusters create ${CLUSTER_NAME} --subnet default --zone ${ZONE} --master-machine-type n1-standard-2 --master-boot-disk-size 500 --num-workers ${WORKER_COUNT} --worker-machine-type n1-standard-2 --worker-boot-disk-size 500 --project warm-scout-184122 --initialization-actions ${BDP_INSTALLER_PATH}

echo "Cluster Creation Task Completed .... !!!"
