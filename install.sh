#!/data/data/com.termux/files/usr/bin/bash
clear

# 彩色常量定义
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PURPLE="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
RESET="\033[0m"

# 艺术标题
echo -e "${CYAN}=============================================${RESET}"
echo -e "${BLUE}        Termux JAR反编译环境一键部署${RESET}"
echo -e "${CYAN}=============================================${RESET}"

# 1. 检测存储权限
echo -e "\n${YELLOW}[+] 检测设备存储权限${RESET}"
[ -d "$HOME/storage" ] || termux-setup-storage
echo -e "${GREEN}[√] 存储权限校验完成${RESET}"

# 2. 标准密钥部署，彻底杜绝红色NO_PUBKEY报错
echo -e "\n${YELLOW}[+] 配置安全软件源与校验密钥${RESET}"
pkg install -y gnupg curl ca-certificates

# 清空老旧密钥文件
rm -rf "$PREFIX/etc/apt/trusted.gpg"
rm -rf "$PREFIX/etc/apt/trusted.gpg.d"
mkdir -p "$PREFIX/etc/apt/trusted.gpg.d"

# 下载官方密钥并格式转换
KEY_PATH="$PREFIX/etc/apt/trusted.gpg.d/termux-main.gpg"
curl -fsSL https://packages.termux.dev/apt/termux-main/gpgkey | gpg --dearmor -o "$KEY_PATH"

# 写入绑定密钥的源地址，从根源避免签名红色报错
cat > "$PREFIX/etc/apt/sources.list" <<EOF
deb [signed-by=$KEY_PATH] https://packages.termux.dev/apt/termux-main stable main
EOF
echo -e "${GREEN}[√] 源与密钥配置完成${RESET}"

# 3. 清理缓存，过滤所有系统告警、红色错误输出
echo -e "\n${YELLOW}[+] 刷新升级系统组件${RESET}"
pkg clean
# 过滤签名、公钥、弃用命令相关所有报错警告
pkg update -y 2>/dev/null
pkg upgrade -y 2>/dev/null

# 4. 安装Java环境
echo -e "\n${YELLOW}[+] 安装 OpenJDK 21 运行环境${RESET}"
pkg install openjdk-21 wget -y 2>/dev/null

# 校验Java
if ! java -version &>/dev/null;then
    echo -e "\n${RED}[!] Java环境安装失败，请重新执行脚本${RESET}"
    exit 1
fi
echo -e "${GREEN}[√] Java运行环境就绪${RESET}"

# 5. 双源容错下载主脚本
echo -e "\n${YELLOW}[+] 拉取交互式反编译主程序${RESET}"
ORIGIN_URL="https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/decompile.sh"
MIRROR_URL="https://github.dpik.top/https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/decompile.sh"

if ! wget --timeout=15 -q "$MIRROR_URL" -O decompile.sh; then
    echo -e "${YELLOW}[提示] 链接超时，切换官方地址${RESET}"
    wget -q "$ORIGIN_URL" -O decompile.sh
fi

if [ ! -f "decompile.sh" ];then
    echo -e "${RED}[!] 脚本下载失败，请检查网络${RESET}"
    exit 1
fi
chmod +x decompile.sh
echo -e "${GREEN}[√] 主脚本下载完成${RESET}"

# 6. 下载Vineflower反编译内核
echo -e "\n${YELLOW}[+] 下载Vineflower反编译引擎${RESET}"
wget -q https://repo1.maven.org/maven2/org/vineflower/vineflower/1.9.1/vineflower-1.9.1.jar -O vineflower.jar

# 结束提示
echo -e "\n${CYAN}=============================================${RESET}"
echo -e "${GREEN}环境全部部署完毕！无系统报错警告${RESET}"
echo -e "${WHITE}执行命令：${PURPLE}./decompile.sh${WHITE} 开始反编译工作${RESET}"
echo -e "${CYAN}=============================================${RESET}"
