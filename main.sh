#!/bin/bash
# 要添加的 host 映射
IP_TO_ADD="132.145.125.18"
HOSTNAME="lobby-v2.klei.com"

# 备份 hosts 文件
cp /etc/hosts /etc/hosts.bak

# 检查 hosts 文件是否已经存在该记录
if grep -q "$HOSTNAME" /etc/hosts; then
    echo "hosts 文件中已存在 $HOSTNAME，更新为 $IP_TO_ADD"
    # 替换原有的 IP
    sed -i "s/.*$HOSTNAME/$IP_TO_ADD $HOSTNAME/" /etc/hosts
else
    echo "添加 $IP_TO_ADD $HOSTNAME 到 hosts 文件"
    echo "$IP_TO_ADD $HOSTNAME" | tee -a /etc/hosts
fi

echo "修改完成"

cd /workspace/dst-admin-go
nohup ./dst-admin-go > /dev/null &

# 打印进程信息
echo "查看当前运行的进程"
ps -axu

# 进入 bash shell
echo "似乎已经启动! 进入 bash shell"
bash
