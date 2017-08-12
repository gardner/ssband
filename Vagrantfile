# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.host_name = "jessie"

  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 4
  end

  config.vm.post_up_message = "The machine has all the dependencies installed to build node. Please use 'vagrant ssh' to login and then run ./build_node_for_android.sh"

  config.vm.provision :shell,
    privileged: true,
    path: "vagrant.sh"
end
