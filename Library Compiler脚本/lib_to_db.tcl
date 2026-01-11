# lib_to_db.tcl
# origin code created by deyun chen
# set cells {OTFT_stdlib_13}
# cd /data/zhengyj/OTFT_stdlib/OTFT_stdlib_lib/${cell}

# foreach cell $cells {
#     read_lib ${cell}.lib
#     write_lib -format db OTFT_stdlib -output ${cell}.db
# }

# lib_to_db.tcl created by doubao
set cells {OTFT_stdlib_16}
set base_path "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_lib"

foreach cell $cells {
    # 拼接绝对路径：lib文件和db文件
    set lib_file [file join $base_path $cell "${cell}.lib"]
    set db_file [file join $base_path $cell "${cell}.db"]
    
    # 判断lib文件是否存在
    if {![file exists $lib_file]} {
        puts "Error: Lib file $lib_file does not exist!"
        continue
    }
    
    # 读取lib文件（绝对路径）
    read_lib $lib_file
    
    # 写入db文件（绝对路径，无需依赖当前目录）
    write_lib -format db -output $db_file OTFT_stdlib
    
    puts "Success: Processed $cell, output db file to $db_file"
}

puts "Script execution completed."

# write_lib -format db OTFT_stdlib -output OTFT_stdlib_12.db
# cd /home/chendy/data/TFT_stdlib/innovus
# exit  

