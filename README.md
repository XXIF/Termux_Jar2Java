# Jar2Java-Termux
✨ Termux 平台交互式 JAR 一键反编译工具
自动配置Java环境 | 权限智能检测 | 时间戳自动归档 | 彩色炫酷终端界面

## 📌 项目简介
本项目基于 Android Termux 终端运行，依托**OpenJDK**运行环境与**Vineflower**反编译核心，一键完成环境部署、JAR 文件反编译、源码自动导出归档。

无需复杂手动配置，交互式输入文件路径即可启动操作；每次反编译成果单独生成带时间戳文件夹，有效避免文件覆盖、源码丢失，支持 J2ME、通用 Java 格式 JAR 包逆向解析。

## 🎨 界面特色
- 彩色分级状态提示，运行进度直观清晰
- 艺术字开场动画，终端视觉体验出色
- 自动检测存储权限、系统运行依赖
- 异常报错高亮提醒，便捷排查故障问题
- 时间戳自动归档，分类管理历次源码文件

## 🧰 核心依赖
- 运行环境：OpenJDK
- 反编译引擎：Vineflower.jar

## 🧰 运行环境要求
1. 安卓设备，安装最新版本 Termux
2. 设备网络状态正常，可正常拉取资源
3. 待处理文件：J2ME / Java 标准 JAR 格式文件

## 🚀 快速使用教程
### 1. 拉取环境安装脚本
打开 Termux 终端，按需选择对应命令执行，自动完成工具与环境部署
```bash
# 国内加速源（优先推荐）
curl -s https://github.dpik.top/https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/install.sh | bash
```

```bash
# GitHub官方源
curl -s https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/install.sh | bash
```

```bash
# wget 国内加速通道
wget -qO- https://github.dpik.top/https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/install.sh | bash
```

```bash
# wget 官方直连通道
wget -qO- https://raw.githubusercontent.com/XXIF/Termux_Jar2Java/main/install.sh | bash
```

### 2. 工具使用

环境部署完毕后，根据终端交互提示，输入本地JAR文件路径，即可一键执行反编译。

解析完成的Java源码，会自动保存至带时间戳的独立归档目录中。
 
## 📂 文件归档规则
- 每次反编译任务都会新建专属目录，文件夹命名附带年月日时分秒时间戳，多次操作文件相互隔离，便于后续查看、调取历史源码。
 
## ⚠️ 相关须知
1. 首次启动工具会自动下载 OpenJDK、Vineflower 相关依赖，等待加载完成即可
2. 务必为 Termux 授予设备存储权限，否则无法读取文件与导出源码
3. 本工具仅限个人学习研究代码结构使用，禁止用于侵权破解等违规行为
