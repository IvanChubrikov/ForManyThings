Проект создает отказоустойчивый кластер для web сервиса на wordpress, включает в себя 
кластерную БД postgresql, сервер для сбора метрик Prometheus, сервер для сбора логов Opensearch, Logstash для настройки фильтров для логов для opensearch, прокси для обеспечения отказоустойчивости Haproxy
Виртуальные машины разворачиваются на virtiualbox с помощью vagrant скрипта, используется образ ubuntu-16 т.к в ней имеется графический интерфейс и она не сильно затратна по ресурсам и также доступна в библиотеке образов vagrant
Для запуска vagrant:
vargant init
vagrant up
Для запуска ansible плейбуков:
ansible-playbook -i roles/{rolename}/inventory/hosts deploy.yml
