---
title: 题目三：动态通讯录
weight: 33
--- 

## 截止日期

2026年4月10日（三周）

## 题目背景

请你实现一个简单的动态通讯录。通讯录中的每条记录包含姓名和电话号码，姓名不重复。系统需要支持新增、修改、删除、查找和整体输出。

## 题目描述

给定若干条操作，请按照要求维护通讯录：

- `add name phone`
  若 `name` 不存在，则加入一条新记录；若已存在，则忽略该操作。
- `update name phone`
  若 `name` 存在，则把电话号码修改为 `phone`；若不存在，则忽略该操作。
- `delete name`
  若 `name` 存在，则删除该记录；若不存在，则忽略该操作。
- `find name`
  输出该联系人的电话号码；若不存在，则输出 `NOT FOUND`。
- `print`
  按当前存储顺序输出所有联系人，格式为 `name:phone`，相邻记录之间用一个空格分隔；若通讯录为空，则输出 `EMPTY`。
- `stop`
  终止程序

## 输入格式

每行是一条操作，格式如题目描述所示。

## 输出格式

对于每一条 `find` 操作和每一条 `print` 操作，各输出一行结果。

## 数据范围

- 至少一个操作
- 保证同时有效的联系人数量不超过 `16`
- `name` 长度不超过 `31`，至少为 `1`，且只包含小写英文字母
- `phone` 长度不超过 `31`，至少为 `1`，且只包含数字字符

## 样例 1

### 输入

```text
add alice 1350000
add bob 1391111
find alice
update bob 1888888
find bob
delete alice
find alice
print
stop
```

### 输出

```text
1350000
1888888
NOT FOUND
bob:1888888
```

## 样例 2

### 输入

```text
print
add tom 10086
add tom 12345
find tom
update jerry 777
add jerry 888
print
delete tom
find tom
print
stop
```

### 输出

```text
EMPTY
10086
tom:10086 jerry:888
NOT FOUND
jerry:888
```

## 样例 3

### 输入

```text
add ann 1
add ben 2
add cat 3
print
delete ben
print
update cat 9
find cat
delete ann
delete cat
print
stop
```

### 输出

```text
ann:1 ben:2 cat:3
ann:1 cat:3
9
EMPTY
```

## 提示

- 可以使用结构体 `Contact` 表示单个联系人。
- 可以使用动态数组存储联系人列表，并在容量不足时扩容。
- 删除联系人后，需要保持其余联系人顺序不变。
- `find` 和 `update` 前，可以先查找姓名是否存在。

## 实现要求

- 必须使用结构体保存联系人信息。
- 必须使用指针管理字符串内存。
- 建议使用二级指针或等价方式完成通讯录扩容，例如维护 `Contact **items`，当扩容后将原来 `items` 数组内容复制到新 `items` 内。
- 徐老师班
	- 建议至少拆分为联系人模块、通讯录模块、主程序三部分。
	- 工程需要能通过 `Makefile` 或 `CMakeLists.txt` 构建。
