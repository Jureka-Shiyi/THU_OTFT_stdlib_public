pcDefinePCell(
    list(ddGetObj("PDK_OTFT_4INT") "ptft" "layout") 
    (
        (fingers int 1) 
        (l float 10.0) 
        (w float 100.0)
        (lov float 6.0)        
    ) 
    let((widthPerFinger fingersInt gateStep xOffset sdLayer gateLayer activeLayer lov) 
        
        ;; 1. 配置参数 (根据你的 Tech File 修改字符串)
        sdLayer     = list("M1" "drawing")     ; 对应原 Layer 5
        activeLayer = list("MC" "drawing") ; 对应原 Layer 1
        gateLayer   = list("PTFT" "drawing")   ; 对应原 Layer 90
        lov = 6.0
        
        ;; 2. 数据处理
        fingersInt = max(1 fingers)
        l = max(l 3.0)
        widthPerFinger = float(w) / fingersInt
        
        ;; 这里的 gateStep 是指两根 Gate 中心线之间的距离
        ;; 假设 S/D 金属宽度固定为 9.0 (参考你原脚本中的 width0)
        gateStep = 9.0 + l 
        
        ;; 3. 绘制 Active (半导体层) - 覆盖所有 Fingers
        ;; 宽度随指重合，长度覆盖所有指产生的间距
        dbCreateRect(pcCellView activeLayer 
            list(-7.0 : -4.0 - lov
                 7.0 + (widthPerFinger - 10.0) : -4.0 + (fingersInt * gateStep) + lov))

        ;; 4. 循环绘制 Fingers (Gate) 和共享的 Source/Drain
        for(i 0 (fingersInt - 1)
            xOffset = i * gateStep
            
            ;; --- 绘制 Gate ---
            dbCreateRect(pcCellView gateLayer 
                list(-5.0 : -13.0 + xOffset
                     5.0 + (widthPerFinger - 10.0) : -4.0 + l + 9.0 + xOffset))
            
            ;; --- 绘制 Source/Drain (共享逻辑) ---
            ;; 每一指绘制它“上方”的极板
            dbCreateRect(pcCellView sdLayer 
                list(-5.0 : -4.0 + l + xOffset
                     5.0 + (widthPerFinger - 10.0) : -4.0 + l + 9.0 + xOffset))
        ) ;end for

        ;; 5. 绘制最底部的第一个极板 (Common Source)
        ;; 因为循环只画了每指上方的，最下面需要补齐
        dbCreateRect(pcCellView sdLayer 
            list(-5.0 : -13.0
                 5.0 + (widthPerFinger - 10.0) : -4.0))

        dbReplaceProp(pcCellView "function" "string" "transistor")
        dbReplaceProp(pcCellView "viewSubType" "string" "maskLayoutParamCell")
        t
    )
)