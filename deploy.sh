docker build -t qhieu45/multi-docker-client:latest -t qhieu45/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t qhieu45/multi-docker-api:latest -t qhieu45/multi-docker-api:$SHA -f ./api/Dockerfile ./api
docker build -t qhieu45/multi-docker-worker:latest -t qhieu45/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker
docker push qhieu45/multi-docker-client:latest
docker push qhieu45/multi-docker-api:latest
docker push qhieu45/multi-docker-worker:latest

docker push qhieu45/multi-docker-client:$SHA
docker push qhieu45/multi-docker-api:$SHA
docker push qhieu45/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/api-deployment api=qhieu45/multi-docker-api:$SHA
kubectl set image deployments/client-deployment client=qhieu45/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=qhieu45/multi-docker-worker:$SHA