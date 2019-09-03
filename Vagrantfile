# -*- mode: ruby -*-
# vi: set ft=ruby :

# symlink some directoy as /tmp which has some space (16G)
file_to_disk = './tmp/large_disk.vdi'


Vagrant.configure(2) do |config|

VAGRANT_COMMAND = ARGV[0]
  if VAGRANT_COMMAND == "ssh"
#    config.ssh.username = 'dev'
  end


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
    sudo /tools/install_psql.bash
    sudo /tools/install_mysql.bash
    sudo cp -rsf /vagrant/etc/* /etc/
    sudo cp -rsf /vagrant/bin/* /bin/
    sudo sw hadoop
    sudo sw tez
    sudo sw hive
    sudo /tools/install_hadoop.bash
    sudo /tools/install_hive.bash hive
    sudo /tools/install_tez.bash
    sudo /tools/install_conf.bash
SHELL

    hiveSrcs=ENV['HIVE_SOURCES']
    config.vm.synced_folder hiveSrcs, "/hive-dev" unless hiveSrcs.nil?

end

