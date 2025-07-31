
# One-Node RKE2 Cluster with NVIDIA GPU Operator

**Hostname**: `pln-aidev02.calix.local`  
**IP Address**: `10.172.249.105`  
**iDRAC IP**: `10.152.0.116`  
**OS**: Ubuntu 24.04 

---

## Purpose

This document outlines the setup of a single-node Kubernetes cluster using RKE2, with GPU capability via the NVIDIA GPU Operator. It also covers storage provisioning with dedicated volumes and validation steps to ensure a clean deployment.

---

## 1. Provision Storage

### Identify disk
```
lsblk
```

### Create volume group and logical volumes
```
pvcreate /dev/sda
vgcreate datavg /dev/sda

lvcreate -L 2T -n dockerlv datavg
lvcreate -L 100G -n optlv datavg

mkfs.ext4 /dev/datavg/dockerlv
mkfs.ext4 /dev/datavg/optlv
```

### Mount volumes
```
mkdir -p /var/lib/docker
mkdir -p /opt

echo '/dev/datavg/dockerlv /var/lib/docker ext4 defaults 0 2' >> /etc/fstab
echo '/dev/datavg/optlv /opt ext4 defaults 0 2' >> /etc/fstab

mount -a
```

---

## 2. Install NVIDIA GPU Driver

```
lspci | grep -i nvidia
lspci | grep -i vga
uname -r

cp -v /boot/initrd.img-* /boot/initrd.img-*.bak
cp -v /boot/vmlinuz-* /boot/vmlinuz-*.bak
cp -v /boot/grub/grub.cfg /boot/grub/grub.cfg.bak

cat <<EOF | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF

update-initramfs -u
update-initramfs -u -k $(uname -r)

apt-get update
NEEDRESTART_MODE=a apt-get -y install nvidia-utils-570-server nvidia-headless-570-server --no-install-recommends --no-install-suggests

nvidia-smi
```

---

## 3. Install RKE2 Server

```
curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service
```

---

## 4. Move Kubelet Directory

```
systemctl stop rke2-server.service

rsync -aHAXxv /var/lib/kubelet/ /var/lib/docker/kubelet/
echo '/var/lib/docker/kubelet /var/lib/kubelet none bind 0 0' >> /etc/fstab

mount -a
```

---

## 5. Configure Kubeconfig Access

```
mkdir -p ~/.kube
cp /etc/rancher/rke2/rke2.yaml ~/.kube/config
echo 'export KUBECONFIG=~/.kube/config' >> ~/.bashrc
source ~/.bashrc
```

---

## 6. Install Helm

```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

---

## 7. Create Namespace and Set Enforcement

```
kubectl create ns gpu-operator
kubectl label --overwrite ns gpu-operator pod-security.kubernetes.io/enforce=privileged
```

---

## 8. Install NVIDIA GPU Operator

```
helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
helm repo update

helm install --wait --generate-name \
  -n gpu-operator --create-namespace \
  nvidia/gpu-operator \
  --version=v25.3.2
```

---

## 9. Validate Cluster Setup

```
kubectl get nodes -o wide
kubectl get pods -A

kubectl get all -n kube-system
kubectl get all -n gpu-operator

kubectl get deployments -n kube-system
kubectl get deployments -n gpu-operator

helm list -n gpu-operator
```
