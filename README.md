Overview

This document outlines the complete process for standing up a single-node RKE2 Kubernetes cluster on a host (pln-aidev02.calix.local, IP: 10.172.249.105). The goal of this setup is to provision a self-contained development or AI inference environment, leveraging GPU acceleration through the NVIDIA GPU Operator.

The configuration includes:

Logical volume provisioning for /var/lib/docker and /opt
Installation of RKE2 server
Relocation of the kubelet data directory
NVIDIA driver installation
Helm setup
GPU Operator deployment
Key considerations such as namespace creation, privileged pod enforcement, and RBAC (future step) are also noted to ensure GPU workloads are managed securely and reliably. This setup serves as a foundation for future multi-node scaling or integration with additional workloads.
