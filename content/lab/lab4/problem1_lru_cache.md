---
title: LRU题目
weight: 43
# draft: true
---

## 问题描述

请你使用有头节点的链表,实现一个满足LRU(最近最少使用)缓存约束的数据结构及其基础功能.

要求链表除头节点之外的内部节点在任意操作进行前和完成后均按上一次被访问(包括get和put)的时刻排序,即缓存中上一次被访问的时刻最近的节点为头节点的后继,缓存中上一次被访问的时刻最远的节点为链表末尾的节点.

这个数据结构需要实现以下基础功能:

+ `LRUCache* LRUCache_create(unsigned int capacity)` 以非负整数作为容量capacity初始化LRU缓存,返回一个指向链表头节点的指针.

+ `unsigned int LRUCache_get(unsigned int key)` 如果关键字key存在于缓存中,则返回关键字key对应的值value,否则返回-1.

+ `void LRUCache_put(unsigned int key, unsigned int value)` 如果关键字key已经存在于缓存中,则变更其对应的值为新的value;如果不存在,则将这组key-value插入缓存中;若此次插入会导致缓存内key-value的数量超过容量capacity,则应删去缓存中最久未使用的key-value.

+ `void LRUCache_reverse(LRUCache* head)` 如果head指针非空,则逆序输出缓存中存储的key-value组,即最先输出缓存中上一次被访问的时刻最远的节点的key-value组,最后输出缓存中上一次被访问的时刻最近的节点的key-value组.

+ `void LRUCache_free(LRUCache* head)` 如果head指针非空,则释放LRU缓存,完成操作后原链表所使用的内存空间被完全释放.

另外,请你思考:如何设计函数`get()`和`put()`使其以O(1)的平均时间复杂度运行?你可以在本次实验中额外实现这一点,不作为强制要求.

> `capacity`,`key`,`value`均为`unsigned int`型

## 输入形式

输入第一行为LRU缓存容量`capacity`和等待执行的操作数`n`;

输入接下来`n`行为等待执行的操作,每一行第一部分为3个字符代表操作名称,接下来为操作对应的变量;

## 输出形式

输出根据不同的操作分为两种类型,`get`和`rev`,而`put`没有输出.

连续的`get`操作输出在同一行内;而当遇到`rev`操作时,先另起一行,然后每一行输出一个节点对应的`key-value`组(`key`和`value`用单个空格分隔),`rev`的最后一行输出末尾有换行符.

一个抽象的例子(暂时不考虑LRU缓存中的具体情况):

假设LRU缓存大小为2,去除put操作后的输入为:

```text
get 1

get 2

rev

get 3

get 4

rev
```

对应的输出形如:

```text
g_1 g_2

r_k1 r_v1

r_k2 r_v2

g_3 g_4

r_k3 r_v3

r_k4 r_v4
```

## 样例输入

```text
2 10
put 1 1
put 2 2
get 1
put 3 3
get 2
put 4 4
get 1
get 3
get 4
rev
```

## 样例输出

```text
1 -1 -1 3 4
3 3
4 4
```

## 样例说明

按照样例输入的操作序列：
1. `put 1 1`, `put 2 2`：缓存变为 `[2:2, 1:1]`（`2` 是最近访问的）。
2. `get 1`：命中 `1`，输出 `1`，将其移至头部，缓存变为 `[1:1, 2:2]`。
3. `put 3 3`：容量为 2，此时已满。淘汰最久未访问的 `2`，插入 `3`，缓存变为 `[3:3, 1:1]`。
4. `get 2`：未命中，输出 `-1`。
5. `put 4 4`：淘汰最久未访问的 `1`，插入 `4`，缓存变为 `[4:4, 3:3]`。
6. 接下来的 `get 1`, `get 3`, `get 4` 分别输出 `-1`, `3`, `4`。
7. `rev`：从最久未访问到最近访问输出，即先输出 `3 3`，再输出 `4 4`。

{{< callout type="info" >}}
请特别注意各变量以及指针的边界检查.
{{< /callout >}}

## 评分标准

暂定4组测试样例,每组25分.
