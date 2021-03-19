# 指定 locale
echo "export LC_ALL=en_US.UTF-8"  >>  /etc/profile
source /etc/profile

# 替换 aliyun 镜像源   可选
mv -f /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
cd /etc/yum.repos.d/
curl -o CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache
yum -y update

# 定义用户名 
export NEW_USER=rancher 
export PASSWD=rancher
# 添加用户(可选) 
sudo adduser $NEW_USER
# 为新用户设置密码 
echo $PASSWD | passwd --stdin $NEW_USER
# 为新用户添加sudo权限 
echo "$NEW_USER ALL=(ALL) ALL" >> /etc/sudoers
# 安装 docker
sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  docker-ce \
                  docker-ce-cli \
                  containerd.io

sudo yum install -y yum-utils device-mapper-persistent-data \     lvm2 bash-completion

sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

sudo yum makecache fast

sudo yum update -y && sudo yum install -y \
  containerd.io-1.2.13 \
  docker-ce-19.03.11 \
  docker-ce-cli-19.03.11

# 配置阿里镜像

sudo mkdir -p /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "registry-mirrors": ["https://registry.cn-hangzhou.aliyuncs.com"]
}
EOF

sudo usermod -aG docker $NEW_USER
# 启动 docker
systemctl start docker
# 配置开机启动
systemctl enable docker

