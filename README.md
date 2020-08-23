### Local Kubernetes Cluster
If you want to have a Kubernetes cluster to prepare for your CKA/CKAD exam and practice. If you do not want to use cloud services to build a cluster this Vagrantfile will build it for you on your local machine.

### Prerequisites
- Memory: 12 or 16 GB
- CPU 4 ore more physical cores
- Install Vagrant > 2.2.9
- Install VirtualBox > 6.1

### Troubleshooting
```
# If you get Hash Sum mismatch run cmd as administrator and execute:
# -Disable Windows Hyper-v
```

### Build Cluster
```
# Navigate to local-kubernetes-cluster folder
# Build and configure VMs
vagrant up

# Copy .kube/config file from master
scp root@172.42.42.100:/home/vagrant/.kube/config config
Password: kubeadmin
mv ~/.kube/config ~/.kube/config.backup
cp config ~/.kube/config
```

### Use Cluster
```
# Try kubectl commands:
alias k='kubectl '
k get nodes
k get nodes -o wide
k get po
k get ns
```

### Delete Cluster
```
# If you want to destroy the Virtual Machines built for this cluster use:
vagrant destroy -f
```

### System Resources
```
Before VMs build:
CPU: 9% (4 Core, 3.2 GHz)
MEM: 5.2GB (16GB)

After VMs build:
CPU: 15% (4 Core)
MEM: 9.4GB (16GB)
```
