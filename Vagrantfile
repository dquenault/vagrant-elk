VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "chef/ubuntu-14.04"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.define :elastic_search do |es_config|
    # networking options
    es_config.vm.network "private_network", ip: "192.168.33.10"
    es_config.vm.network "forwarded_port", guest: 9200, host: 9222

    es_config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
      v.customize ["modifyvm", :id, "--name", "ES-server"]
    end
 
    es_config.vm.provision "shell", path: "scripts/provision_es.sh"
  end

  config.vm.define :kibana do |kibana_config|
    # networking options
    kibana_config.vm.network "private_network", ip: "192.168.33.20"
    kibana_config.vm.network "forwarded_port", guest: 9080, host: 9081
 
    # commands to send to 'VBoxManage modifyvm' to override VirtualBox defaults
    kibana_config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
      v.customize ["modifyvm", :id, "--name", "kibana"]
    end
	
    kibana_config.vm.provision "shell", path: "scripts/provision_kibana.sh"

    # Upload files
    kibana_config.vm.provision "file", source: "files/kibana.nginx.conf", destination: "kibana" 

    kibana_config.vm.provision "shell", inline: $nginx_copy
    kibana_config.vm.provision "shell", inline: "nginx"
  end
end

$nginx_copy = <<SCRIPT
echo Copying files to right directories
sudo rm /etc/nginx/sites-enabled/default
sudo cp /home/vagrant/kibana /etc/nginx/sites-available/.
sudo cp /home/vagrant/kibana /etc/nginx/sites-enabled/.
SCRIPT
