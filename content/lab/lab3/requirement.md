---
title: 实验要求与检查
weight: 100
---

> [!CAUTION]
> **暂未最终确定**：此版本仅作为参考进行预习，尚未正式发布。

从本次实验开始，我们不再通过 BB 平台提交压缩包，而是采用 [希冀平台](https://cscourse.ustc.edu.cn/) 进行评测与管理。

## 1. 实验项目要求

本次实验包含三个编程项目，你需要为每个项目建立独立的目录文件夹，并确保以下要求：

1. **工程结构**：保持多文件实现。每个项目应包含 `include/`（头文件）、`src/`（源文件）和 `tests/`（测试代码，可选）目录。

{{< details title="结构示例" closed="true" >}}
```bash
.
├── CMakeLists.txt
├── include
│   ├── contact.h
│   └── phonebook.h
├── phonebook
├── src
│   ├── contact.c
│   ├── main.c
│   └── phonebook.c
└── tests #测试代码，可选
   ├── sample1.in
   ├── sample1.out
   ├── sample2.in
   ├── sample2.out
   ├── sample3.in
   └── sample3.out
```
{{< /details >}}


2. **构建系统**：每个项目根目录下必须包含一个 `CMakeLists.txt`，用于自动化编译。
3. **版本控制**：使用 Git 管理你的代码，并在开发过程中保持良好的提交习惯。

## 2. 提交方式 (GitLab + 希冀)

你需要在学校内部的 GitLab 平台上托管代码，并在希冀平台上提交仓库地址进行自动评测。

### 核心步骤：
1. **登录 GitLab**：访问希冀平台，通过“学生登录”后点击“进入 GitLab”。
   - **账号/密码**：均为你的**学号**。
   - **注意**：必须在希冀关联的 GitLab 上创建仓库，否则评测机无法抓取代码。
2. **创建仓库**：创建一个**私有**仓库。
3. **上传代码**：使用 `git` 命令将本地代码推送到 GitLab 仓库。
4. **提交评测**：在希冀平台对应作业处，提交你的 GitLab 仓库 HTTP 地址。

{{< callout type="important" >}}
似乎希冀平台的 GitLab 禁用了 SSH，只允许 HTTPS。
{{< /callout >}}


{{< callout type="warning" >}}
测评机器是按名称识别，cmake 产生的可执行文件名称必须为 `word_cleaner` `score_filter` `phonebook`。
{{< /callout >}}
