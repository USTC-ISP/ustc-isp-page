---
title: 实验要求与检查
weight: 100
---

## 1. 实验项目

本次实验要求你完成一个简单的 C 项目，作用是读取并计算一个整数的阶乘。

最终需包含以下文件结构：

```text
Lab2_Project/
├── .git/               # 执行 git init 后生成
├── .gitignore         # 过滤编译产物
├── PB25XXXXXXX-张三.pdf  # 实验报告（PDF格式）
├── Makefile           # 任务一产物
├── CMakeLists.txt     # 任务二产物
├── include/
│   └── math_utils.h   # 函数声明
├── src/
│   ├── math_utils.c   # 函数实现
│   └── main.c         # 程序入口
└── build/             # 任务二构建目录（不进入 Git）

```

按照以下代码逻辑进行编写：

* **`include/math_utils.h`**: 声明一个函数 `int factorial(int n);`（计算阶乘）。
* **`src/math_utils.c`**: 实现 `factorial` 函数（建议使用递归或循环）。
* **`src/main.c`**: 在 `main` 函数中读取用户输入，调用 `factorial` 并输出结果。

---

## 2. 实验任务

### 任务一：版本管理 (Git & Gitee)

1. **本地管理**：使用 `git init` 初始化，配置好 `.gitignore`。
2. **记录足迹**：开发过程中至少进行 **3 次以上** 提交。
3. **云端备份**：在 [Gitee](https://gitee.com/) 创建公开仓库，将本地代码 `push` 到云端。

### 任务二：手动构建 (Make)

在根目录下编写一个 `Makefile`，要求实现 `make`（生成可执行文件）和 `make clean`（清除 `.o` 和生成的程序）。

### 任务三：现代构建 (CMake)

在根目录下编写 `CMakeLists.txt`，要求：

1. 使用 `target_include_directories` 指定头文件路径。
2. 使用 **外部构建 (Out-of-source Build)** 流程，在 `build/` 文件夹内生成 Makefile 并编译。

## 3. 提交物与验收标准

实验报告需包含以下截图：
 
1. **Make 编译图**：展示执行 `make` 生成程序以及执行 `make clean` 清理产物的过程。
2. **CMake 编译图**：展示在 `build/` 目录下执行 `cmake ..` 和 `make` 的过程。
3. **Git 历史图**：执行 `git log --oneline --graph --all`，展示你不少于 3 次的**提交记录**。
4. **Gitee 主页图**：展示你的云端仓库页面，确认代码已同步。

提交包含以上目录结构的压缩包（如 `PB25XXXXXXX-张三.zip`）到BB平台。