# 1: Helm Kurulumu
Helm, Kubernetes uygulamalarını yönetmek için kullanılır. Öncelikle Helm'i kuruyoruz.

```bash 
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```
Helm kurulduktan sonra sürümünü kontrol edin:

```bash 
helm version
```
# 2: NGINX Ingress Controller Kurulumu
NGINX Ingress Controller, Kubernetes’te HTTP ve HTTPS trafiğini yönlendirmek için kullanılır. Helm üzerinden kurulumu yapacağız:

## Helm repo'yu ekleyin:

```bash 
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

```
# NGINX Ingress Controller'ı yükleyin:
```bash 
helm install ingress-nginx ingress-nginx/ingress-nginx \
--namespace ingress-nginx --create-namespace
```
# Ingress controller’ın durumu kontrol edin:
```bash 
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
```
# 3: Test Etmek İçin Bir Uygulama Yükleme
Kubernetes içinde bir uygulama ve servis oluşturacağız. Basit bir NGINX deployment kullanacağız:

# Uygulama deployment'ı oluşturun:
```bash 
# base-app-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-app
  labels:
    app: example
spec:
  replicas: 2
  selector:
    matchLabels:
      app: example
  template:
    metadata:
      labels:
        app: example
    spec:
      containers:
      - name: example-app
        image: hashicorp/http-echo
        args:
        - "-text=Hello from Kubernetes"
        ports:
        - containerPort: 5678
```
Bu yaml dosyasını *** base-app-deploy.yaml *** olarak kaydedin ve ardından uygulayın:

```bash 
kubectl apply -f base-app-deploy.yaml
```
# Servis oluşturun:

```bash 
# base-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: example-service
spec:
  selector:
    app: example
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```
Bu yaml dosyasını *** base-svc.yaml *** olarak kaydedin ve uygulayın:

```bash 
kubectl apply -f base-svc.yaml
```
# 4: HTTP Ingress Oluşturma
NGINX Ingress Controller üzerinden trafiği yönlendirecek bir Ingress kaynağı oluşturacağız.

# Ingress yaml dosyasını oluşturun:
```bash 
# base-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: test.devopslearnwith.us
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: example-service
            port:
              number: 80
```
Bu dosyayı *** base-ingress.yaml *** olarak kaydedin ve uygulayın:

```bash 
kubectl apply -f base-ingress.yaml
```
DNS Kaydı Yapılandırma:

Ingress’in dış IP adresini almak için aşağıdaki komutu çalıştırın:

```bash 
kubectl get svc -n ingress-nginx
```
EXTERNAL-IP adresini alın ve domaininizin DNS kayıtlarına A kaydı olarak ekleyin.

# Siteyi HTTP Üzerinden Test Etme:

Domain adınız ile http://test.devopslearnwith.us adresine giderek uygulamanızın çalıştığından emin olun.

# 5 Cert-Manager Kurulumu
Cert-Manager, Let's Encrypt gibi sertifika sağlayıcılarından otomatik olarak sertifika almanızı sağlar.

# Helm repo'yu ekleyin ve güncelleyin:

```bash 
helm repo add jetstack https://charts.jetstack.io
helm repo update
```
# Cert-Manager'ı yükleyin:

```bash 
helm install cert-manager jetstack/cert-manager \
--namespace cert-manager --create-namespace \
--version v1.12.0 \
--set installCRDs=true
```
# Cert-Manager’ın düzgün çalıştığını doğrulayın:

```bash 
kubectl get pods -n cert-manager
```
# 6: Let's Encrypt ClusterIssuer Kurulumu
Let's Encrypt üzerinden sertifika almak için ClusterIssuer tanımlayın.

# ClusterIssuer yaml dosyasını oluşturun:
```bash 
# cluster-issuer.yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@example.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
```
Bu dosyayı *** cluster-issuer.yaml *** olarak kaydedin ve uygulayın:

```bash 
kubectl apply -f cluster-issuer.yaml
```
# 7 : HTTPS Ingress Kurulumu
Ingress yaml dosyasını güncelleyin:

```bash 
# tls-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - test.devopslearnwith.us
    secretName: example-tls
  rules:
  - host: test.devopslearnwith.us
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: example-service
            port:
              number: 80
```
Bu dosyayı *** tls-ingress.yaml ** kaydedin ve uygulayın:

```bash 
kubectl apply -f tls-ingress.yaml
```
# Cert-Manager'ın otomatik olarak sertifika oluşturduğunu doğrulayın:
```bash 
kubectl describe certificate example-tls
kubectl get cert
```
# Siteyi HTTPS üzerinden test edin:

Tarayıcınızda https://test.devopslearnwith.us adresine giderek SSL sertifikasının başarıyla kurulduğunu kontrol edin.