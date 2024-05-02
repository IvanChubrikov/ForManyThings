Project creates one YC LB, 2 nginx proxy server, 2 nginx+php-fpm+wordpress backends, pxc cluster+proxysql(3 servers) and Hashicorp Vault server.
Для инициализации vault operator init на хосте vault
Далее сохранить ключи, полученные при инициализации
С которыми можно зайти на vault хост 
ivan@ubuntu:~$ vault operator init
Recovery Key 1: aXz2G0U/NTZmN4GVsbJKQ5BtKZw3XJnlOFc4v9sb3eP+
Recovery Key 2: b4rL2pXTFRnv3qG4WtQsFTf4mJ3VQ2QpT2+v9A2nJcL+
Recovery Key 3: V0mP5YOufGJBFr8qNxX2jD2Ft2p3Xr0bWxG5pCvO0tA8
Recovery Key 4: Y3Jn1Kt/TzRfQJsJOlP2Bx5uMKhcR1QZ4J6lL9Xm1Pq+
Recovery Key 5: Q8m9VByT8g6K1P6oFt2dZjRv9pZbW4DnFr1dJtCx2cF+

Initial Root Token: hvs.YNkP1zJMcXb5DtJYPm7RwLnK

Success! Vault is initialized

