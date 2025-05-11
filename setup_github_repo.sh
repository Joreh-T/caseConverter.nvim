#!/bin/bash

# 替换为您的 GitHub 用户名
GITHUB_USERNAME="your-username"
# 替换为您的仓库名称
REPO_NAME="case-converter"

# 初始化 Git 仓库
git init

# 添加所有文件
git add .

# 提交初始化
git commit -m "Initial commit"

# 创建 GitHub 仓库（需要安装 GitHub CLI）
# 如果没有安装 GitHub CLI，可以手动在 GitHub 网站上创建仓库
# 然后使用下面的命令添加远程仓库
# gh repo create $GITHUB_USERNAME/$REPO_NAME --public

# 添加远程仓库
git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git

# 推送到 GitHub
git push -u origin main

echo "仓库已初始化并推送到 GitHub: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
