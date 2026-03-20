---
title: GitLab 简明教程
weight: 35
---
## 1. 登录与初始化


1. 打开 [希冀平台 (cscourse.ustc.edu.cn)](https://cscourse.ustc.edu.cn/)并登录。
2. 在页面导航栏或课程主页找到 **“登录 GitLab”** 按钮。
3. **账号/密码**：账号和初始密码均为你的**学号**。

## 2. 配置 SSH 密钥

配置 SSH 密钥后，你可以免密码安全地推送代码，这也是 GitLab 推荐的访问方式。

### 第一步：生成密钥对
在你的 Linux/WSL/MacOS 终端运行以下命令（若已生成可跳过）：

```bash
ssh-keygen -t ed25519 -C "your_email@mail.ustc.edu.cn"
```
（一路回车即可，无需设置密码）

### 第二步：获取公钥
运行以下命令查看并复制生成的公钥内容（以 `.pub` 结尾）：

```bash
cat ~/.ssh/id_ed25519.pub
```

### 第三步：添加到 GitLab
1. 登录 GitLab 后，点击右上角头像 -> **Setting** (偏好设置)。
2. 在左侧菜单点击 **SSH Keys**。
3. 点击 **Add new key**，将复制的公钥粘贴到 **Key** 文本框中，**Title** 可随意填写（如 "My-PC"）。**Expires at**指密钥到期时间，留空或设置一个晚于本学期期末的时间。
4. 点击 **Add key** 保存。

---

## 3. 创建与同步仓库

### 3.1 在 Web 端创建项目
1. 点击左侧菜单的 **Projects** -> **Create a project**。
2. 选择 **blank project**。
3. **Project name**: 自己填。
4. **Visibility Level**: 设为 **Private** (私有)，防止他人抄袭。

### 3.2 关联本地代码
进入你的实验项目根目录（例如 `lab3/`），执行以下命令：

```bash
# 初始化仓库
git init

# 添加远程库地址 (请将 <URL> 替换为你刚创建的项目 SSH 地址)
git remote add origin <URL>

# 添加所有文件
git add .

# 首次提交
git commit -m "your_commit_message"

# 推送到远程分支
git push -u origin main
```
