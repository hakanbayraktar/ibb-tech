# 1. Helm ve NGINX Helm Repository Ekleme
NGINX Ingress Controller için Helm repository'sini ekleyin ve güncelleyin:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```
# 2. NGINX Ingress Controller'ı Kurma
Aşağıdaki komut, NGINX Ingress Controller'ı ingress-nginx isimli bir namespace içinde kuracaktır. Helm, bu namespace'i otomatik olarak oluşturur.
```bash
helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace
```
# 3. Kurulumun Doğrulanması
Kurulumun başarılı olup olmadığını kontrol etmek için aşağıdaki komutları kullanabilirsiniz:

```bash
kubectl get pods --namespace ingress-nginx
kubectl get services --namespace ingress-nginx
```

# 4. Ingress için Path-Based Routing Örneği
```bash
#ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: example.com   
      http:
        paths:
          - path: /app1   
            pathType: Prefix
            backend:
              service:
                name: app1-service   
                port:
                  number: 80
          - path: /app2   
            pathType: Prefix
            backend:
              service:
                name: app2-service   
                port:
                  number: 80
```
```bash
kubectl apply -f ingress.yaml
```

5. app1 Service Manifest Dosyası (Nginx)
```bash
#app1-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: app1-service
  namespace: default
spec:
  selector:
    app: app1
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80 
```   
```bash
kubectl apply -f app1-service.yaml
```

6. app2 Service Manifest Dosyası (Apache/Httpd)
```bash
#app2-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: app2-service
  namespace: default
spec:
  selector:
    app: app2
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```bash
kubectl apply -f app2-service.yaml
```
7. app1 Deployment (Nginx)
```bash
#app1-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app1-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
        - name: app1
          image: nginx:latest  
          ports:
            - containerPort: 80
```
```bash
kubectl apply -f app1-deployment.yaml
```
8. app2 Deployment (Apache/Httpd)
```bash
#app2-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app2-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app2
  template:
    metadata:
      labels:
        app: app2
    spec:
      containers:
        - name: app2
          image: httpd:latest   
          ports:
            - containerPort: 80
```
```bash
kubectl apply -f app1-deployment.yaml
```
     
