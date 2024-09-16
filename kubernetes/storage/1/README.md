# Step 1: Empty volume Type with POD
### Create a Pod with from the manifest
kubectl create -f pod-empty.yaml

# Step 2 Persistent Volumes and Claims 
### Host Volume Type example (pv-pvc create)
kubectl apply -f pv-host.yaml
kubectl apply -f pvc-host.yaml

### Deployment Volume Mount Example 
kubectl apply -f html-vol.yaml
kubectl apply -f deployment-writer.yaml
kubectl apply -f deployment-reader.yaml
