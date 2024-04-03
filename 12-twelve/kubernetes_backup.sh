
#!/bin/bash

# Устанавливаем путь для сохранения бэкапов
BACKUP_DIR="/var/backups/kubernetes"

# Создаем директорию для бэкапов, если она не существует
mkdir -p $BACKUP_DIR

# Получаем текущую дату для имени файла бэкапа
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Создаем бэкап etcd кластера
ETCDCTL_API=3 etcdctl snapshot save $BACKUP_DIR/etcd-snapshot-$CURRENT_DATE.db     --endpoints=https://127.0.0.1:2379     --cacert=/etc/kubernetes/pki/etcd/ca.crt     --cert=/etc/kubernetes/pki/etcd/server.crt     --key=/etc/kubernetes/pki/etcd/server.key

# Архивируем конфигурации Kubernetes
tar -czvf $BACKUP_DIR/kubernetes-configs-$CURRENT_DATE.tar.gz /etc/kubernetes/

# Выводим сообщение об успешном создании бэкапа
echo "Backup completed successfully. Files saved in $BACKUP_DIR"
