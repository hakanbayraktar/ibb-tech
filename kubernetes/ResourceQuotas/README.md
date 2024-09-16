# 1. Resource Quota Tanımlaması
İlk olarak, bir namespace'e uygulanacak ResourceQuota'yı tanımlayalım. Bu, bir namespace içindeki kaynakların toplam kullanımını kısıtlar.

# my-namespace adında namespace oluşturalım

```bash 
kubectl create ns my-namespace
```

namespace-resourcequota.yaml
```bash 
apiVersion: v1
kind: ResourceQuota
metadata:
  name: example-quota
  namespace: my-namespace
spec:
  hard:
    requests.cpu: "4"           # Tüm pod'lar için toplam CPU isteği
    requests.memory: "8Gi"      # Tüm pod'lar için toplam bellek isteği
    limits.cpu: "8"             # Tüm pod'lar için toplam CPU sınırı
    limits.memory: "16Gi"       # Tüm pod'lar için toplam bellek sınırı
```
```bash 
kubectl apply -f namespace-resourcequota.yaml
```
# 2. Pod için CPU ve RAM Kısıtlaması
Bir pod'a CPU ve bellek kısıtlaması uygulayalım:

pod-resourcequota.yaml
```bash 
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
  namespace: my-namespace
spec:
  containers:
  - name: my-container
    image: nginx
    resources:
      requests:
        memory: "128Mi"
        cpu: "250m"
      limits:
        memory: "256Mi"
        cpu: "500m"
```
```bash 
kubectl apply -f pod-resourcequota.yaml
```
**requests:** Container'ın ihtiyaç duyduğu minimum kaynaklar (planlama için kullanılır).   
**limits:** Container'ın kullanabileceği maksimum kaynaklar.
Bu örnekte:  
Pod, minimum 128MiB RAM ve 250m CPU isteğinde bulunur.
Pod'un kullanabileceği maksimum RAM 256MiB ve maksimum CPU 500m'dir.

# 3. Deployment için CPU ve RAM Kısıtlaması
Bir deployment üzerinde CPU ve bellek kısıtlaması örneği:

deployment-resourcequota.yaml
```bash 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment
  namespace: my-namespace
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: nginx
        resources:
          requests:
            memory: "128Mi"
            cpu: "250m"
          limits:
            memory: "256Mi"
            cpu: "500m"
```
```bash 
kubectl apply -f deployment-resourcequota.yaml
```
Bu deployment, 3 replikalı bir uygulamayı başlatır ve her bir pod için kaynak kısıtlamaları sağlar:

Minimum 128MiB RAM ve 250m CPU istenir.
Maksimum 256MiB RAM ve 500m CPU kullanılır.