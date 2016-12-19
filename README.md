Vagrant box for following environments:
- Development (vagrant up dev --provision)
- Production (vagrant up prod01 prod02 prod03)

Ansible playbook - run following commands on dev node (CWD as /vagrant/github.com/caihua-yin/cicd/ansible/):
- `ansible-playbook app.yml -i inventory/app`: Deploy app to first prod node
- `ansible-playbook etcd.yml -i inventory/etcd`: Deploy etcd to all of the three prod nodes
