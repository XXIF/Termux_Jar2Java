#!/data/data/com.termux/files/usr/bin/bash
clear

# 颜色定义
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PURPLE="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
RESET="\033[0m"

echo -e "${CYAN}=============================================${RESET}"
echo -e "${BLUE}         交互式JAR包源码提取工具${RESET}"
echo -e "${CYAN}=============================================${RESET}"

# 1. 权限检测
echo -e "\n${YELLOW}[检测] 验证外部存储访问权限${RESET}"
if [ ! -d "$HOME/storage" ];then
    echo -e "${RED}[提示] 暂无权限，正在发起授权${RESET}"
    termux-setup-storage
fi
echo -e "${GREEN}[√] 存储权限正常${RESET}"

# 2. 检测反编译工具
echo -e "\n${YELLOW}[检测] 核查反编译引擎文件${RESET}"
if [ ! -f "vineflower.jar" ];then
    echo -e "${RED}[缺失] 自动下载依赖引擎${RESET}"
    wget https://repo1.maven.org/maven2/org/vineflower/vineflower/1.9.1/vineflower-1.9.1.jar -O vineflower.jar
fi
echo -e "${GREEN}[√] 反编译引擎就绪${RESET}"

# 3. 校验Java环境
if ! java -version &>/dev/null;then
    echo -e "\n${RED}[错误] 未检测到Java环境，请先执行install.sh部署环境${RESET}"
    exit 1
fi

# 4. 录入文件路径 修复read语法报错
echo -e "\n${PURPLE}—————— 请输入待处理文件路径 ——————${RESET}"
read -p "JAR文件完整路径：" JAR_PATH

if [ ! -f "$JAR_PATH" ];then
    echo -e "\n${RED}[错误] 路径无效，未找到目标JAR文件${RESET}"
    exit 1
fi

# 5. 复制文件
echo -e "\n${YELLOW}[处理] 复制文件到工作目录${RESET}"
cp "$JAR_PATH" game.jar
echo -e "${GREEN}[√] 文件拷贝完成${RESET}"

# 6. 执行反编译
echo -e "\n${YELLOW}[运行] 正在解析编译字节码，请耐心等待...${RESET}"
rm -rf src_out
java -jar vineflower.jar game.jar src_out

if [ ! -d "src_out" ];then
    echo -e "\n${RED}[失败] 反编译流程异常，未生成源码${RESET}"
    exit 1
fi
echo -e "${GREEN}[√] 字节码解析完成${RESET}"

# 7. 自动生成时间戳目录
TIME_STAMP=$(date +%Y%m%d_%H%M%S)
BASE_EXPORT="/storage/emulated/0/\$_Jar2java"
FINAL_EXPORT="${BASE_EXPORT}/${TIME_STAMP}"

# 自动创建多级目录
mkdir -p "${FINAL_EXPORT}"

# 8. 归档导出
echo -e "\n${YELLOW}[归档] 源码自动归类保存${RESET}"
cp -r src_out "${FINAL_EXPORT}/"

# 收尾展示
echo -e "\n${CYAN}=============================================${RESET}"
echo -e "${GREEN}🎉 本次反编译任务圆满结束${RESET}"
echo -e "${WHITE}源码存放路径：${PURPLE}${FINAL_EXPORT}/src_out${RESET}"
echo -e "${CYAN}=============================================${RESET}"
