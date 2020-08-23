ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

config.vm.provision "shell", path: "bootstrap.sh"

  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/xenial64"
    master.vm.hostname = "master.com"
    master.vm.network "private_network", ip: "172.42.42.100"
    master.vm.provider "virtualbox" do |v|
      v.name = "master"
      v.cpus = 2
      v.memory = 2048
      v.gui = false
    end
    master.vm.provision "shell", path: "bootstrap_master.sh"
  end

  NodeCount = 2

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "worker#{i}" do |workernode|
      workernode.vm.box = "ubuntu/xenial64"
      workernode.vm.hostname = "worker#{i}.com"
      workernode.vm.network "private_network", ip: "172.42.42.10#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "worker#{i}"
        v.memory = 800
        v.cpus = 1
      end
      workernode.vm.provision "shell", path: "bootstrap_worker.sh"
    end
  end
end
