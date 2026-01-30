#!/bin/bash
set -e

# 颜色输出函数
red() { echo -e "\033[31m$1\033[0m"; }
green() { echo -e "\033[32m$1\033[0m"; }
yellow() { echo -e "\033[33m$1\033[0m"; }

# 检查Docker是否安装
check_docker() {
  如果! 命令-vdocker &> /dev/null;则
红色“未安装Docker，请先安装Docker：https://docs.docker.com/get-docker/”
 1
  fi
  如果! 命令-vdocker-compose &> /dev/null;则
红"Docker Compose未安装，请先安装：https://docs.docker.com/compose/install/"
    exit 1
  fi
绿色“✅ Docker环境检测通过”
}

# 检查端口占用
检查端口() {
  ports=(8000 5432 6379 8001)
  for port in "${ports[@]}"; do
    if lsof -i:$port -t >/dev/null; then
黄色“⚠️ 端口已被占用，建议关闭占用进程后重试”
      read -p "是否继续？(y/n) " -n 1 -r
      echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
      fi
    fi
  done
绿色“✅ 端口检测通过”
}

# 初始化模型目录
init_model_dir() {
  如果 [ ! -d "./models" ]; 则
    mkdir -p ./models
黄色“⚠️ 模型目录已创建，请将DeepSeek/Qwen模型文件放入./models目录”
读取-p “已准备好模型文件？(y/n) ” -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      exit 1
    fi
  fi
绿色"✅ 模型目录检测通过"
}

# 启动服务
start_service() {
绿色“启动OpenDomain AI服务...”
  docker-compose up -d
绿色“✅ 服务启动成功！”
绿色“后端接口地址：http://localhost:8000/docs”
绿色“Chroma向量库地址：http://localhost:8001”
}

# 停止服务
stop_service() {
绿色“停止OpenDomain AI服务...”
  docker-compose down
绿色“✅ 服务停止成功！”
}

# 主流程
案例"$1" 在
开始)
检查Docker
检查端口
初始化模型目录
启动服务
    ;;
停止)
停止服务
    ;;
重启)
停止服务
检查Docker
检查端口
启动服务
    ;;
  *)
回显“使用说明：”
    echo "  ./deploy.sh start   - 启动服务"
    echo "  ./deploy.sh stop    - 停止服务"
    echo "  ./deploy.sh restart - 重启服务"
    exit 1
    ;;
esac
