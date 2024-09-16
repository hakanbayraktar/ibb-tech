# Step 1. Deployment Oluşturma
İlk olarak, NGINX sürüm 1.17 ile bir Deployment oluşturacağız. Bu Deployment’ı aşağıdaki YAML dosyası ile kümenize uygulayabilirsiniz:

deployment.yaml
```bash 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.17
        ports:
        - containerPort: 80

```
## Deployment’ı kümenize uygulamak için:
```bash 
kubectl apply -f nginx-deployment.yaml
```

# Step 2. Uygulamanın Durumunu Kontrol Etme
```bash 
kubectl rollout status deployment/nginx-deployment
```
# Step 3. Güncelleme: set image
Şimdi, nginx:1.17 sürümünü nginx:1.19 sürümüne güncelleyelim.
```bash 
kubectl set image deployment/nginx-deployment nginx=nginx:1.19 --record
```
## Güncellemenin başarılı olup olmadığını kontrol etmek için:
```bash 
kubectl rollout status deployment/nginx-deployment
```
# Step 4. Rollout ve Rollback İşlemleri
Güncellemeden memnun değilseniz veya bir sorun yaşandıysa, önceki sürüme geri dönebilirsiniz. Rollback işlemini şu şekilde yapabilirsiniz:
```bash 
kubectl rollout undo deployment/nginx-deployment
```
Bu komut, nginx:1.17 sürümüne geri dönecektir.

## Rollout History
Tüm güncellemelerin geçmişini görmek için:
```bash 
kubectl rollout history deployment/nginx-deployment
```
# Step 5. Güncelleme Stratejileri
Kubernetes’de iki ana güncelleme stratejisi bulunur: RollingUpdate ve Recreate.

## RollingUpdate Stratejisi
--- roolingupdate.yaml
```bash 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.19  # Güncellenmiş image
        ports:
        - containerPort: 80
```
```bash 
kubectl apply -f rollingupdate.yaml
```
## Recreate Stratejisi
--- recreate.yaml
```bash 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: Recreate  # Eski pod'lar tamamen durdurulur, yeni pod'lar başlatılır
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.19  # Güncellenmiş image
        ports:
        - containerPort: 80
```
```bash 
kubectl apply -f recreate.yaml
```
# Step 6. Temizlik
```bash 
kubectl delete -f nginx-deployment.yaml
```