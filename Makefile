CLUSTER_NAME=test-k8s
NAMESPACE=test-k8s
IMAGE=laravel-k8s-app:local

.PHONY: cluster-delete cluster-create build image-import deploy up down status

cluster-delete:
	-k3d cluster delete $(CLUSTER_NAME)

cluster-create:
	k3d cluster create $(CLUSTER_NAME) -p "30007:30007@loadbalancer"

build:
	docker build -t $(IMAGE) .

image-import:
	k3d image import $(IMAGE) -c $(CLUSTER_NAME)

deploy:
	kubectl apply -f k8s/namespace.yaml
	kubectl apply -f k8s/configmap.yaml
	kubectl apply -f k8s/secret.yaml
	kubectl apply -f k8s/mysql-service.yaml
	kubectl apply -f k8s/mysql-statefulset.yaml
	kubectl apply -f k8s/app-deployment.yaml
	kubectl apply -f k8s/app-service.yaml

wait:
	kubectl rollout status statefulset/mysql -n $(NAMESPACE)
	kubectl rollout status deployment/app -n $(NAMESPACE)

status:
	kubectl get all -n $(NAMESPACE)
	kubectl get pvc -n $(NAMESPACE)

up: cluster-delete cluster-create build image-import deploy wait
	@echo "Check resources with: make status"

down:
	k3d cluster delete $(CLUSTER_NAME)