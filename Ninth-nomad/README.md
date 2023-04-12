UI доступен по адресу http://<node-ip>:8200/ui/
старт номад сервер в dev режиме
nomad agent -dev
старт на каждой ноде 
nomad agent -dev -node=<nodename>
регистрируем джобу
nomad job run vault.nomad
проверяем статус
nomad job status vault-cluster
nomad job status -verbose vault-cluster
nomad job status -summary vault-cluster
nomad job status -allocations vault-cluster
чтение секрета 
vault read secret/my-secret
