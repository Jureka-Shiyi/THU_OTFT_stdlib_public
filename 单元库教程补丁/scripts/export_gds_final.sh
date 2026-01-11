#!/bin/bash

# --- 参数设置 ---
LIB_NAME="OTFT_stdlib_cells_4INT"
OUT_DIR="/data/zhengyj/cadence/OTFT_stdlib_lib_gds"
LAYER_MAP="/data/zhengyj/cadence/PDK_OTFT_4INT/OTFT_4INT_with_pins_layers.map"
BASE_DIR="/data/zhengyj/cadence"

# 1. 创建输出目录
mkdir -p $OUT_DIR

cd $BASE_DIR

echo "--- 开始批量导出 GDS ---"
echo "使用 LayerMap: $LAYER_MAP"

# 2. 遍历库中所有包含 layout 视图的 Cell
for cell in $(ls $LIB_NAME); do
    if [ -d "$LIB_NAME/$cell/layout" ]; then
        echo "正在导出 Cell: $cell ..."
        
        # 3. 调用 strmout 命令
        strmout \
            -library $LIB_NAME \
            -topCell $cell \
            -view layout \
            -strmFile $OUT_DIR/$cell.gds \
            -layerMap $LAYER_MAP \
            -logFile /tmp/strm_out_$cell.log \
            -case preserve \
            -runDir $OUT_DIR
            
        if [ $? -eq 0 ]; then
            echo " [成功] $cell"
        else
            echo " [失败] $cell (查看日志: /tmp/strm_out_$cell.log)"
        fi
    fi
done

echo "--- 导出任务全部完成 ---"
echo "保存路径: $OUT_DIR"