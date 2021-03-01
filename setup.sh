#/bin/sh

# install some tools
sudo yum install -y git vim wget gcc glibc-static telnet bridge-utils bind-utils

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

# install python3
sudo yum install -y openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel gcc gcc-c++  openssl-devel libffi-devel python-devel mariadb-devel
sudo wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
sudo tar -zxvf Python-3.9.2.tgz -C /tmp
cd /tmp/Python-3.9.2/
sudo ./configure --prefix=/usr/local
# sudo yum -y install gcc gcc-c++ automake autoconf libtool make
sudo make
sudo make altinstall
sudo ln -s /usr/local/bin/python3.9 /usr/bin/python3
sudo ln -s /usr/local/bin/pip3.9 /usr/bin/pip3

# install golang
# export GOROOT=/home/vagrant/go
# export GOPATH=/home/vagrant/Code/go
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
cd ~
sudo wget https://studygolang.com/dl/golang/go1.16.linux-amd64.tar.gz
sudo tar -xvf go1.16.linux-amd64.tar.gz
sudo echo GOROOT=/home/vagrant/go >> ~/.bashrc
sudo echo GOPATH=/home/vagrant/Code/go >> ~/.bashrc
sudo echo 'PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.bashrc
source ~/.bashrc

go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct


