#!/bin/bash
set -e

echo "[1/8] Loading kernel modules..."
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

echo "[2/8] Applying sysctl settings..."
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system

echo "[3/8] Installing containerd prerequisites..."
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common

echo "[4/8] Installing containerd..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
> /etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y containerd.io

echo "[5/8] Configuring containerd with systemd cgroup driver..."
mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null

sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

systemctl restart containerd
systemctl enable containerd

echo "[6/8] Adding Kubernetes APT repository..."
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key \
| gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" \
> /etc/apt/sources.list.d/kubernetes.list

echo "[7/8] Installing kubeadm, kubelet, kubectl..."
apt-get update
apt-get install -y kubelet kubeadm kubectl
systemctl enable kubelet

echo "[8/8] Disabling swap (required for Kubernetes)..."
swapoff -a
sed -i '/swap/d' /etc/fstab

echo "==================================================="
echo " Kubernetes Host Bootstrap COMPLETE "
echo "==================================================="
echo "Run the following to initialize your cluster:"
echo
echo "  kubeadm init --pod-network-cidr=192.168.0.0/16"
echo
echo "Then configure kubectl:"
echo
echo "  mkdir -p \$HOME/.kube"
echo "  cp -i /etc/kubernetes/admin.conf \$HOME/.kube/config"
echo "  chown \$(id -u):\$(id -g) \$HOME/.kube/config"
echo
echo "Then install Calico CNI:"
echo
echo "  kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml"
echo
echo "==================================================="