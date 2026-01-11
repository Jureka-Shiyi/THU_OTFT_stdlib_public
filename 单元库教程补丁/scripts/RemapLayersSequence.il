
procedure(RemapLayersSequence(libName)
    let((libId cvId count)
        count = 0
        libId = ddGetObj(libName)
        
        unless(libId
            error("无法找到库: %s" libName)
        )

        printf("--- 开始执行层级重映射: %s ---\n" libName)

        foreach(cell libId~>cells
            when(member("layout" cell~>views~>name)
                ; 以读写模式打开版图
                cvId = dbOpenCellViewByType(libName cell~>name "layout" "maskLayout" "a")
                if(cvId then
                    printf("  正在处理 Cell: %s\n" cell~>name)

                    ; ---------------------------------------------------------
                    ; 核心逻辑：使用 foreach 遍历所有图形对象
                    ; ---------------------------------------------------------
                    foreach(shape cvId~>shapes
                        ; 检查层名（默认为 drawing purpose）
                        cond(
                            (shape~>layerName == "M1"
                                shape~>layerName = "MC"
                            )
                            (shape~>layerName == "Via2"
                                shape~>layerName = "M1"
                            )
                        )
                    )

                    ; ---------------------------------------------------------
                    ; 处理 Pin 图形 (Pins 通常关联在 Terminal 上)
                    ; ---------------------------------------------------------
                    foreach(term cvId~>terminals
                        foreach(pin term~>pins
                            when(pin~>fig
                                cond(
                                    (pin~>fig~>layerName == "M1"
                                        pin~>fig~>layerName = "MC"
                                    )
                                    (pin~>fig~>layerName == "Via2"
                                        pin~>fig~>layerName = "M1"
                                    )
                                )
                            )
                        )
                    )

                    ; ---------------------------------------------------------
                    ; 处理 Via 对象 (Standard Vias)
                    ; ---------------------------------------------------------
                    foreach(via cvId~>vias
                        cond(
                            (via~>layerName == "M1"
                                via~>layerName = "MC"
                            )
                            (via~>layerName == "Via2"
                                via~>layerName = "M1"
                            )
                        )
                    )

                    dbSave(cvId)
                    dbClose(cvId)
                    count++
                else
                    warn("无法打开版图视图: %s" cell~>name)
                )
            )
        )
        printf("\n=== 任务完成！共更新了 %d 个 Cell ===\n" count)
    )
)

; 执行脚本命令：
RemapLayersSequence("OTFT_stdlib_cells_4INT")
