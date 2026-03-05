# 一键部署脚本：将 Hugo 产物部署到 GitHub Pages 仓库
# 运行方式: .\deploy.ps1 "Commit message"

$commitMsg = if ($args[0]) { $args[0] } else { "Update site content" }
$targetRepo = "git@github.com:USTC-ISP/ustc-isp.github.io.git"
$publicDir = "public"

Write-Host "--- 1. 清理并生成静态文件 ---" -ForegroundColor Cyan
if (Test-Path $publicDir) { Remove-Item -Recurse -Force $publicDir }
hugo --minify

if ($LASTEXITCODE -ne 0) {
    Write-Host "Hugo 构建失败，请检查配置。" -ForegroundColor Red
    exit
}

Write-Host "--- 2. 初始化/更新部署目录 ---" -ForegroundColor Cyan
cd $publicDir

# 初始化 Git (如果尚未初始化)
if (-not (Test-Path ".git")) {
    git init
    git remote add origin $targetRepo
    git checkout -b main
}

# 提交并推送
git add .
git commit -m $commitMsg
Write-Host "--- 3. 推送至目标仓库: $targetRepo ---" -ForegroundColor Cyan
git push -u origin main --force

cd ..
Write-Host "--- 部署成功！ ---" -ForegroundColor Green
