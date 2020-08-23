### Prerequisites
- Install Vagrant > 2.2.9
- Install Virtualbox >6.1

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
# Try kubectl commands
alias k='kubectl '
k get nodes
k get nodes -o wide
k get po
k get ns
```

## Delete Cluster
```
# If you want to destroy images
vagrant destroy -f
```

## System Resources
```
Before VMs build:
CPU: 9% (4 Core)
MEM: 5.2GB (16GB)

After VMs build:
CPU: 15% (4 Core)
MEM: 9.4GB (16GB)
```
