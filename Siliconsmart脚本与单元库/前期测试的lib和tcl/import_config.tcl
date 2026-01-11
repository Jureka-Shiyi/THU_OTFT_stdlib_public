# import_config.tcl
set netlist_dir "/data/zhengyj/OTFT_stdlib/my_library/netlists"
set extension ".pex.netlist"
set cells {
    INVD1 INVD2 INVD4 INVD8
    NAND2D1 NAND2D2 NAND2D4 NAND2D8
    NOR2D1 NOR2D2 NOR2D4 NOR2D8
}
set overwrite 1
set use_default_slews 1

# 执行导入，注意这里的参数名可能因版本而异，请根据帮助文档调整
import -cell_list $cells -netlist_dir $netlist_dir -ext $extension -overwrite -use_default_slews