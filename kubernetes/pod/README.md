# Temel Pod Oluşturma
my-simple-pod.yaml
```bash 
apiVersion: v1
kind: Pod
metadata:
  name: my-simple-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
```
```bash 
kubectl apply -f my-simple-pod.yaml
```
## Pod'un durumunu kontrol edin:
```bash 
kubectl get pods
```
## Pod'a erişim sağlayın:

kubectl exec -it my-simple-pod -- /bin/bash

# Multi-Container Pod
```bash 
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
  - name: redis
    image: redis:latest
    ports:
    - containerPort: 6379

```
```bash 
kubectl apply -f multi-container-pod.yaml
```
# Container'lara erişim sağlayın:

```bash 
kubectl exec -it multi-container-pod -c nginx -- /bin/bash
kubectl exec -it multi-container-pod -c redis -- /bin/bash
```

# Init Container

```bash 
apiVersion: v1
kind: Pod
metadata:
  name: init-container-pod
spec:
  initContainers:
  - name: init-scripts
    image: busybox
    command: ['sh', '-c', 'echo Init Container Completed']
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
```
```bash 
kubectl apply -f init-container-pod.yaml
```
Init container loglarını kontrol edin:
```bash 
kubectl logs init-container-pod -c init-scripts
```
# Sidecar Container
```bash 
apiVersion: v1
kind: Pod
metadata:
  name: sidecar-container-pod
spec:
  containers:
  - name: main-app
    image: nginx:latest
    ports:
    - containerPort: 80
  - name: log-collector
    image: busybox
    command: ['sh', '-c', 'tail -f /var/log/nginx/access.log']
    volumeMounts:
    - name: logs
      mountPath: /var/log/nginx
  volumes:
  - name: logs
    emptyDir: {}
```
```bash 
kubectl apply -f sidecar-container-pod.yaml
```
Sidecar container'ın loglarını kontrol edin:
```bash 
kubectl logs sidecar-container-pod -c log-collector
```
# Tomcat Web Server
```bash 
apiVersion: v1
kind: Pod
metadata:
  name: tomcat-pod
spec:
  containers:
  - name: tomcat
    image: tomcat:latest
    ports:
    - containerPort: 8080
```
```bash 
kubectl apply -f tomcat-pod.yaml
```
Tomcat sunucusuna erişim sağlayın (web tarayıcısında http://<kube-ip>:8080):
```bash 
kubectl port-forward tomcat-pod 8080:8080
```

# Python Flask Uygulaması
```bash 
apiVersion: v1
kind: Pod
metadata:
  name: python-flask-pod
spec:
  containers:
  - name: python-flask
    image: python:3.8
    command: ["sh", "-c", "pip install flask && python -c \"from flask import Flask; app = Flask(__name__); @app.route('/') def hello(): return 'Hello World!'; app.run(host='0.0.0.0', port=5000)\""]
    ports:
    - containerPort: 5000
```
```bash  

kubectl apply -f python-flask-pod.yaml
```
Python Flask uygulamasına erişim sağlayın (web tarayıcısında http://<kube-ip>:5000):

```bash 
kubectl port-forward python-flask-pod 5000:5000
```