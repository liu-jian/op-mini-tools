#!/bin/bash
#公共函数

#日志输出函数
notice() {
    message=$1
    echo -e "`date '+%Y-%m-%d %H:%M:%S'` $message"
}

info() {
    message=$1
    echo -e "`date '+%Y-%m-%d %H:%M:%S'` $message"
}

warn() {
    message=$1
    echo -e "\033[33m`date '+%Y-%m-%d %H:%M:%S'` $message\033[0m" >&2
}

error() {
    message=$1
    echo -e "\033[31m`date '+%Y-%m-%d %H:%M:%S'` $message\033[0m" >&2
}

#如果没有就创建文件
c_file() {
    if [ ! -f "$1" ];then
        touch "$1"
    fi
}


#删除hdfs文件函数,输入参数:$1 天数,$2 hdfs 路径
delete_hdfs_file() {
    d_day="$1"
    d_path="$2"
    hadoop fs -ls "$d_path" | awk -v n1="$d_day" 'BEGIN{ n_days_ago=strftime("%F", systime()-n1*24*3600) }{if($6<n_days_ago){printf "%s\n", $8} }' | xargs -I {} hadoop fs -rm -r -skipTrash  {}
}
