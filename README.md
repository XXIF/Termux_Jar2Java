# Jar2Java-Termux
✨ Termux 平台交互式 JAR 一键反编译工具
自动配置Java环境 | 权限智能检测 | 时间戳自动归档 | 彩色炫酷终端界面

## 📌 项目简介
本项目基于 Android Termux 终端运行，一键完成环境部署、JAR 文件反编译、源码自动导出归档。
无需复杂手动配置，交互式输入路径即可使用，每次反编译自动生成带时间戳文件夹，避免文件覆盖丢失。

## 🎨 界面特色
- 彩色分级状态提示，运行进度清晰可见
- 艺术字开场动画，终端视觉效果精致
- 自动检测存储权限、运行依赖
- 异常错误醒目提醒，方便排查问题
- 自动时间戳归档分类管理源码

## 🧰 运行环境要求
1. Android 手机，安装最新版 Termux
2. 设备正常网络连接
3. 待反编译 J2ME / Java JAR 格式文件

## 🚀 快速使用教程
### 1. 拉取环境安装脚本
打开 Termux 终端，执行下方命令下载安装脚本
```bash
#国内推荐
#curl无需额外安装
curl -s https://github.dpik.top/https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/install.sh | bash
```

```bash
wget -qO- https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/install.sh | bash

curl -s https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/install.sh | sh

wget -qO- https://github.dpik.top/https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/install.sh | bash

curl -s https://github.dpik.top/https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/install.sh | bash
```
