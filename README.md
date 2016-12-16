Vagrant box for following environments:
- Development (vagrant up dev --provision)
- Production (vagrant up prod)

Ansible playbook:
Run `ansible-playbook playbooks/prod.yml -i hosts/prod` at dev node
