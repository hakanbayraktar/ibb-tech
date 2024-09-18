# Blue-Green Deployment Strategy  

## Command to grep the test results   

### Syntax   
```bash
for i in $(seq 1 10); do curl <app-url>; done | grep -o '<span id='\'podName\''>[^<]*' | sed 's/<[^>]*>//g'
```
### Loadbalancer IP bul
```bash
k get svc 
```
### Example   
```bash
for i in $(seq 1 10); do curl 34.46.138.94; done | grep -o '<span id='\'podName\''>[^<]*' | sed 's/<[^>]*>//g'
```
web sayfasını Loadbalancer IP kullanarak curl veya browserdan görebilirsin.

curl 34.46.138.94
