
procedure(MigrateAndCleanupLib(srcLibName dstLibName targetTechLib)
    let((srcLibId dstLibId srcCvId dstCvId count)
        count = 0
        
        ; 1. 获取/创建库
        srcLibId = ddGetObj(srcLibName)
        unless(srcLibId error("找不到源库: %s" srcLibName))
        
        dstLibId = ddGetObj(dstLibName) || ddCreateLib(dstLibName)
        unless(dstLibId error("无法创建目标库: %s" dstLibName))

        ; 2. 绑定新工艺库
        printf("--- 步骤 1: 强制绑定新工艺库 %s ---\n" targetTechLib)
        techBindTechFile(dstLibId targetTechLib)

        ; 3. 遍历源库中的所有 Cell
        printf("--- 步骤 2: 开始逐对象复制版图 (绕过 TechDB 校验) ---\n")
        foreach(cell srcLibId~>cells
            when(member("layout" cell~>views~>name)
                ; 打开源版图 (只读)
                srcCvId = dbOpenCellViewByType(srcLibName cell~>name "layout" "maskLayout" "r")
                
                if(srcCvId then
                    printf("  正在迁移 Cell: %s\n" cell~>name)
                    
                    ; 在目标库创建/打开一个全新的版图 (覆盖写模式)
                    dstCvId = dbOpenCellViewByType(dstLibName cell~>name "layout" "maskLayout" "w")
                    
                    if(dstCvId then
                        ; --- 核心：逐一复制形状，跳过 M1d 和 M2d ---
                        foreach(shape srcCvId~>shapes
                            unless(member(shape~>layerName '("M1d" "M2d"))
                                ; 使用 dbCopyFig 将形状从源 CV 复制到目标 CV
                                dbCopyFig(shape dstCvId list(0:0 "R0" 1.0))
                            )
                        )

                        ; --- 复制过孔 (Vias) ---
                        foreach(via srcCvId~>vias
                            dbCopyFig(via dstCvId list(0:0 "R0" 1.0))
                        )

                        ; --- 复制实例 (Instances) ---
                        ; 注意：这里假设调用的子单元也在新库中或路径正确
                        foreach(inst srcCvId~>instances
                            dbCopyFig(inst dstCvId list(0:0 "R0" 1.0))
                        )

                        ; --- 复制管脚和终端 (Pins/Terminals) ---
                        foreach(term srcCvId~>terminals
                            foreach(pin term~>pins
                                when(pin~>fig && !member(pin~>fig~>layerName '("M1d" "M2d"))
                                    dbCopyFig(pin~>fig dstCvId list(0:0 "R0" 1.0))
                                )
                            )
                        )

                        dbSave(dstCvId)
                        dbClose(dstCvId)
                        count++
                    )
                    dbClose(srcCvId)
                )
            )
        )
        printf("\n=== 迁移成功！共处理 %d 个版图 ===\n" count)
    )

; 执行：
MigrateAndCleanupLib("OTFT_stdlib_cells" "OTFT_stdlib_cells_4INT" "PDK_OTFT_4INT")