---
title: 实验五：性能优化
weight: 50
draft: true
---

## 实验简介

本次实验围绕程序性能优化展开，包含图像卷积优化与 MoE Top-k 路由模拟两个任务。你需要在保证功能正确的前提下，结合循环优化、内存访问局部性和数据结构设计，提升程序的运行效率。

## 实验目的

理解常见的性能瓶颈来源，掌握面向热点代码的优化思路，并学会在 C 语言多文件工程中组织实现、测试与构建流程。

## 实验内容

{{< cards >}}
	{{< card link="./lab5-1" title="题目一：卷积性能优化" subtitle="理解缓存局部性、分支预测与循环优化" >}}
	{{< card link="./lab5-2" title="题目二：MoE Top-k 路由模拟器" subtitle="实现高效的 Top-k 选择与负载统计" >}}
	{{< card link="./perf" title="程序性能优化方法" subtitle="实验中的常见优化思路与示例" >}}
	{{< card link="./requirement" title="实验要求与检查" subtitle="提交方式与验收说明" >}}
{{< /cards >}}