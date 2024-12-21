
#!/bin/bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=90

cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*//" | awk '{print 100 - $1}')
if [ $(echo "$cpu_usage > $CPU_THRESHOLD" | bc) -eq 1 ]; then
    echo "Warning: CPU usage is above $CPU_THRESHOLD%. Current usage: $cpu_usage%"
fi

memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if [ $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc) -eq 1 ]; then
    echo "Warning: Memory usage is above $MEMORY_THRESHOLD%. Current usage: $memory_usage%"
fi

disk_usage=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
if [ $disk_usage -gt $DISK_THRESHOLD ]; then
    echo "Warning: Disk usage is above $DISK_THRESHOLD%. Current usage: $disk_usage%"
fi
