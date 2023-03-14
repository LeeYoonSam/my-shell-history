#!/bin/bash

# 현재시간
NOW=$(date +"%Y-%m-%d %H:%M:%S")

# 시스템 정보 출력
echo "System information at $NOW:"
echo '------------------------------'
uname -a
echo '------------------------------'
echo

# CPU 사용량 출력
echo "CPU usage at $NOW:"
echo '------------------------------'
ps -e -o pid,command,%cpu,time | sort -nrk 3 | head
echo '------------------------------'
echo

# 메모리 사용량 출력
echo "Memory usage at $NOW:"
echo '------------------------------'
# free -m #맥에서는 기본으로 설치되어 있지 않음
vm_stat | awk '{ if ($1 == "Pages") { if ($2 == "wired") wired = $3; else if ($2 == "active") active = $3; else if ($2 == "inactive") inactive = $3; else if ($2 == "speculative") speculative = $3; else if ($2 == "throttled") throttled = $3; else if ($2 == "file") file = $3; else if ($2 == "compressor") compressor = $3; else if ($2 == "compressor\|decompressor") compressed = $3; } } END { print "Wired Memory:\t\t" wired * 4096 / 1048576 " MB"; print "Active Memory:\t\t" active * 4096 / 1048576 " MB"; print "Inactive Memory:\t" inactive * 4096 / 1048576 " MB"; print "Speculative Memory:\t" speculative * 4096 / 1048576 " MB"; print "Throttled Memory:\t" throttled * 4096 / 1048576 " MB"; print "File-backed Memory:\t" file * 4096 / 1048576 " MB"; print "Compressed Memory:\t" compressed * 4096 / 1048576 " MB"; }'
echo '------------------------------'
echo

# 디스크 사용량 출력
echo "Disk usage at $NOW:"
echo '------------------------------'
df -h
echo '------------------------------'