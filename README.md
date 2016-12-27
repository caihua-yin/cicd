# Vagrant boxes
Run following commands to prepare dev and prod environments:
- `vagrant up dev --provision`: start and provision dev machine
- `vagrant up prod01 prod02 prod03`: start three prod machines

# Ansible playbooks
Run following commands on dev node (CWD as /vagrant/github.com/caihua-yin/cicd/ansible/):
- `ansible-playbook yinc2-cloud.yml -i inventory/prod`: Deploy consul, registrator, nginx, and apps(store, fibonacci) to all of three prod nodes.

## To be refined
- `ansible-playbook influxdb.yml -i inventory/prod`
- `ansible-playbook statsd.yml -i inventory/prod`
- `ansible-playbook grafana.yml -i inventory/prod`
- `ansible-playbook statsd-influxdb-grafana.yml -i inventory/prod`: Deploy statsd-influxdb-grafana to prod02.
    - Visit http://192.168.33.22:8083 for influxdb admin portal
    - Visit http://192.168.33.22:3000 for grafana GUI
    - Run `while true; do echo "api:$(($RANDOM%100))|ms" | nc -u -w0 127.0.0.1 8125; sleep 1; done` at prod02 to send fictional API latency metric to statsd.
    - Create an example dashboard with two graphs, each with query as `SELECT value FROM "api.timer.mean_90"` `select value from "statsd.influxdbStats.http_response_time"`
    - Refer to http://mtons.com/content/1342.htm and https://hub.docker.com/r/samuelebistoletti/docker-statsd-influxdb-grafana/ for details

## Alternatives:
- `ansible-playbook etcd-registrator-confd.yml -i inventory/prod`: Deploy etcd, registrator (with etcd protocol) and confd to all of the three prod nodes. An alternative solution for service registery and discovery, equivalent to consul+registrator+consul-template.
    - For confd, only *onetime* mode is supported currently, need run `confd -onetime -backend etcd -node 192.168.33.21:2379`
- `ansible-playbook haproxy.yml -i inventory/prod`: Deploy haproxy to all of three prod nodes. An alternative solution for nginx.

# Test
Use following commands to send request to specific app:
- Fibonacci: `curl http://localhost:8888/fibonacci/5`
- Store:
    - `curl -XPOST http://localhost:8001/store/items -H "Content-Type: application/json" -d '{"brand":"apple", "name":"iPhone7", "description":"The latest iphone"}'`
    - `curl http://localhost:8001/store/items/d9494812-6154-4ac6-9177-5e6ee3eb648b`

To use proxy, replace port as follows:
- nginx: 80
- haproxy: 8000

# TODO
- ansible/roles/consul-template/tasks/main.yml
- use random port for store and fibonacci
