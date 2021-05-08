serverSerialInfo=$(/sbin/prtdiag -v | awk '/Chassis Serial/{getline; getline; print}')
ilomIPAddress=$(sudo /sbin/ipmitool lan print | grep -w 'IP Address' | awk -F':' '{print $2}' | awk '{getline; print}')
firmwareVersion=$(/sbin/prtdiag -v | awk '/ FW Version / {getline; getline; getline; print}')
ServerVersion=$(/sbin/prtdiag -v | grep "System Configuration" | awk -F':' '{print $2}')
diskInfo=$(/sbin/zpool list -o name,size | awk '{if(NR>1)print}')
totalCpuCores=$(kstat cpu_info|grep core_id|sort -u|wc -l)
cpuSocket=$(/sbin/psrinfo -p)
cpuCoresPerSocket=$(($totalCpuCores / $cpuSocket))
threadPerCore=$(($cpuCoresPerSocket / 2))
memoryInfo=$(/sbin/prtconf | grep Memory | awk -F':' '{print $2}')
host=$(hostname) 
ipAddress=$(ping -s $host 57 1 | awk '{getline; print}' | head -n1 | awk -F" " '{print $5}')
#CpuInfo 
#Sockets:  $cpuSocket  CoresPerSocket:  $cpuCoresPerSocket  ThreadsPerCore:  $threadPerCore

echo $serverSerialInfo, $firmwareVersion, $ServerVersion, $memoryInfo, Sockets:  $cpuSocket  CoresPerSocket:  $cpuCoresPerSocket  ThreadsPerCore:  $threadPerCore, $diskInfo, $ilomIPAddress, $ipAddress