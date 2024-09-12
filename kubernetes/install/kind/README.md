# kind installation
https://kind.sigs.k8s.io/docs/user/quick-start/#installation
kind install on Ubuntu

# Step 1-install docker
curl -s https://raw.githubusercontent.com/hakanbayraktar/ibb-tech/main/docker/ubuntu-24-docker-install.sh | bash

# Step 2 -install kind
    # For AMD64 / x86_64
    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-amd64
    # For ARM64
    [ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.24.0/kind-linux-arm64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind

# Step 3-install kubectl
curl -LO "https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client

# Step 4-Create kind cluster 

### Create a kind config yaml
cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

### Create a kind cluster with config.yaml
kind create cluster --config kind-config.yaml

###  check nodes
kubectl get nodes
###  create a nginx pod
kubectl run nginx --image=nginx
kubectl get pod
