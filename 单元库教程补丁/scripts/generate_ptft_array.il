let((ptftLibName layoutLibName cellName viewName cv ptftMaster lList spacingX yStep yMax yCoord xCoord)
    
    ;; --- 1. 配置参数 ---
    ptftLibName      = "PDK_OTFT_4INT"
    layoutLibName    = "TEST_4INT"
    cellName         = "hyk2601"
    viewName         = "layout"
    ptftCellName     = "ptft_pad"
    
    ;; L 参数列表 (单位：米)
    lList = list(20.0/1e6 30.0/1e6 40.0/1e6 50.0/1e6)
    
    ;; 间距设置
    spacingX = 1500.0
    yStep    = 1000.0
    yMax     = 5000.0
    
    ;; --- 2. 打开版图 (使用 "a" 模式保留原有内容) ---
    cv = dbOpenCellViewByType(layoutLibName cellName viewName "maskLayout" "a")
    ptftMaster = dbOpenCellViewByType(ptftLibName ptftCellName "layout")

    if(cv && ptftMaster then
        
        ;; --- 3. 外层循环：控制 Y 轴 (行) ---
        ;; 从 0.0 开始，到 5000.0 结束，每次增加 1000.0
        for(yIndex 0 fix(yMax / yStep)
            yCoord = yIndex * yStep
            xCoord = 0.0  ;; 每换一行，X 坐标重置回 0
            
            printf("--- 正在绘制第 %d 行 (Y = %.1f) ---\n" (yIndex + 1) yCoord)

            ;; --- 4. 内层循环：控制 X 轴 (列，不同 L 值) ---
            foreach(lVal lList
                dbCreateParamInst(cv ptftMaster "" 
                    list(xCoord yCoord) "R0" 1
                    list(
                        list("fingers" "float" 5.0)
                        list("w"       "float" 0.005) ;; 5000um
                        list("l"       "float" lVal)
                        list("lov"     "float" 6.0/1e6)
                        list("sd_w"    "float" 20.0/1e6)
                        list("gateBus_width" "float" 20.0/1e6)
                        list("gateOut" "float" 10.0/1e6)
                    )
                )
                ;; 放置完一个器件后，横向移动
                xCoord = xCoord + spacingX
            ) ; end foreach L
        ) ; end for Y

        ;; --- 5. 保存并关闭 ---
        dbSave(cv)
        dbClose(cv)
        printf("--- 矩阵阵列追加完成！共绘制了 %d 行 ---\n" (fix(yMax/yStep) + 1))
    else
        error("无法打开 CellView，请检查库名和单元名是否正确。")
    )
)