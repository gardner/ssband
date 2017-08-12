# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.host_name = "jessie"

  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 4
  end

  # Poorman's apt package caching. This accelerates repeated provisioning.
  # From https://gist.github.com/millisami/3798773
  def local_cache(box_name)
    cache_dir = File.join(File.expand_path('~/.vagrant.d'), 'cache', 'apt', box_name)
    partial_dir = File.join(cache_dir, 'partial')
    FileUtils.mkdir_p(partial_dir) unless File.exists? partial_dir
    cache_dir
  end

  cache_dir = local_cache(config.vm.box)
  config.vm.synced_folder cache_dir, "/var/cache/apt/archives/"

  config.vm.post_up_message = "The machine has all the dependencies installed to build node. Please use 'vagrant ssh' to login and then run ./build_node_for_android.sh"

  config.vm.provision :shell,
    privileged: true,
    path: "vagrant.sh"
end
