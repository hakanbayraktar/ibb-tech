# DaemonSet Nedir?
DaemonSet, Kubernetes'te tüm veya belirli bir node setindeki her bir node'da bir kopya çalıştıran bir kontrol yöneticisidir. Genellikle sistem düzeyinde servisler (örneğin, log toplama veya izleme) için kullanılır.

## Örnek: Fluent Bit DaemonSet
Bu örnekte, Fluent Bit'i bir DaemonSet olarak dağıtacağız. Fluent Bit, bir log toplama aracıdır ve logları merkezi bir log yönetim sistemine gönderebilir.

fluent-bit-daemonset.yaml
```bash 
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluent-bit
  namespace: logging
spec:
  selector:
    matchLabels:
      app: fluent-bit
  template:
    metadata:
      labels:
        app: fluent-bit
    spec:
      containers:
      - name: fluent-bit
        image: fluent/fluent-bit:1.8
        volumeMounts:
        - name: fluent-bit-config
          mountPath: /fluent-bit/etc
        - name: varlog
          mountPath: /var/log
      volumes:
      - name: fluent-bit-config
        configMap:
          name: fluent-bit-config
      - name: varlog
        hostPath:
          path: /var/log
```
```bash 
kubectl apply -f fluent-bit-daemonset.yaml
```
## Fluent Bit ConfigMap Oluşturun
fluent-bit-config.yaml
```bash 
apiVersion: v1
kind: ConfigMap
metadata:
  name: fluent-bit-config
  namespace: logging
data:
  fluent-bit.conf: |
    [SERVICE]
        Flush        1
        Daemon       Off
        Log_Level    info

    [INPUT]
        Name         tail
        Path         /var/log/*.log
        Tag          kube.*
        Refresh_Interval 5

    [OUTPUT]
        Name         stdout
        Match        *
``` 
```bash 
kubectl apply -f fluent-bit-config.yaml
```