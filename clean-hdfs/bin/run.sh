#!/bin/bash
#进入当前程序执行路径，避免不同路径执行导致的问题
run_pwd="$(cd "$(dirname "$0")" && pwd)"
cd $run_pwd/../

#读取公共函数脚本
. ./bin/utils.sh

#创建日志文件，每天一个日志文件
run_date=`date '+%Y-%m-%d'`
log="./log/""$run_date"".log"
c_file $log

#根据配置删除相应文件
. ./etc/vars.sh
vars=`cat ./etc/vars.sh | grep -v ^# | awk -F "=" '{print $1}'`

for i in $vars; do
    var=`eval echo '$'"$i"`
    var_arr=($var)
    info "Start clean ""${var_arr[1]}"","" files ""${var_arr[0]} ""days ago." >> "$log"
    delete_hdfs_file ${var_arr[0]} ${var_arr[1]} >> "$log"
done
