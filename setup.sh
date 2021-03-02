#/bin/sh

# install some tools
sudo yum install -y git vim wget gcc glibc-static telnet bridge-utils bind-utils unzip zip

# install docker
# curl -fsSL get.docker.com -o get-docker.sh
# sh get-docker.sh

# 太慢了，我改成了下面使用 daocloud 加速
#curl -fsSL https://get.daocloud.io/docker/ -o get-docker.sh
#sh get-docker.sh
# curl -sSL https://get.daocloud.io/docker | sh
#rm -rf get-docker.sh

# step 1: 安装必要的一些系统工具
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# Step 2: 添加软件源信息
sudo yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# Step 3: 更新并安装Docker-CE
sudo yum makecache fast
sudo yum -y install docker-ce
# Step 4: 开启Docker服务
#sudo service docker start

# start docker service
sudo groupadd docker
sudo usermod -aG docker vagrant
sudo systemctl start docker
sudo systemctl enable docker

# 配置镜像加速器
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://vfs1y0dl.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

# install docker compose
curl -L https://get.daocloud.io/docker/compose/releases/download/1.28.5/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose