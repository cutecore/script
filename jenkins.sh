pwd 
df -lh
cd /opt/iot/
./service-tool.sh stop devicemanager-0.0.1-SNAPSHOT
rm -f de*.log
df -lh


#任务结束后不杀死脚本内启动的程序
BUILD_ID=DONTKILLME

# 没有逗号
serviceArr=(cameramanager-0.0.1-SNAPSHOT
 facerecognition-0.0.1-SNAPSHOT
 devicemanager-0.0.1-SNAPSHOT
 filemanager-0.0.1-SNAPSHOT
 gateway1-0.0.1-SNAPSHOT
 usermanager-0.0.1-SNAPSHOT
 alarmmanager-0.0.1-SNAPSHOT)

cd /opt/iot/
for service in ${serviceArr[@]}
do
./service-tool.sh stop ${service}
done

cd /var/lib/jenkins/workspace/gitee-test/back-end/IotRoot/

pathArr=(gateway1 cameramanager facerecognition devicemanager filemanager usermanager)

for path in ${pathArr[@]}
do
cd ${path}
mvn package
mv -f ./target/*.jar /opt/iot
cd ..
done

cd /opt/iot
for service in ${serviceArr[@]}
do
./service-tool.sh start ${service}
done
