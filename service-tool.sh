#!/bin/bash

set -e

filepath=$(cd "$(dirname "$0")"; pwd)

# 用户设置
APP_NAME=$2


# 使用说明
usage() {
	echo "usage: service-tool.sh start|stop|restart"
}


# 启动
start() {
	echo start $APP_NAME
	startup
	echo $APP_NAME started
}

# 启动
startup() {	
	nohup java -jar "${filepath}/${APP_NAME}.jar" --spring.profiles.active=test > "./${APP_NAME}.log" 2>&1 &
}


# 停止
stop() {
	PID=$(ps -ef | grep $APP_NAME.jar | grep -v grep | awk '{ print $2 }')
	if [ -z "$PID" ]
	then
	    echo $APP_NAME is already stopped
	else
	    echo kill $PID
	    kill -9  $PID
	fi
}


# 重新启动
restart() {
	echo stopping $APP_NAME
	stop
	echo $APP_NAME stopped
	echo start $APP_NAME
	startup
	echo $APP_NAME started
}


## 下面是主流程

if [ $# -ne 2 ]
then
	usage
	exit 0
fi


case $1 in
	'start')
		start
	;;
	'stop')
		stop
	;;
	'restart')
		restart
	;;
	*)
		usage
	;;
esac



# tail -f ./nohup.out
