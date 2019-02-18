docker build -t mlgthemoja/finapp-client:latest -t mlgthemoja/finapp-client:$SHA -f ./client/Dockerfile ./client
docker build -t mlgthemoja/finapp-server:latest -t mlgthemoja/finapp-server:$SHA -f ./server/Dockerfile ./server
docker build -t mlgthemoja/finapp-worker:latest -t mlgthemoja/finapp-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mlgthemoja/finapp-client:latest
docker push mlgthemoja/finapp-server:latest
docker push mlgthemoja/finapp-worker:latest
docker push mlgthemoja/finapp-client:latest:$SHA
docker push mlgthemoja/finapp-server:latest:$SHA
docker push mlgthemoja/finapp-worker:latest:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mlgthemoja/finapp-server:$SHA
kubectl set image deployments/client-deployment client=mlgthemoja/finapp-client:$SHA
kubectl set image deployments/worker-deployment worker=mlgthemoja/finapp-worker:$SHA