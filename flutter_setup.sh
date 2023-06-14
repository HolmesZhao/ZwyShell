#!/bin/bash --login
# sh ./flutter_setop.sh (bash/zsh)

clear

if [ ! -d "fluttersdk/flutter/bin" ];then
    echo ""
    echo "还没有下载 fluttersdk"
    curl -o fluttersdk.zip http://drive.zwyxxd.press:5170/zwy/fluttersdk/flutter_macos_arm64_3.10.4-stable.zip
    if [ ! -f "fluttersdk.zip" ];then
        echo ""
        echo "下载 fluttersdk.zip 失败"
        exit 0
    else
        echo ""
        echo "下载 fluttersdk.zip 成功"
        
        unzip -d ./fluttersdk ./fluttersdk.zip
        
        if [ ! -d "fluttersdk" ];then
            echo ""
            echo "解压 fluttersdk.zip 失败"
        else
            echo ""
            echo "解压 fluttersdk.zip 成功"
            
            rm -f ./fluttersdk.zip
            
            echo ""
            echo "下面的环境变量需要写入 ~/.bashrc 或者 ./zshrc"
            echo "export PATH=\$PATH:$PWD/fluttersdk/flutter/bin"
            
            if [ $1 == "zsh" ]; then
                echo "export PATH=\$PATH:$PWD/fluttersdk/flutter/bin" >> ~/.zshrc
                source ~/.zshrc
                flutter --version
            fi
            if [ $1 == "bash" ]; then
                echo "export PATH=\$PATH:$PWD/fluttersdk/flutter/bin" >> ~/.bashrc
                source ~/.bashrc
                flutter --version
            fi
        fi
    fi
else
    echo ""
    echo "已经下载 fluttersdk:"
    echo ""
    flutter --version
fi


