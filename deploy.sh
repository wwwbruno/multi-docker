docker build -t wwwbruno/multi-client:latest -t wwwbruno/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t wwwbruno/multi-server:latest -t wwwbruno/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t wwwbruno/multi-worker:latest -t wwwbruno/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push wwwbruno/multi-client:latest
docker push wwwbruno/multi-server:latest
docker push wwwbruno/multi-worker:latest

docker push wwwbruno/multi-client:$GIT_SHA
docker push wwwbruno/multi-server:$GIT_SHA
docker push wwwbruno/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=wwwbruno/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=wwwbruno/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment server=wwwbruno/multi-worker:$GIT_SHA
