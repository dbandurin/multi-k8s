docker build -t bandurin/multi-client:latest -t bandurin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bandurin/multi-server:latest -t bandurin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bandurin/multi-worker:latest -t bandurin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bandurin/multi-client:latest
docker push bandurin/multi-server:latest
docker push bandurin/multi-worker:latest

docker push bandurin/multi-client:$SHA
docker push bandurin/multi-server:$SHA
docker push bandurin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bandurin/multi-server:$SHA
kubectl set image deployments/client-deployment client=bandurin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bandurin/multi-worker:$SHA
