#!/bin/bash --login
readonly PWD=$ZWY_DIR_DSYM
# 所有的dSYM存放的目录
readonly FILE_DIR="${PWD}/temp"
# Java包存放地址
readonly JAR_PATH="${PWD}/buglyqq-upload-symbol.jar"
# 平台
readonly PLATFORM="IOS"
# bugly信息
ALL_APP=(
    "0,喵喵机,b0911dc069,b670f65a-0202-49b4-a99e-e718ea82c435,com.paperang.paperang"
    "1,喵喵错题,5cbf11b936,945e2324-1b2f-41a4-bc07-5474e9242368,com.paperang.study"
    "2,喵喵机国际版,34734ca812,57dede32-101f-4d5e-99c5-6247e71df178,com.paperang.international"
    )

# 打印红色的文本内容 出现异常时打印
function echo_warning()
{
    if [[ ${#1} > 0 ]]; then
        echo "!!! - warning: ${1} - !!!"
    fi
}

# 打印绿色的文本内容 正常流程会使用这个打印
function echo_success()
{
    if [[ ${#1} > 0 ]]; then
        echo "~~ ${1} ~~"
    fi
}
# 标识文件是否存在
IS_Exists=false
function file_exists()
{
    if [ -e $1 ]; then
        IS_Exists=true
    else
        IS_Exists=false
    fi
}

# 每次使用后必须置空 防止出错
INPUT_NUMBER=
# 必须输入数字才能继续后面的流程
function circle_input()
{
    if [[ ${#1} == 0 ]]; then
        echo "circle_input func未传入参数"
        exit
    fi

    while [[ ! "$INPUT_NUMBER" =~ [0-9] ]];do
    read -p "${1}" INPUT_NUMBER
    done
}

function log_line()
{
    echo "========"
}

# 脚本所在目录
SCRIPT_PATH=$(pwd)

function log_select()
{
  echo "请选择上传项目"
  APP_COUNT=${#ALL_APP[*]}
  for (( i = 0; i < APP_COUNT; i++ )); do
      string=${ALL_APP[$i]}
      array=(${string//,/ })
      echo "${array[0]}->${array[1]}"
  done
}

ALL_DSYM_FILES=
FILE_COUNT=0
function searchFile()
{
    ALL_DSYM_FILES=`find ${FILE_DIR} -name "*.dSYM"`
    for i in $ALL_DSYM_FILES
    do
    echo ${i}
    FILE_COUNT=`expr ${FILE_COUNT} + 1`
    done
    
    echo "dSYM文件总共${FILE_COUNT}个"
}

function main {
    # 判断文件是否存在 不存在直接退出
    file_exists $JAR_PATH
    if [[ $IS_Exists == false ]]; then
        echo_warning "${JAR_PATH} 文件未找到"
        exit
    fi
    
    # 判断文件夹是否存在 不存在直接退出
    file_exists $FILE_DIR
    if [[ $IS_Exists == false ]]; then
        echo_warning "${FILE_DIR} 文件未找到"
        mkdir ${FILE_DIR}
        echo_success "创建了${FILE_DIR}"
    fi
    
    log_select
    log_line
    circle_input "请输入编号: "

    string=${ALL_APP[$INPUT_NUMBER]}
    target=(${string//,/ })
    INPUT_NUMBER=

    read -p "输入版本号: " parameter
    NEW_VERSION="$parameter"
    parameter=

    log_line

    searchFile

    if [[ ${FILE_COUNT} == 0 ]]; then
      echo_warning "dSYM文件为 0, 请将文件放入 ${FILE_DIR}"
      open ${FILE_DIR}
      exit
    fi

    appName=${target[1]}
    appid=${target[2]}
    appkey=${target[3]}
    bundleid=${target[4]}

    for i in $ALL_DSYM_FILES
    do
    java -jar ${JAR_PATH} -appid ${appid} -appkey ${appkey} -bundleid ${bundleid} -version ${NEW_VERSION} -platform ${PLATFORM} -inputSymbol ${i}
    done

    echo_success "恭喜, ${appName}的dSYM上传成功, 版本号为${NEW_VERSION}, 总共${FILE_COUNT}个!!!"

    rm -rf ${FILE_DIR}

    mkdir ${FILE_DIR}
}

main
