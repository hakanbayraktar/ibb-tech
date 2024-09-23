#!/bin/bash

# 1. Sistem güncellemesi ve yükseltme
sudo apt update && sudo apt upgrade -y

# 2. Swap'i devre dışı bırakma
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# 3. Gerekli modülleri yükleme
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# 4. Ağ yapılandırması
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

# 5. Gerekli bağımlılıkları kurma
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

# 6. Docker için GPG anahtarını ekleme
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg

# 7. Docker deposunu ekleme
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update

# 8. Containerd kurma
sudo apt install -y containerd.io
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

# 9. Containerd servisini başlatma ve etkinleştirme
sudo systemctl restart containerd
sudo systemctl enable containerd

# 10. Kubernetes için GPG anahtarını ekleme ve depo yapılandırması
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# 11. Kubernetes bileşenlerini yükleme
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# 12. Kubernetes cluster'ı başlatma
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# 13. Kubectl yapılandırması
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 14. Calico ağ eklentisini yükleme
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

# 15. Cluster durumu kontrolü
kubectl get pods -n kube-system
kubectl get nodes

echo "Kubernetes master node kurulumu başarıyla tamamlandı!"