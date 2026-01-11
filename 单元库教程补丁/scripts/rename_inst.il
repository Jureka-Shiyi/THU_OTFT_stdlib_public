procedure(UpdatePtftLib()
    let((libName cellName targetLib cells cv changed count)
        libName = "OTFT_stdlib_cells_4INT"
        targetLib = "PDK_OTFT_4INT"
        count = 0

        printf("--- 开始修改器件库名 ---\n")
        
        foreach(cell ddGetObj(libName)->cells
            ; 确保只打开 schematic 视图
            if(ddGetObj(libName cell->name "schematic") then
                cv = dbOpenCellViewByType(libName cell->name "schematic" "schematic" "a")
                if(cv then
                    changed = nil
                    foreach(inst cv->instances
                        ; 打印一下找到的器件，方便调试 (如果输出太多可以注释掉)
                        ; printf("Check Inst: %s (Lib: %s Cell: %s)\n" inst->name inst->libName inst->cellName)
                        
                        ; 使用更严谨的判断
                        if( inst->cellName == "ptft" && inst->libName == "PDK_OTFT_251202" then
                            printf("  Cell %s: 将实例 %s 从 %s 改为 %s\n" 
                                   cell->name inst->name inst->libName targetLib)
                            
                            ; 【核心修复】直接修改 master 属性，这会强制库名刷新
                            inst->master = dbOpenCellViewByType(targetLib inst->cellName "symbol")
                            
                            changed = t
                            count++
                        )
                    )
                    
                    if(changed then
                        ; 必须进行 Check 和 Save
                        schCheck(cv)
                        dbSave(cv)
                    )
                    dbClose(cv)
                )
            )
        )
        printf("--- 任务完成！共修改了 %d 个器件 ---\n" count)
    )
)

UpdatePtftLib()