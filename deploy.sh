docker network create --driver bridge garden-backend-network
docker-compose -f ./docker-compose/docker-compose.yml up -d

: << EOF
show variables like '%connection_control%'; # 检查是否安装connection_control
# 已在my.cnf中声明安装。若无，且需要外网暴露pma，手动安装 mysql connection_control 插件

docker exec -it mysql /bin/bash

mysql -h 127.0.0.1 -P 3306 -u root -pmy_secret_password;
install plugin CONNECTION_CONTROL soname 'connection_control.so';
install plugin CONNECTION_CONTROL_FAILED_LOGIN_ATTEMPTS soname 'connection_control.so';
show variables like '%connection_control%'; # 检查是否安装成功
EOF