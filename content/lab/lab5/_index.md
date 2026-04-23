---
title: 实验五：性能优化
weight: 50
---

{{< callout type="warning">}}
尚未正式发布，内容可能调整，仅供参考。
{{< /callout >}}


## 实验简介

本次实验围绕程序性能优化展开，包含两个任务。你需要在保证功能正确的前提下，提升程序的运行效率。

## 实验目的

在实验5-1中，你将实现一个高效的 MoE Top-k 路由模拟器，初步掌握算法层面的优化方法。

在实验5-2中，你将优化一个 C 语言实现的图像卷积函数，理解缓存局部性、分支预测与循环开销对性能的影响。

## 实验内容

{{< cards >}}
	{{< card link="./lab5-1" title="题目一：MoE Top-k 路由模拟器" subtitle="实现高效的 Top-k 选择与负载统计" >}}
	{{< card link="./lab5-2" title="题目二：卷积性能优化" subtitle="理解缓存局部性、分支预测与循环优化" >}}
	{{< card link="./perf" title="程序性能优化方法" subtitle="实验中的常见优化思路与示例" >}}
	{{< card link="./requirement" title="实验要求与检查" subtitle="提交方式与验收说明" >}}
{{< /cards >}}