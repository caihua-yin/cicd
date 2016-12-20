Vagrant boxes - Run following commands to prepare dev and prod environments:
- `vagrant up dev --provision`: start and provision dev machine
- `vagrant up prod01 prod02 prod03`: start three prod machines

Ansible playbooks - Run following commands on dev node (CWD as /vagrant/github.com/caihua-yin/cicd/ansible/):
- `ansible-playbook app.yml -i inventory/prod`: Deploy app to first prod node
- `ansible-playbook etcd-registrator-confd.yml -i inventory/prod`: Deploy etcd, registrator (with etcd protocol) and confd to all of the three prod nodes. For confd, only *onetime* mode is supported currently, need run `confd -onetime -backend etcd -node 192.168.33.21:2379`
- `ansible-playbook consul-registrator.yml -i inventory/prod --tags registrator`: Deploy consul and registor (with consul protocol) to all of the three prod nodes.
