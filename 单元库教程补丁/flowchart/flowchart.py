import os
import sys
from graphviz import Digraph

# 1. 配置 Graphviz 可执行文件路径（Windows 必须）
os.environ["PATH"] += os.pathsep + r"C:\Program Files\Graphviz\bin"

# 2. 指定输出目录
OUTPUT_DIR = r"C:\THU\课题组\数字电路设计全流程\THU_OTFT_stdlib_public\单元库教程补丁\flowchart"

def create_otft_flow():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    # 初始化流程图
    dot = Digraph(
        'OTFT_Flow',
        comment='OTFT Digital Circuit Design Flow',
        directory=OUTPUT_DIR
    )

    # ========== 核心优化：接近正方形+放大文字+清理乱码 ==========
    # 1. 接近正方形布局（宽14、高13，接近正方形）
    dot.attr(
        rankdir='TB', 
        compound='true',
        size='14,13',       # 宽高接近的尺寸，实现正方形效果
        ratio='fill',       # 内容填充整个尺寸
        dpi='300',          # 高分辨率保持清晰
        ranksep='0.8',      # 缩小层级间距，避免纵向拉伸
        nodesep='0.7'       # 缩小同层节点间距，让布局更紧凑
    )
    # 2. 放大文字+优化节点尺寸
    dot.attr(
        'node',
        shape='box',
        style='rounded,filled',
        fontname='Microsoft YaHei',  # 确保中文/符号正常显示（无乱码）
        fontsize='14',               # 文字放大（原10→14）
        width='4.0',                 # 加宽节点适配大文字
        height='1.2',                # 调整节点高度
        fixedsize='false'
    )

    # 1. 单元库准备阶段（清理乱码，仅保留正常文字）
    with dot.subgraph(name='cluster_Library_Prep') as c:
        c.attr(label='单元库准备阶段', color='lightgrey', style='dashed')
        c.node('A', '设计规格定义\n(OTFT电路功能/性能/工艺约束)', fillcolor='#ff99ff')
        c.node('B', 'OTFT单元库开发')
        c.node('B1', 'OTFT器件特性表征')
        c.node('B2', '单元库时序/功耗表征\n工具: Siliconsmart')
        c.node('B3', '单元库格式编译\n工具: Library Compiler')
        c.node('B4', '提取单元库LEF文件\n工具: Abstract Generator')
        c.edge('A', 'B')
        c.edge('B', 'B1')
        c.edge('B1', 'B2')
        c.edge('B2', 'B3')
        c.edge('B3', 'B4')

    # 2. 逻辑设计阶段（清理乱码）
    with dot.subgraph(name='cluster_Logic_Design') as c:
        c.attr(label='逻辑设计阶段', color='lightgrey', style='dashed')
        c.node('C', 'RTL设计\n(Verilog硬件描述语言编写)')
        c.node('D', '逻辑综合\n(映射至OTFT单元库)\n工具: Design Compiler')
        c.edge('C', 'D')

    # 3. 后端物理设计阶段（清理乱码）
    with dot.subgraph(name='cluster_Physical') as c:
        c.attr(label='后端物理设计阶段', color='lightgrey', style='dashed')
        c.node('E1', '布局规划/Floorplan\n工具: Innovus')
        c.node('E2', '单元布局/Placement\n工具: Innovus')
        c.node('E3', '时钟树综合/CTS\n工具: Innovus')
        c.node('E4', '布线/Routing\n工具: Innovus')
        c.edge('E1', 'E2')
        c.edge('E2', 'E3')
        c.edge('E3', 'E4')

    # 4. 验证与交付（清理乱码）
    with dot.subgraph(name='cluster_Verification') as c:
        c.attr(label='验证与交付', color='lightgrey', style='dashed')
        c.node('F', '物理验证\n(DRC/LVS/ERC检查)\n工具: Calibre')
        c.node('G', 'OTFT数字电路流片与测试', fillcolor='#00ff00')
        c.edge('F', 'G')

    # 子图连接
    dot.edge('B4', 'C')
    dot.edge('D', 'E1')
    dot.edge('E4', 'F')

    # 渲染（高分辨率PNG+无乱码）
    output_path = dot.render(
        filename='otft_design_flow',
        format='png',
        cleanup=True
    )

    print(f"流程图已生成：{output_path}")
    if sys.platform.startswith("win"):
        os.startfile(output_path)
    else:
        print("非 Windows 系统，请手动打开图片。")

if __name__ == "__main__":
    create_otft_flow()