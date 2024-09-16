# Step 1: Empty volume Type with POD
## Create a Pod with from the manifest
pod-empty.yaml
```bash 
apiVersion: v1
kind: Pod
metadata:
  name: volume-example
spec:
  containers:
  - name: nginx
    image: nginx:stable-alpine
    ports:
    - containerPort: 80
    volumeMounts:
    - name: html
      mountPath: /usr/share/nginx/html
      readOnly: true
  - name: content
    image: alpine:latest
    volumeMounts:
    - name: html
      mountPath: /html
    command: ["/bin/sh", "-c"]
    args:
      - while true; do
          echo $(date)"<br />" >> /html/index.html;
          sleep 5;
        done
  volumes:
  - name: html
    emptyDir: {}
```
```bash 
kubectl create -f pod-empty.yaml
```
# Step 2 Persistent Volumes and Claims 
## Host Volume Type example (pv-pvc create)
pv-host.yaml
```bash 
kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv-host
  labels:
    type: hostpath
spec:
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    type: DirectoryOrCreate
    path: "/data/mypv"
```
pvc-host.yaml
```bash 
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: pvc-host
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: standard
  resources:
    requests:
      storage: 1Gi
```

```bash 
kubectl apply -f pv-host.yaml
kubectl apply -f pvc-host.yaml
```
### Deployment Volume Mount Example 
htm-vol.yaml
```bash 
kind: PersistentVolume
apiVersion: v1
metadata:
  name: html
  labels:
    type: hostpath
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  storageClassName: html
  persistentVolumeReclaimPolicy: Delete
  hostPath:
    type: DirectoryOrCreate
    path: "/tmp/html"

---

kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: html
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: html
  resources:
    requests:
      storage: 1Gi
      
```
deployment-writer.yaml
```bash 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: writer
spec:
  replicas: 1
  selector:
    matchLabels:
      app: writer
  template:
    metadata:
      labels:
        app: writer
    spec:
      containers:
      - name: content
        image: alpine:latest
        volumeMounts:
        - name: html
          mountPath: /html
        command: ["/bin/sh", "-c"]
        args:
        - while true; do
          date >> /html/index.html;
          sleep 5;
          done
      volumes:
      - name: html
        persistentVolumeClaim:
          claimName: html

```
deployment-reader.yaml
```bash 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reader
spec:
  replicas: 3
  selector:
    matchLabels:
      app: reader
  template:
    metadata:
      labels:
        app: reader
    spec:
      containers:
      - name: nginx
        image: nginx:stable-alpine
        ports:
        - containerPort: 80
        volumeMounts:
        - name: html
          mountPath: /usr/share/nginx/html
          readOnly: true
      volumes:
      - name: html
        persistentVolumeClaim:
          claimName: html

---
apiVersion: v1
kind: Service
metadata:
  name: reader
spec:
  selector:
    app: reader
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80

```

```bash 
kubectl apply -f html-vol.yaml
kubectl apply -f deployment-writer.yaml
kubectl apply -f deployment-reader.yaml
```