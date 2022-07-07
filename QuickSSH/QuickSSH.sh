#!/bin/bash

#在Linux上快速执行很多服务器的SSH连接 非密钥版

params=("[0]:自定义连接" "[1]:你的服务器一" "[2]:你的服务器二" "[3]:读取自定义连接文件")

for param in ${params[@]}
do
    echo $param
done

read -p "请输入要连接的服务器序号(0-3): " serverId 

case $serverId in
0)
    read -p "请输入要连接的SSH服务器名字: " sshServerName
    read -p "请输入要连接的SSH服务器IP: " sshIP
    read -p "请输入要连接的SSH服务器端口: " sshPort
    read -p "请输入要连接的SSH服务器用户名: " sshUser
    if [ -z "$(grep $sshServerName ServerList.ssh)" ]; then
        cat>>ServerList.ssh<<EOF
{ 服务器[$sshServerName],IP[$sshIP],端口[$sshPort],用户名[$sshUser] }
EOF
    fi
    echo "连接到" $sshServerName "请输入密码(第一次连接先输入yes): "
    ssh $sshIP -p $sshPort -l $sshUser
    ;;
1)
    echo "连接到" ${params[$serverId-1]} "请输入密码(第一次连接先输入yes): "
    ssh 127.0.0.1 -p 22 -l root
    ;;
2)
    echo "连接到" ${params[$serverId-1]} "请输入密码(第一次连接先输入yes): "
    ssh 127.0.0.1 -p 22 -l root
    ;;
3)
    cat ServerList.ssh
    ;;
*)
    echo "输入有误!"
    ;;
esac

echo "退出SSH连接。"