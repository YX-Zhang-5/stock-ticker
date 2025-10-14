# 📈 股票实时行情

一个现代化的股票行情显示应用，支持实时数据、关注列表和搜索功能。

## ✨ 功能特性

- 📊 **实时行情**：模拟实时股票价格更新
- 📋 **关注列表**：添加和管理关注的股票
- 🔍 **智能搜索**：快速搜索股票代码和名称
- 📱 **响应式设计**：完美适配手机和桌面
- 💾 **本地存储**：无需登录，数据保存在本地
- 🔗 **分享功能**：生成分享链接，与朋友分享关注列表

## 🚀 快速开始

1. 访问 [在线演示](https://your-username.github.io/stock-ticker)
2. 点击屏幕显示控制按钮
3. 使用搜索功能添加股票
4. 管理您的关注列表

## 🛠️ 技术栈

- **前端**：HTML5, CSS3, JavaScript (ES6+)
- **样式**：Tailwind CSS
- **存储**：LocalStorage, Cookie, URL参数
- **部署**：GitHub Pages, Vercel, Netlify

## 📱 使用方法

### 基本操作
1. **查看股票**：点击屏幕显示当前股票信息
2. **添加关注**：点击"☆ 关注"按钮添加到关注列表
3. **搜索股票**：点击"🔍 搜索"按钮搜索新股票
4. **管理列表**：点击"📋 列表"查看和管理关注列表

### 高级功能
1. **实时更新**：点击"📡 实时"开启/关闭实时数据
2. **导出数据**：在关注列表中点击"📤 导出"下载JSON文件
3. **导入数据**：点击"📥 导入"从JSON文件导入股票
4. **分享链接**：点击"🔗 分享"复制包含关注列表的链接

## 🔧 本地开发

```bash
# 克隆仓库
git clone https://github.com/your-username/stock-ticker.git

# 进入目录
cd stock-ticker

# 启动本地服务器
python3 -m http.server 8000

# 访问 http://localhost:8000
```

## 🚀 部署

### 自动部署
```bash
# 运行部署脚本
./deploy.sh

# 选择部署平台
# 1) GitHub Pages
# 2) Vercel
# 3) Netlify
# 4) 自建服务器
```

### 手动部署
1. **GitHub Pages**：上传到GitHub仓库，启用Pages功能
2. **Vercel**：连接GitHub仓库，一键部署
3. **Netlify**：拖拽文件到Netlify，自动部署

## 📄 文件说明

- `index.html` - 主页面（生产环境优化版本）
- `deploy.sh` - 自动化部署脚本
- `vercel.json` - Vercel部署配置
- `netlify.toml` - Netlify部署配置
- `_config.yml` - GitHub Pages配置
- `deployment-guide.md` - 详细部署文档

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📜 许可证

MIT License

## 📞 联系方式

- GitHub: [@your-username](https://github.com/your-username)
- Email: your-email@example.com
