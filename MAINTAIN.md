# 《系统程序设计基础》课程主页维护指南

本文档旨在帮助其他助教/老师快速上手课程主页的维护、更新与发布流程。

## 环境配置

本站基于 **Hugo** 构建，使用 [**Hextra** 主题](https://imfing.github.io/hextra/docs/)。

1.  [**安装 Hugo**](https://hugo.opendocs.io/getting-started/):
    -   请确保安装 **Extended** 版本（编译 CSS/JS 必需）。
    -   Windows 用户推荐使用 `choco install hugo-extended` 或从 [GitHub Releases](https://github.com/gohugoio/hugo/releases) 下载。
2.  **克隆仓库**:
    ```bash
    git clone --recursive git@github.com:USTC-ISP/ustc-isp-page.git
    cd ustc-isp-page
    ```
    *注意：必须使用 `--recursive` 确保主题子模块被正确拉取。*

## 内容更新

所有内容均存放于 `content/` 目录下：

-   **首页**: `content/_index.md`（包含课程动态和快捷入口）。
-   **实验指导**: `content/exp/` 每个实验一个子目录。
-   **理论讲义**: `content/lectures/_index.md` 用于更新每周 PDF 链接。
-   **图片素材**: 统一放入 `static/` 目录下（例如 `static/images/`），在 Markdown 中使用 `/images/xxx.png` 引用。

### 本地预览
在根目录下运行：
```bash
hugo server
```
访问 `http://localhost:1313` 进行实时预览。

## 一键部署

由于组织权限限制，我们采用本地编译并推送至 [ustc-isp.github.io](https://github.com/USTC-ISP/ustc-isp.github.io) 仓库。

1.  **准备阶段**: 确保你拥有 `ustc-isp.github.io` 的写权限，且本地已配置 SSH 密钥。
2.  **运行脚本** (Windows PowerShell):
    ```powershell
    .\deploy.ps1 "更新说明（如：发布实验二）"
    ```
    *脚本会自动完成：清理旧产物 -> 构建压缩版静态站 -> 推送至展示仓库的 main 分支。*

## 注意事项

1.  **图片链接**: 避免使用本地绝对路径，务必将图片放入 `static/` 后使用 Web 路径。
2.  **搜索功能**: 若本地遇到 `FlexSearch` 下载导致的 TLS 超时报错，可在 `hugo.toml` 中暂时将 `params.search.enable` 设为 `false`。
3.  **FrontMatter**: 每个 `.md` 文件顶部的 `title`, `date`, `weight` 决定了侧边栏的排序，请保持风格一致。

---
有任何问题请联系 主页搭建者 罗浩民。
