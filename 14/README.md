playbook deploy ceph on two hosts (minimal configuration for test) 
vagrant init
vagrant up
ansible-playbook -i hosts.ini ceph-install.yml
uuidgen для ручной генерации fsid потом установить в ceph.conf

Логика расчета placement Groups (PG) для Pool'ов
В Ceph количество PG влияет на производительность и масштабируемость. Идеальное количество PG зависит от размера кластера и объема данных. Рекомендуемое количество PG можно оценить с помощью формулы, предложенной Ceph, или использовать рекомендации Ceph для начальной настройки.
Для расчета:
RBD: 5/10 объема дисков
CephFS: 3/10 объема дисков
Это означает, что необходимо выделить 50% доступного дискового пространства для RBD и 30% для CephFS. Основываясь на этих пропорциях вычислить общее количество PG, учитывая общую емкость хранилища и оптимальное количество OSD на PG.
Создание пулов:
ceph osd pool create rbd 128
ceph osd pool create cephfs_data 128
ceph osd pool create cephfs_metadata 32
128 и 32 — примерные значения PG, которые нужно будет адаптировать в зависимости от реальной конфигурации кластера

Создание и проброс RBD и CephFS на клиентские машины RBD:
ceph osd pool create rbd_pool 128 128
rbd create image1 --size 1024 --pool rbd_pool
rbd map image1 --pool rbd_pool --name client.admin
and for image2 и image3.

mount CephFS на клиентских машинах через ceph-fuse или kernel driver.
ceph fs new cephfs cephfs_metadata cephfs_data

Расширение и уменьшение кластера
Добавление 2+ OSD:
ceph orch daemon add osd <host>:/path/to/device
ceph osd reweight

Объяснение логики PG перерасчета:
При добавлении OSD — увеличение количества OSD может потребовать увеличения количества PG для оптимального распределения данных.
При удалении OSD — снижение числа OSD может потребовать уменьшения количества PG для поддержания эффективности без избыточного количества пустующих PG
