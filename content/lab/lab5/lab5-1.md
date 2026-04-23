---
title: 'lab5-1: MoE Top-k 路由模拟器'
weight: 51
---

{{< callout type="warning">}}
尚未正式发布，内容可能调整，仅供参考。
{{< /callout >}}

## 实验框架
[点此下载](../lab5-1.zip)


## 题目背景

在大语言模型（LLM）的推理系统中，**MoE（Mixture of Experts，混合专家）** 是一种常见结构。
对于每个 token，路由器（Router）会根据一组打分，选择得分最高的若干个 expert，让这些 expert 参与计算。

在真实 AI Infra 系统里，这一步虽然只是“选前 k 大”，却会被执行非常多次，因此 **实现是否高效** 会直接影响吞吐量。

本题要求你使用 **C 语言** 实现一个简化版的 MoE Top-k 路由模拟器：
给定若干 token 对若干 expert 的打分矩阵，程序需要为每个 token 选出得分最高的 `k` 个 expert，并输出路由结果以及每个 expert 被选中的次数。


## 题目描述

给定：

- `T` 个 token
- `E` 个 expert
- 每个 token 对每个 expert 的一个整数分数 `score`
- 一个正整数 `k`

对于每个 token，需要从 `E` 个 expert 中选出 **得分最高的 `k` 个 expert**。

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
>

编译：

```bash
cmake -S . -B build
cmake --build build
```

编译成功后，可执行文件位于 `build/moe_router`。

运行性能测试：

```bash
./build/moe_router --bench
```