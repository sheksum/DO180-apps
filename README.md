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






root@k8s-exam-vm:~# history 
    1  apt-get update
    2  kubectl
    3  apt-get install docker*
    4  ps -ef | grep 2310
    5  cloud-init status --long
    6  cat /var/log/cloud-init-output.log 
    7  docker
    8  dpkg -l | grep -E "kube|containers"
    9  systemctl status containerd
   10  systemctl status ssh
   11  cat /etc/apt/sources.list
   12  exit
   13  vi setup.k8s.sh
   14  chmod +x setup.k8s.sh 
   15  ./setup.k8s.sh 
   16  rm -f /etc/apt/sources.list.d/kubernetes.list 
   17  cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list 
   18  deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/
   19   /
   20  EOF
   21  vi /etc/apt/sources.list.d/kubernetes.list
   22  vi /etc/apt/sources.list.d/kubernetes.list 
   23  mkdir -p /etc/apt/keyrings
   24  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
   25  sudo apt-update
   26  apt update
   27  rm -f /etc/apt/sources.list.d/docker.list 
   28  ls /etc/apt/sources.list.d/
   29  apt install -y containerd
   30  mkdir -p /etc/containerd
   31  containerd config default | tee /etc/containerd/config.toml
   32  sed -i 's/SystemCGroup = false/SystemdCgrup = true/' /etc/containerd/config.toml 
   33  systemctl restart containerd.service 
   34  systemctl enable container-getty@ 
   35  systemctl enable containerd
   36  systemctl status containerd.service 
   37  apt install -y kublet kubeadm kubectl
   38  apt install -y kubelet kubeadm kubectl
   39  systemctl status kublet
   40  systemctl status kubelet
   41  systemctl status containerd.service 
   42  systemctl restart containerd
   43  kubelet --version
   44  systemctl enable kubelet
   45  swapoff -a
   46  sed -i '/swap/d' /etc/fstab
   47  lsmod | greo br_net
   48  lsmod | grep br_net
   49  lsmod | grep overla
   50  sysctl net.bridge.bridge-nf-call-iptables 
   51  sysctl net.ipv4.ip_forward
   52  reboot
   53  systemctl status containerd
   54  systemctl restart containerd.service 
   55  journalctl -u kubelet -n 50 --no-pager
   56  cat /var/lib/kubelet/config.yaml
   57  systemctl status kubelet
   58  #kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$(ip -4 addr show ens33 | awk '/inet /{print $2}' | cut -d/ -f1)
   59  kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$(ip -4 addr show ens33 | awk '/inet /{print $2}' | cut -d/ -f1)
   60  ip a
   61  kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$(ip -4 addr show ens3 | awk '/inet /{print $2}' | cut -d/ -f1)
   62  kubectl get nodes -A
   63  history
