---
title: 'lab5-2: MoE Top-k 路由模拟器'
weight: 53
draft: true
---

## 题目背景

在大语言模型（LLM）的推理系统中，**MoE（Mixture of Experts，混合专家）** 是一种常见结构。
对于每个 token，路由器（Router）会根据一组打分，选择得分最高的若干个 expert，让这些 expert 参与计算。

在真实 AI Infra 系统里，这一步虽然只是“选前 k 大”，却会被执行非常多次，因此 **实现是否高效** 会直接影响吞吐量（throughput）。

本题要求你使用 **C 语言** 实现一个简化版的 MoE Top-k 路由模拟器：
给定若干 token 对若干 expert 的打分矩阵，程序需要为每个 token 选出得分最高的 `k` 个 expert，并输出路由结果以及每个 expert 被选中的次数。


## 题目描述

给定：

- `T` 个 token
- `E` 个 expert
- 每个 token 对每个 expert 的一个整数分数 `score`
- 一个正整数 `k`

对于每个 token，需要从 `E` 个 expert 中选出 **得分最高的 `k` 个 expert**。

### 规则要求

1. 只允许选择 **不同的 expert**。
2. 若多个 expert 分数相同，则 **编号更小的 expert 优先**。
3. 输出时，每个 token 的结果按“优先级从高到低”排列：
   - 分数高的在前
   - 若分数相同，expert 编号小的在前
4. 统计所有 token 路由完成后，每个 expert 被选中的总次数。

### 你需要实现的核心功能

请完成下列函数：

- `Router* router_create(int num_experts, int top_k)`
- `void router_route(Router* router, const int* scores, int num_tokens, RouteResult* out)`
- `void router_destroy(Router* router)`

其中：

- `scores` 是一个大小为 `num_tokens * num_experts` 的连续一维数组，按行存储：
  - 第 `i` 个 token 对第 `j` 个 expert 的得分位于 `scores[i * num_experts + j]`
- `out->topk_indices[i * top_k + r]` 表示第 `i` 个 token 选出的第 `r` 个 expert 编号
- `out->topk_scores[i * top_k + r]` 表示对应得分
- `out->expert_load[j]` 表示编号为 `j` 的 expert 被选中的次数

> 为了方便理解，这里给出一个最小样例。
>
> ### 最简样例 (Minimal Example)
>
> **输入**
> ```text
> 3 4 2
> 8 1 5 7
> 2 9 9 1
> 6 6 3 6
> ```
>
> 含义：
> - `T = 3`
> - `E = 4`
> - `k = 2`
>
> 三个 token 的打分分别为：
> - token 0: `[8, 1, 5, 7]`
> - token 1: `[2, 9, 9, 1]`
> - token 2: `[6, 6, 3, 6]`
>
> **输出**
> ```text
> token 0: 0(8) 3(7)
> token 1: 1(9) 2(9)
> token 2: 0(6) 1(6)
> load: 2 2 1 1
> ```
>
> ### 样例说明 (Sample Walkthrough)
>
> 1. 对于 `token 0`，分数最高的两个 expert 是：
>    - expert 0，分数 8
>    - expert 3，分数 7
>
> 2. 对于 `token 1`，expert 1 和 expert 2 都是 9 分：
>    - 因为分数相同，编号更小的 expert 1 在前
>
> 3. 对于 `token 2`，expert 0、1、3 都是 6 分，但只取前 2 个：
>    - 根据“编号小优先”，选 expert 0 和 expert 1
>
> 4. 最终负载统计：
>    - expert 0 被选中 2 次
>    - expert 1 被选中 2 次
>    - expert 2 被选中 1 次
>    - expert 3 被选中 1 次

## 输入格式

输入共 `T + 1` 行：

1. 第一行输入三个正整数：`T`、`E`、`k`
2. 接下来 `T` 行，每行包含 `E` 个整数，表示一个 token 对所有 expert 的打分

## 输出格式

输出共 `T + 1` 行：

1. 前 `T` 行输出每个 token 的 Top-k 结果，格式为：

```text
 token i: expert_id(score) expert_id(score) ...
```

2. 最后一行输出每个 expert 的负载：

```text
load: c0 c1 c2 ... c(E-1)
```

## 数据范围

- `1 <= T <= 2000`
- `1 <= E <= 512`
- `1 <= k <= min(E, 8)`
- `score` 为有符号 32 位整数

## 时间限制

1 秒

## 内存限制

128 MB

## 样例 1

### 输入

```text
3 4 2
8 1 5 7
2 9 9 1
6 6 3 6
```

### 输出

```text
token 0: 0(8) 3(7)
token 1: 1(9) 2(9)
token 2: 0(6) 1(6)
load: 2 2 1 1
```

## 样例 2

### 输入

```text
2 5 3
1 2 3 4 5
10 9 8 7 6
```

### 输出

```text
token 0: 4(5) 3(4) 2(3)
token 1: 0(10) 1(9) 2(8)
load: 1 1 2 1 1
```

## 样例 3

### 输入

```text
2 6 2
5 5 5 5 5 5
-1 100 -1 100 -1 100
```

### 输出

```text
token 0: 0(5) 1(5)
token 1: 1(100) 3(100)
load: 1 2 0 1 0 0
```

## 提示

- 一个直接做法是：对每个 token 的 `E` 个分数全部排序，再取前 `k` 个。
- 但在本题中，`k` 很小，而 `E` 可能较大。完全排序会做很多没有必要的工作。
- 思考：能否只维护一个长度为 `k` 的“当前最优集合”，在扫描一行分数时不断更新？

## 实现要求

- **语言要求**：必须使用 **C 语言** 完成。
- **工程要求**：必须提供 `CMakeLists.txt`，可通过 `cmake` 构建。
- **多文件开发**：建议至少拆分为：
  - `main.c`：输入输出
  - `router.c`：核心逻辑
  - `router.h`：结构定义与函数声明
- **内存管理**：需要正确申请与释放堆内存，严禁内存泄漏。
- **禁止事项**：
  - 不要把本题写成“缓存”或“队列”题
  - 不允许使用 C++ STL
  - 不允许调用外部排序库

## 优化要求

本题除了“做对”，还要求“做得像样”。

### 基础要求

你的程序必须正确输出结果。

### 优化要求

你的实现需要体现出以下优化思想：

1. **不要对每个 token 做完整排序**
   - 当 `k` 很小时，完整排序 `E` 个元素通常不是最优做法。
   - 推荐做法：扫描一行时，只维护当前前 `k` 名。

2. **尽量复用内存**
   - 不要为每个 token 反复申请和释放临时数组。

3. **顺序访问连续内存**
   - `scores` 是按行连续存放的，尽量按顺序扫描。

4. **保持比较逻辑稳定**
   - 分数相同时要保证编号小的 expert 更优。

### 额外说明

在助教测试中，我们会准备一组较大的数据。若你对每行都做完整排序，程序可能虽然正确，但性能会比较吃力。

## 建议接口

你可以使用如下结构体：

```c
typedef struct {
    int expert_id;
    int score;
} ExpertScore;

typedef struct {
    int num_experts;
    int top_k;
} Router;

typedef struct {
    int* topk_indices;
    int* topk_scores;
    int* expert_load;
} RouteResult;
```

## 作业提交要求

请提交：

1. 源代码
2. `CMakeLists.txt`
3. 简短说明文档，说明你的优化思路

## 思考题

1. 如果 `k = 2` 或 `k = 4`，是否可以写出比“完整排序”更快的实现？
2. 如果未来 expert 数量很大，甚至达到几千个，当前实现还够用吗？
3. 在真实推理系统里，除了 Top-k 选择，还可能需要做哪些后处理？
