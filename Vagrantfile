# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vbguest.auto_update = true
  
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ""
    config.proxy.https    = ""
    config.proxy.no_proxy = "localhost,127.0.0.1,192.168.1.9,192.168.1.10,192.168.1.11,192.168.1.12,192.168.1.13,192.168.1.200"
  end
  
  config.vm.define :lvs1 do |lvs1|
    lvs1.vm.box = "centos/7"
    lvs1.vm.network :private_network, ip: "192.168.1.9"
    lvs1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "300", "--cpus", "1"]
    end
    lvs1.vm.provision "shell" do |s|
      s.path = "centos/yum-setup.sh"
    end
    
    config.vm.provision "file", source: "centos/keepalived.service.d", destination: "/tmp/"
    
    lvs1.vm.provision "shell" do |s|
      s.path = "centos/keepalived-setup.sh"
    end
    lvs1.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :lvs2 do |lvs2|
    lvs2.vm.box = "centos/7"
    lvs2.vm.network :private_network, ip: "192.168.1.10"
    lvs2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "300", "--cpus", "1"]
    end
    lvs2.vm.provision "shell" do |s|
      s.path = "centos/yum-setup.sh"
    end

    config.vm.provision "file", source: "centos/keepalived.service.d", destination: "/tmp/"

    lvs2.vm.provision "shell" do |s|
      s.path = "centos/keepalived-setup.sh"
    end
    lvs2.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :hap1 do |hap1|
    hap1.vm.box = "centos/7"
    hap1.vm.network :private_network, ip: "192.168.1.21"
    hap1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "300", "--cpus", "1"]
    end
    hap1.vm.provision "shell" do |s|
      s.path = "centos/yum-setup.sh"
    end
    hap1.vm.provision "shell" do |s|
      s.path = "centos/haproxy-setup.sh"
    end
    hap1.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :hap2 do |hap2|
    hap2.vm.box = "centos/7"
    hap2.vm.network :private_network, ip: "192.168.1.22"
    hap2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "300", "--cpus", "1"]
    end
    hap2.vm.provision "shell" do |s|
      s.path = "centos/yum-setup.sh"
    end
    hap2.vm.provision "shell" do |s|
      s.path = "centos/haproxy-setup.sh"
    end
    hap2.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :web1 do |web1|
    web1.vm.box = "centos/7"
    web1.vm.network :private_network, ip: "192.168.1.11"
    web1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "256", "--cpus", "1"]
    end
    web1.vm.provision "shell" do |s|
      s.path = "centos/yum-setup.sh"
    end
    web1.vm.provision "shell" do |s|
      s.path = "centos/apache2.sh"
      s.args = "Web1"
    end
    web1.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end
  
  config.vm.define :web2 do |web2|
    web2.vm.box = "centos/7"
    web2.vm.network :private_network, ip: "192.168.1.12"
    web2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "256", "--cpus", "1"]
    end
    web2.vm.provision "shell" do |s|
      s.path = "centos/yum-setup.sh"
    end
    web2.vm.provision "shell" do |s|
      s.path = "centos/apache2.sh"
      s.args = "Web2"
    end
    web2.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  end

  #config.vm.define :rpmbuild do |rpmbuild|
  #  rpmbuild.vm.box = "centos/7"
  #  rpmbuild.vm.network :private_network, ip: "192.168.1.13"
  #  rpmbuild.vm.provider :virtualbox do |vb|
  #    vb.customize ["modifyvm", :id, "--memory", "256", "--cpus", "1"]
  #  end
  #  rpmbuild.vm.provision "shell" do |s|
  #    s.path = "centos/yum-setup.sh"
  #  end
  #  rpmbuild.vm.synced_folder "./", "/vagrant", owner: "vagrant", group: "vagrant", type: "virtualbox"
  #end

end
