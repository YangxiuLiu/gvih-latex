#!/bin/bash
# ============================================
#  GVIH 论文一键编译脚本
#  用法: bash start.sh

# 修改部分：用户文件名============================================
# 默认主文件为 main.tex，所以默认 FILENAME 为 main
# 如果要编译其他的文件，需要要修改为其他的名称，请修改下方的 FILENAME 变量值
FILENAME="main"

# 下方为固定部分,无需修改============================================
cd "$(dirname "$0")"

echo "=========================================="
echo "GVIH 论文编译脚本"
echo "文件: ${FILENAME}.tex"
echo "=========================================="

echo "1. 清理旧文件..."
rm -f ${FILENAME}.aux ${FILENAME}.bbl ${FILENAME}.blg ${FILENAME}.log \
      ${FILENAME}.out ${FILENAME}.pdf ${FILENAME}.bcf ${FILENAME}.run.xml \
      ${FILENAME}.synctex.gz

echo "2. 运行 XeLaTeX (生成正文)..."
xelatex -interaction=nonstopmode ${FILENAME}.tex > /dev/null

echo "3. 运行 biber (读取参考文献)..."
biber ${FILENAME} > /dev/null

echo "4. 运行 XeLaTeX (导入参考文献列表)..."
xelatex -interaction=nonstopmode ${FILENAME}.tex > /dev/null

echo "5. 运行 XeLaTeX (导入参考文献引用格式)..."
xelatex -interaction=nonstopmode ${FILENAME}.tex > /dev/null

echo "=========================================="
echo "✅ 编译成功！"
echo "📄 PDF 位置: $(pwd)/${FILENAME}.pdf"
echo "=========================================="
