#!/bin/bash

# 可否一次性定义inventory
INVENTORY=./inventory

# 初次创建数据目录
# 确认数据目录的权限？
# 如果执行过command，如何自动跳过
# 同步执行指令
# ansible -i $INVENTORY gpdb-master -m file -a "dest=/disk1/gpdata/gpmaster mode=777 state=directory"
# ansible -i $INVENTORY gpdb-segment -m file -a "dest=/disk2/greenplum/primary mode=777 state=directory" -f 5 -b
# ansible -i $INVENTORY gpdb-segment -m file -a "dest=/disk2/greenplum/mirror mode=777 state=directory" -f 5 -b
# ansible -i $INVENTORY gpdb-segment -m file -a "dest=/disk3/greenplum/primary mode=777 state=directory" -f 5 -b
# ansible -i $INVENTORY gpdb-segment -m file -a "dest=/disk3/greenplum/mirror mode=777 state=directory" -f 5 -b

# 初始化Swarm
# sudo docker swarm init --advertise-addr 10.190.5.110
# ansible -i $INVENTORY gpdb-master -m command -a "docker info" -b

# docker swarm join --token SWMTKN-1-44xebmqerko0v8y3mxlaz00xc6supwol8ub4sbs9kvtl1k2rv3-1o9ohpmzpmapl5atgi069w017 10.190.5.110:2377
# ansible -i $INVENTORY gpdb-segment -m command -a "docker info" -b

# 初始化网络
# record=`docker network ls | awk '($2=="gpdb"){print $1}' | wc -l`
# if [ $record -gt 0 ]; then
#     docker network rm gpdb
# fi
# ansible -i $INVENTORY gpdb-master -m command -a "docker info" -b
# docker network create --driver overlay gpdb
# ansible -i $INVENTORY gpdb-master -m command -a "docker info" -b

# 传出配置文件
ansible -i $INVENTORY gpdb-master -m copy -a "src='deploy/' dest='/opt/greenplum'" -b
ansible -i $INVENTORY gpdb-segment -m copy -a "src='deploy/config' dest='/opt/greenplum'" -b

# 执行启动命令
ansible -i $INVENTORY gpdb-master -m command -a "/opt/greenplum/start.sh" -b