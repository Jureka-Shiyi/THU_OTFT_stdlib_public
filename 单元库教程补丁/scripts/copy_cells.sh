#!/bin/bash

# 设置路径
BASE_DIR="/data/zhengyj/cadence"
SRC_LIB="OTFT_stdlib_cells"
DST_LIB="OTFT_stdlib_cells_4INT"

cd $BASE_DIR

echo "Starting copy process..."

# 遍历源库中的所有 Cell 文件夹
for cell in $(ls $SRC_LIB); do
    # 检查源 Cell 文件夹内是否存在 schematic 或 symbol
    if [ -d "$SRC_LIB/$cell/schematic" ] || [ -d "$SRC_LIB/$cell/symbol" ]; then
        echo "Processing Cell: $cell"
        
        # 如果目标 Cell 文件夹不存在，则创建它
        mkdir -p "$DST_LIB/$cell"
        
        # 复制 schematic (如果存在)
        if [ -d "$SRC_LIB/$cell/schematic" ]; then
            cp -rf "$SRC_LIB/$cell/schematic" "$DST_LIB/$cell/"
        fi
        
        # 复制 symbol (如果存在)
        if [ -d "$SRC_LIB/$cell/symbol" ]; then
            cp -rf "$SRC_LIB/$cell/symbol" "$DST_LIB/$cell/"
        fi
    fi
done

echo "--- Copy Task Completed ---"