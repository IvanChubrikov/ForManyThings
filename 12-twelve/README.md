После создания хостов с помощью terraform запускается k8s-setup.yaml
скрипт для бекапа вынесен отдельно kubernetes_backup.sh скрипт создает бэкап данных etcd и архивирует конфигурационные файлы Kubernetes. По умолчанию, бэкапы сохраняются в /var/backups/kubernetes
Перед использованием должно быть установлено:
etcdctl
Права на выполнение с помощью команды chmod +x
Пути к сертификатам в скрипте соответствуют окружению