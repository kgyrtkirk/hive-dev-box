# -*- mode: ruby -*-
# vi: set ft=ruby :

# symlink some directoy as /tmp which has some space (16G)
file_to_disk = './tmp/large_disk.vdi'

Vagrant.configure(2) do |config|

  config.vm.box = "debian/contrib-stretch64"
  config.vm.hostname = "hive-box"

#  config.disksize.size = "16GB"
#  config.vm.box = "ubuntu/xenial64"
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
#    v.customize ['createhd', '--filename', file_to_disk, '--size', 16 * 1024]
#    v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
  end
  config.vm.network "private_network", ip: "192.168.64.4"

  config.vm.provision "shell", inline: <<SHELL
    cd /
    rm -f tools
    ln -s vagrant/tools tools
    sudo /tools/install_basics.bash
    sudo /tools/install_sdk.bash
    sudo /tools/install_hadoop.bash
    sudo /tools/install_hive.bash
    sudo /tools/install_tez.bash
    sudo cp -rsf /vagrant/conf/* /etc/
    sudo cp -rsf /vagrant/bin/* /bin/
    sudo /tools/install_conf.bash
SHELL

  #config.vm.synced_folder "../hive/master/packaging/target/apache-hive-3.0.0-SNAPSHOT-bin/apache-hive-3.0.0-SNAPSHOT-bin/", "/hive-dev"
  config.vm.synced_folder "../hive/ws/", "/hive-dev"
  #config.vm.synced_folder "../hive/master/", "/hive-dev"

end

