let((ptftLibName layoutLibName cellName viewName ptftCellName cv ptftMaster 
     lList spacingX yStep yMax yCoord xCoord xStart yIndex)
    
    ;; --- 1. 配置参数 ---
    ptftLibName    = "PDK_OTFT_4INT"
    layoutLibName  = "TEST_4INT"
    cellName       = "hyk2601"
    viewName       = "layout"
    ptftCellName   = "ptft_pad_guardring"
    
    ;; L 参数列表 (单位：米)
    lList = list(-2.0/1e6 -5.0/1e6 -10.0/1e6)
    
    ;; 间距与范围设置
    xStart   = 6000.0   ;; 每行起始 X 坐标
    spacingX = 1500.0   ;; 横向间距
    yStep    = 1000.0   ;; 纵向间距
    yMax     = 5000.0   ;; 最大高度
    
    ;; --- 2. 打开版图 ---
    cv = dbOpenCellViewByType(layoutLibName cellName viewName "maskLayout" "a")
    ptftMaster = dbOpenCellViewByType(ptftLibName ptftCellName "layout")

    if(cv && ptftMaster then
        
        ;; --- 3. 嵌套循环绘制矩阵 ---
        ;; 外层循环控制行 (Y 轴)
        for(yIndex 0 fix(yMax / yStep)
            yCoord = yIndex * yStep
            xCoord = xStart  ;; 每换一行，重置 X 坐标到起始位置
            
            printf("--- 正在绘制第 %d 行 (Y = %.1f) ---\n" (yIndex + 1) yCoord)

            ;; --- 4. 内层逻辑：处理该行的所有器件 ---
            
            ;; (A) 首先绘制 list 中的参数化器件
            foreach(lVal lList
                dbCreateParamInst(cv ptftMaster nil 
                    list(xCoord yCoord) "R0" 1
                    list(
                        list("fingers" "float" 5.0)
                        list("w"       "float" 0.005)
                        list("l"       "float" (20.0/1e6 - 2.0 * lVal))
                        list("lov"     "float" lVal)
                        list("sd_w"    "float" 20.0/1e6)
                        list("gateBus_width" "float" 20.0/1e6)
                        list("gateOut" "float" 10.0/1e6)
                    )
                )
                xCoord = xCoord + spacingX ;; 移动到下一个 X 位置
            ) ; end foreach L

            ;; (B) 在本行末尾追加那个特殊的固定参数器件
            ;; 它会紧跟在上述 list 器件之后
            dbCreateParamInst(cv ptftMaster nil 
                list(xCoord yCoord) "R0" 1
                list(
                    list("fingers" "float" 5.0)
                    list("w"       "float" 0.005)
                    list("l"       "float" 20.0/1e6)
                    list("lov"     "float" 6.0) ;; 注意：这里的 6.0 单位是否与 lList 一致？
                    list("sd_w"    "float" 20.0/1e6)
                    list("gateBus_width" "float" 20.0/1e6)
                    list("gateOut" "float" 10.0/1e6)
                )
            )
            
        ) ; end for Y

        ;; --- 5. 保存并关闭 ---
        dbSave(cv)
        dbClose(cv)
        dbClose(ptftMaster)
        printf("--- 矩阵阵列追加完成！共绘制了 %d 行 ---\n" (fix(yMax/yStep) + 1))
    else
        error("无法打开 CellView，请检查库名和单元名是否正确。")
    )
)