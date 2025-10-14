#!/bin/bash

# 股票网页快速部署脚本
# 支持 GitHub Pages, Vercel, Netlify 等平台

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE} 股票网页部署脚本${NC}"
    echo -e "${BLUE}================================${NC}"
}

# 检查依赖
check_dependencies() {
    print_message "检查部署依赖..."
    
    # 检查 Git
    if ! command -v git &> /dev/null; then
        print_error "Git 未安装，请先安装 Git"
        exit 1
    fi
    
    # 检查 Node.js (可选)
    if ! command -v node &> /dev/null; then
        print_warning "Node.js 未安装，某些功能可能不可用"
    fi
    
    print_message "依赖检查完成"
}

# 准备部署文件
prepare_deployment() {
    print_message "准备部署文件..."
    
    # 创建部署目录
    mkdir -p deploy
    
    # 复制必要文件
    cp index.html deploy/index.html
    
    # 复制配置文件
    cp vercel.json deploy/ 2>/dev/null || true
    cp netlify.toml deploy/ 2>/dev/null || true
    cp _config.yml deploy/ 2>/dev/null || true
    
    # 创建 README
    cat > deploy/README.md << EOF
# 股票实时行情

实时股票行情显示应用，支持关注列表、搜索功能。

## 功能特性

- 📈 实时股票行情显示
- 📋 关注列表管理
- 🔍 股票搜索功能
- 📱 响应式设计
- 💾 本地数据存储
- 🔗 分享功能

## 使用方法

1. 打开 \`index.html\` 查看主页面
2. 点击屏幕显示控制按钮
3. 使用搜索功能添加股票
4. 管理关注列表

## 部署

此项目已配置支持多种部署平台：

- GitHub Pages
- Vercel
- Netlify
- 自建服务器

## 技术栈

- HTML5
- CSS3 (Tailwind CSS)
- JavaScript (ES6+)
- LocalStorage API
- Web APIs

## 许可证

MIT License
EOF
    
    print_message "部署文件准备完成"
}

# GitHub Pages 部署
deploy_github_pages() {
    print_message "开始 GitHub Pages 部署..."
    
    # 检查是否在 Git 仓库中
    if [ ! -d ".git" ]; then
        print_message "初始化 Git 仓库..."
        git init
        git add .
        git commit -m "Initial commit"
    fi
    
    # 添加远程仓库 (需要用户手动设置)
    print_warning "请确保已设置 GitHub 远程仓库："
    print_warning "git remote add origin https://github.com/your-username/your-repo.git"
    
    # 推送到 GitHub
    git add .
    git commit -m "Deploy to GitHub Pages" || true
    git push origin main || git push origin master || true
    
    print_message "GitHub Pages 部署完成"
    print_message "请在 GitHub 仓库设置中启用 Pages 功能"
}

# Vercel 部署
deploy_vercel() {
    print_message "开始 Vercel 部署..."
    
    # 检查 Vercel CLI
    if ! command -v vercel &> /dev/null; then
        print_message "安装 Vercel CLI..."
        npm install -g vercel
    fi
    
    # 部署到 Vercel
    cd deploy
    vercel --prod
    
    print_message "Vercel 部署完成"
}

# Netlify 部署
deploy_netlify() {
    print_message "开始 Netlify 部署..."
    
    # 检查 Netlify CLI
    if ! command -v netlify &> /dev/null; then
        print_message "安装 Netlify CLI..."
        npm install -g netlify-cli
    fi
    
    # 部署到 Netlify
    cd deploy
    netlify deploy --prod --dir .
    
    print_message "Netlify 部署完成"
}

# 自建服务器部署
deploy_self_hosted() {
    print_message "准备自建服务器部署文件..."
    
    # 创建服务器配置文件
    cat > deploy/nginx.conf << EOF
server {
    listen 80;
    server_name your-domain.com;
    root /var/www/stock-ticker;
    index index.html;
    
    # 安全头
    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options DENY;
    add_header X-XSS-Protection "1; mode=block";
    add_header Referrer-Policy "strict-origin-when-cross-origin";
    
    # 缓存设置
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
    
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF
    
    # 创建 Dockerfile
    cat > deploy/Dockerfile << EOF
FROM nginx:alpine

COPY . /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
EOF
    
    # 创建 docker-compose.yml
    cat > deploy/docker-compose.yml << EOF
version: '3.8'

services:
  stock-ticker:
    build: .
    ports:
      - "80:80"
    restart: unless-stopped
EOF
    
    print_message "自建服务器部署文件已创建"
    print_message "使用以下命令部署："
    print_message "cd deploy && docker-compose up -d"
}

# 显示部署选项
show_deployment_options() {
    echo -e "${BLUE}请选择部署平台：${NC}"
    echo "1) GitHub Pages (免费，推荐)"
    echo "2) Vercel (免费，功能丰富)"
    echo "3) Netlify (免费，CDN加速)"
    echo "4) 自建服务器 (完全控制)"
    echo "5) 全部准备 (不部署)"
    echo "6) 退出"
}

# 主函数
main() {
    print_header
    
    # 检查依赖
    check_dependencies
    
    # 准备部署文件
    prepare_deployment
    
    # 显示选项
    while true; do
        show_deployment_options
        read -p "请输入选择 (1-6): " choice
        
        case $choice in
            1)
                deploy_github_pages
                break
                ;;
            2)
                deploy_vercel
                break
                ;;
            3)
                deploy_netlify
                break
                ;;
            4)
                deploy_self_hosted
                break
                ;;
            5)
                print_message "部署文件已准备完成，位于 deploy/ 目录"
                print_message "您可以手动部署到任何平台"
                break
                ;;
            6)
                print_message "退出部署脚本"
                exit 0
                ;;
            *)
                print_error "无效选择，请重新输入"
                ;;
        esac
    done
    
    print_message "部署完成！"
    print_message "部署文件位于: $(pwd)/deploy/"
}

# 运行主函数
main "$@"
