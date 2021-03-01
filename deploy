sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo


sudo yum install -y docker-ce docker-ce-cli containerd.io

systemctl enable docker

systemctl start docker 

# copy redis.conf
mkdir /root/docker/redis

docker run --name redis -v /root/docker/redis:/usr/local/etc/redis/redis.conf -d -p 6379:6379 -v /root/docker/redis/data:/data redis redis-server /usr/local/etc/redis/redis.conf

mkdir /root/docker/pgsl

yum install -y /root/service/jdk-11.0.10_linux-x64_bin.rpm

docker run -d \
	--name postgres \
	-e POSTGRES_PASSWORD=postgres \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-v /root/docker/psql/data:/var/lib/postgresql/data \
    -p 5432:5432 
	postgres



