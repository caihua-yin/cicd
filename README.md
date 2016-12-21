Vagrant boxes - Run following commands to prepare dev and prod environments:
- `vagrant up dev --provision`: start and provision dev machine
- `vagrant up prod01 prod02 prod03`: start three prod machines

Ansible playbooks - Run following commands on dev node (CWD as /vagrant/github.com/caihua-yin/cicd/ansible/):
- `ansible-playbook app.yml -i inventory/prod`: Deploy app to first prod node
- `ansible-playbook etcd-registrator-confd.yml -i inventory/prod`: Deploy etcd, registrator (with etcd protocol) and confd to all of the three prod nodes. For confd, only *onetime* mode is supported currently, need run `confd -onetime -backend etcd -node 192.168.33.21:2379`
- `ansible-playbook consul-registrator.yml -i inventory/prod`: Deploy consul, registor (with consul protocol) and consul-template to all of the three prod nodes. For consul-template, only *onetime* mode is supported currently, need run `consul-template -once -template "/data/consul-template/app.yml.ctmpl:/tmp/app-config-by-consul-template.yml" -consul 192.168.33.21:8500`
