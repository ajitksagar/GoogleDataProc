#Author: Ajit Kshirsagar
#!/bin/bash
CLUSTER_NAME=bdptest
INCREASE_NODE=1
MASTER_NODE=<MASTER_NODE_IP>
UPDATE_NODE=2 #Initial Number of Worker nodes 
REGION=us-east1
MAX_NODES=4 #Maximum nodes till that you want to scale your cluster


while true; 
do

		appsPending=`curl -s "http://${MASTER_NODE}:8088/ws/v1/cluster/metrics" | python -mjson.tool | grep -w "appsPending" | awk -F":" '{print $2}' | sed 's/,//'`
			
			
			#Scale Out
			
			if [ $appsPending -ge 2 -a $UPDATE_NODE -lt $MAX_NODES ];
			then
				UPDATE_NODE=$((UPDATE_NODE + INCREASE_NODE))
				gcloud dataproc clusters update ${CLUSTER_NAME} --num-workers ${UPDATE_NODE} --region ${REGION}

						echo "Worker Node Added !!!"
			fi

			#Scale Down

			activeNodes=`curl -s "http://${MASTER_NODE}:8088/ws/v1/cluster/metrics" | python -mjson.tool | grep -w "activeNodes" | awk -F":" '{print $2}' | sed 's/,//'`

			appsRunning=`curl -s "http://${MASTER_NODE}:8088/ws/v1/cluster/metrics" | python -mjson.tool | grep -w "appsRunning" | awk -F":" '{print $2}' | sed 's/,//'`
																			
			if [ $activeNodes -gt 2 -a $appsRunning -eq 0 ];
			then

			gcloud dataproc clusters update ${CLUSTER_NAME} --num-workers 2 --region ${REGION}

			echo "Updated Worker Nodes to initial stage !!!"
			fi

done
