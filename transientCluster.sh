#Author: Ajit Kshirsagar
#!/bin/bash

CLUSTER_NAME=<CLUSTER_NAME>
REGION=us-east1
ZONE=us-east1-b
WORKER_COUNT=2
BDP_INSTALLER_PATH='<BUCKET_PATH>' #If you are using any bootstrap scripts

echo "Cluster Creation Started ....... !!!"

#Cluster Creation

gcloud dataproc --region ${REGION} clusters create ${CLUSTER_NAME} --subnet default --zone ${ZONE} --master-machine-type n1-standard-2 --master-boot-disk-size 500 --num-workers ${WORKER_COUNT} --worker-machine-type n1-standard-2 --worker-boot-disk-size 500 --project warm-scout-184122 --initialization-actions ${BDP_INSTALLER_PATH}

echo "Waiting After Inital cluster Set Up ..... !!!"
sleep 2m

#Spark Job Parameters
CLASS_NAME=<CLASS_NAME>
JAR_PATH=<JAR_NAME>
INPUT_FILE_PATH=<INPUT_FILE_PATH>
OUTPUT_FILE_PATH=<OUTPUT_FILE_PATH>


gcloud dataproc jobs submit spark --cluster ${CLUSTER_NAME} --region ${REGION} --class ${CLASS_NAME} --jars ${JAR_PATH} -- ${INPUT_FILE_PATH} ${OUTPUT_FILE_PATH}

echo "Waiting to write output results ....!!!"
sleep 2m

#Cluster Deletion

echo "Deleting Cluster after Job completion ..... !!!"
gcloud dataproc clusters delete ${CLUSTER_NAME} --region ${REGION}

echo "Check your results at ... ${OUTPUT_FILE_PATH}"
