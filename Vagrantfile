# Generated by Cyber Sandbox Creator 2.0.1
# https://gitlab.ics.muni.cz/muni-kypo-csc/cyber-sandbox-creator
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

ansible_groups = {
  "hosts" => ["web-server-debian10", "dat-server-debian10", "management-kali-2020", "attacker-kali2020"], 
  "routers" => [], 
  "ssh" => ["web-server-debian10", "dat-server-debian10", "management-kali-2020", "attacker-kali2020"], 
  "winrm" => [], 
  "ansible" => ["web-server-debian10", "dat-server-debian10", "management-kali-2020", "attacker-kali2020"]
}

Vagrant.configure("2") do |config|

  # Device(host): web-server-debian10
  config.vm.define "web-server-debian10" do |device|
    device.vm.hostname = "web-server-debian10"
    device.vm.box = "munikypo/debian-10"
    device.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
    device.vm.synced_folder ".",
      "/vagrant",
      type: "rsync",
      rsync__exclude: ".git/"
    device.vm.network "private_network",
      virtualbox__intnet: "network-gcomp",
      ip: "10.10.30.71",
      netmask: "255.255.255.0"
    device.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "preconfig/playbook.yml"
      ansible.groups = ansible_groups
      ansible.limit = "web-server-debian10"
    end
    device.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "provisioning/playbook.yml"
      ansible.groups = ansible_groups
      ansible.limit = "web-server-debian10"
    end
  end

  # Device(host): dat-server-debian10
  config.vm.define "dat-server-debian10" do |device|
    device.vm.hostname = "dat-server-debian10"
    device.vm.box = "munikypo/debian-10"
    device.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
    device.vm.synced_folder ".",
      "/vagrant",
      type: "rsync",
      rsync__exclude: ".git/"
    device.vm.network "private_network",
      virtualbox__intnet: "network-gcomp",
      ip: "10.10.30.81",
      netmask: "255.255.255.0"
    device.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "preconfig/playbook.yml"
      ansible.groups = ansible_groups
      ansible.limit = "dat-server-debian10"
    end
    device.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "provisioning/playbook.yml"
      ansible.groups = ansible_groups
      ansible.limit = "dat-server-debian10"
    end
  end

  # Device(host): management-kali-2020
  config.vm.define "management-kali-2020" do |device|
    device.vm.hostname = "management-kali-2020"
    device.vm.box = "munikypo/kali-2020.4"
    device.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    device.vm.synced_folder ".",
      "/vagrant",
      type: "rsync",
      rsync__exclude: ".git/"
    device.vm.network "private_network",
      virtualbox__intnet: "network-gcomp",
      ip: "10.10.30.101",
      netmask: "255.255.255.0"
    device.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "preconfig/playbook.yml"
      ansible.groups = ansible_groups
      ansible.limit = "management-kali-2020"
    end
    device.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "provisioning/playbook.yml"
      ansible.groups = ansible_groups
      ansible.limit = "management-kali-2020"
    end
  end

  # Device(host): attacker-kali2020
  config.vm.define "attacker-kali2020" do |device|
    device.vm.hostname = "attacker-kali2020"
    device.vm.box = "munikypo/kali-2020.4"
    device.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
    device.vm.synced_folder ".",
      "/vagrant",
      type: "rsync",
      rsync__exclude: ".git/"
    device.vm.network "private_network",
      virtualbox__intnet: "network-gcomp",
      ip: "10.10.30.102",
      netmask: "255.255.255.0"
    device.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "preconfig/playbook.yml"
      ansible.groups = ansible_groups
      ansible.limit = "attacker-kali2020"
    end
    device.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "provisioning/playbook.yml"
      ansible.groups = ansible_groups
      ansible.limit = "attacker-kali2020"
    end
  end
end
