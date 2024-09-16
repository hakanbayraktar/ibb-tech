# 1. ClusterIP Servisi
clusterip.yaml
```bash 
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-clusterip-config
data:
  index.html: |
    <!DOCTYPE html>
    <html>
    <head>
        <title>Kubernetes Services Test - ClusterIP</title>
    </head>
    <body>
        <h1>ClusterIP Service</h1>
        <p>This service type is accessible only within the cluster.</p>
    </body>
    </html>
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-clusterip-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-clusterip
  template:
    metadata:
      labels:
        app: nginx-clusterip
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        volumeMounts:
        - name: nginx-clusterip-config
          mountPath: /usr/share/nginx/html
      volumes:
      - name: nginx-clusterip-config
        configMap:
          name: nginx-clusterip-config
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-clusterip
spec:
  selector:
    app: nginx-clusterip
  ports:
    - protocol: TCP
      port: 80
  type: ClusterIP
```
# 2. NodePort Servisi
nodeport.yaml
```bash 
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-nodeport-config
data:
  index.html: |
    <!DOCTYPE html>
    <html>
    <head>
        <title>Kubernetes Services Test - NodePort</title>
    </head>
    <body>
        <h1>NodePort Service</h1>
        <p>This service type is accessible from outside the cluster via Node's IP and NodePort.</p>
    </body>
    </html>
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-nodeport-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-nodeport
  template:
    metadata:
      labels:
        app: nginx-nodeport
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        volumeMounts:
        - name: nginx-nodeport-config
          mountPath: /usr/share/nginx/html
      volumes:
      - name: nginx-nodeport-config
        configMap:
          name: nginx-nodeport-config
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-nodeport
spec:
  selector:
    app: nginx-nodeport
  ports:
    - protocol: TCP
      port: 80
      nodePort: 30001
  type: NodePort
```
# 3. LoadBalancer Servisi
loadbalancer.yaml
```bash 
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-loadbalancer-config
data:
  index.html: |
    <!DOCTYPE html>
    <html>
    <head>
        <title>Kubernetes Services Test - LoadBalancer</title>
    </head>
    <body>
        <h1>LoadBalancer Service</h1>
        <p>This service type is accessible from outside the cluster via a cloud provider's load balancer.</p>
    </body>
    </html>
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-loadbalancer-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-loadbalancer
  template:
    metadata:
      labels:
        app: nginx-loadbalancer
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        volumeMounts:
        - name: nginx-loadbalancer-config
          mountPath: /usr/share/nginx/html
      volumes:
      - name: nginx-loadbalancer-config
        configMap:
          name: nginx-loadbalancer-config
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-loadbalancer
spec:
  selector:
    app: nginx-loadbalancer
  ports:
    - protocol: TCP
      port: 80
  type: LoadBalancer
```
# 4. ExternalName Servisi
externalname.yaml

```bash 
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-externalname-config
data:
  index.html: |
    <!DOCTYPE html>
    <html>
    <head>
        <title>Kubernetes Services Test - ExternalName</title>
    </head>
    <body>
        <h1>ExternalName Service</h1>
        <p>This service type provides a DNS alias for an external service.</p>
    </body>
    </html>
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-externalname-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-externalname
  template:
    metadata:
      labels:
        app: nginx-externalname
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        volumeMounts:
        - name: nginx-externalname-config
          mountPath: /usr/share/nginx/html
      volumes:
      - name: nginx-externalname-config
        configMap:
          name: nginx-externalname-config
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-externalname
spec:
  type: ExternalName
  externalName: example.com
```
## Manifest Dosyalarını Uygula:
```bash 
kubectl apply -f clusterip.yaml
kubectl apply -f nodeport.yaml
kubectl apply -f loadbalancer.yaml
kubectl apply -f externalname.yaml
```

## Servisleri Kontrol Et:
```bash 
kubectl get services
```
