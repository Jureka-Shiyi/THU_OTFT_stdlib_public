# ============================================================
# SiliconSmart run.tcl for OTFT standard cell characterization
# ============================================================
# ctrl + / = 快捷注释
set lib_root "/data/zhengyj/OTFT_stdlib"
set library_name "my_library"
set lib_dir "${lib_root}/${library_name}"
set lib_name "OTFT_stdlib_DFF"
set config_name "configure_DFF"

# ------------------------------------------------------------
# Clean existing library (使用 Linux rm -rf)
# ------------------------------------------------------------
if {[file exists $lib_dir]} {
    puts "Deleting existing library: $lib_dir"
    # 使用 exec 调用系统 rm 命令，效率更高且处理权限问题更稳健
    catch { exec rm -rf $lib_dir }
    exec rm -rf $lib_dir
}

# ------------------------------------------------------------
# Create library (SiliconSmart 内置命令)
# ------------------------------------------------------------
create $library_name

# ------------------------------------------------------------
# Prepare directory structure (使用 Linux mkdir -p)
# ------------------------------------------------------------

# exec if {![file exists "${lib_dir}/config"]} {
#     file mkdir "${lib_dir}/config"
# }
# exec mkdir -p "${lib_dir}/netlists"
# exec mkdir -p "${lib_dir}/models"
# 使用 -force 选项，即使中间目录不存在也会一并创建，类似于 mkdir -p
# if {![file exists "${lib_dir}/config"]} {
#     puts "创建目录（包括可能的父目录）: ${lib_dir}/config"
#     file mkdir -force "${lib_dir}/config"
# }

# ------------------------------------------------------------
# Copy configuration and netlists (使用 Linux cp)
# ------------------------------------------------------------
# 拷贝单个配置文件      exec cp -f "${lib_root}/tcl/siliconsmart/configure.tcl" "${lib_dir}/config/configure.tcl"

exec cp -f "${lib_root}/tcl/siliconsmart/${config_name}.tcl" "${lib_dir}/config/configure.tcl"

exec cp -rf "${lib_root}/subckts_cdl/." "${lib_dir}/netlists/"

# ------------------------------------------------------------
# Set working location
# ------------------------------------------------------------
set_location $library_name

# ------------------------------------------------------------
# Import reference liberty and netlists
# ------------------------------------------------------------
# import -liberty /data/zhengyj/OTFT_stdlib/lib_template/OTFT_stdlib_ref13.lib -netlist_dir my_library/netlists -ext .cdl -overwrite -use_default_slews
# import -liberty /data/zhengyj/OTFT_stdlib/lib_template/OTFT_stdlib_ref13_slow_ns.lib -netlist_dir my_library/netlists -ext .cdl -overwrite -use_default_slews
# import -liberty /data/zhengyj/OTFT_stdlib/lib_template/OTFT_stdlib_ref13_us.lib -netlist_dir my_library/netlists -ext .cdl -overwrite -use_default_slews

import -liberty ${lib_root}/lib_template/${lib_name}.lib -netlist_dir my_library/netlists -ext .cdl -overwrite -use_default_slews

# import \
#     -liberty "${lib_root}/lib_template/${lib_name}.lib" \
#     -netlist_dir "${lib_dir}/netlists" \
#     -ext .cdl \
#     -overwrite \
#     -use_default_slews

# ------------------------------------------------------------
# Configure characterization    如果不叫configure.tcl，需要指定配置文件  configure -file "${lib_root}/${library_name}/config/1.tcl" -timing -power all
# ------------------------------------------------------------
configure -timing -power all

# ------------------------------------------------------------
# Run characterization
# ------------------------------------------------------------
characterize all

# ------------------------------------------------------------
# Generate liberty model
# ------------------------------------------------------------
model \
    -create_new_model \
    -file "${lib_dir}/models/OTFT_stdlib.lib" \
    all \
    -library_type typ

# model -create_new_model -file my_library/models/OTFT_stdlib_13.lib all -library_type typ

puts "SiliconSmart flow finished successfully."