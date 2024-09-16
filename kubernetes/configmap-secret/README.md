# 1. ConfigMap Manifest

--configmap.yaml
```bash 
apiVersion: v1
kind: ConfigMap
metadata:
  name: wordpress-config
data:
  WORDPRESS_DB_NAME: wordpress
```
```bash 
kubectl apply -f configmap.yaml
```
# 2. Secret Manifest
-- secret.yaml
```bash 
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
type: Opaque
data:
  MYSQL_ROOT_PASSWORD: cGFzc3dvcmQ=   # base64 encoded "password"
  MYSQL_USER: d29yZHByZXNz   # base64 encoded "wordpress"
  MYSQL_PASSWORD: cGFzc3dvcmQ=   # base64 encoded "password"
```
```bash 
kubectl apply -f secret.yaml
```
# 3. MySQL Deployment

--- mysql-deployment.yaml
```bash 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  selector:
    matchLabels:
      app: mysql
  replicas: 1
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:8.0
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_ROOT_PASSWORD
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_USER
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            configMapKeyRef:
              name: wordpress-config
              key: WORDPRESS_DB_NAME
        ports:
        - containerPort: 3306
          name: mysql
```
```bash 
kubectl apply -f mysql-deployment.yaml
```
# 4. WordPress Deployment
--- wordpres-deployment.yaml
```bash 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wordpress
spec:
  selector:
    matchLabels:
      app: wordpress
  replicas: 1
  template:
    metadata:
      labels:
        app: wordpress
    spec:
      containers:
      - name: wordpress
        image: wordpress:php7.4-apache
        env:
        - name: WORDPRESS_DB_HOST
          value: mysql:3306
        - name: WORDPRESS_DB_USER
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_USER
        - name: WORDPRESS_DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: MYSQL_PASSWORD
        - name: WORDPRESS_DB_NAME
          valueFrom:
            configMapKeyRef:
              name: wordpress-config
              key: WORDPRESS_DB_NAME
        ports:
        - containerPort: 80
          name: wordpress
```
```bash  
kubectl apply -f wordpress-deployment.yaml
```
# 5. Service Manifestleri
-- mysql-service.yaml
```bash 
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  ports:
  - port: 3306
  selector:
    app: mysql
```
--- wordpress-service.yaml
```bash 
apiVersion: v1
kind: Service
metadata:
  name: wordpress
spec:
  ports:
  - port: 80
  selector:
    app: wordpress
  type: LoadBalancer
```
```bash 
kubectl apply -f mysql-service.yaml
kubectl apply -f wordpress-service.yaml
```
# 6. WordPress Versiyonunu Güncelleme
```bash 
kubectl set image deployment/wordpress wordpress=wordpress:php8.0-apache
```