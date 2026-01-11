;created by ZYJ, 20260108
;Updated with Guard Ring logic
pcDefinePCell(list(ddGetObj("PDK_OTFT_4INT") "ptft_pad_guardring" "layout") 
    (
        (fingers float 1.0) 
        (l float 10u) 
        (w float 100u)
        (lov float 6u)  
        (sd_w float 20u)
        (gateBus_width float 20u)
        (gateOut float 10u)     
    ) 
    let( ( widthPerFinger_um  gateStep offsetY gateBus_y_lo gateBus_y_hi startX  
        gateOut_um length_um sd_w_um lov_um gateBus_width_um minYR maxYR minYL maxYL
        pcLib pcInst pcParameters pcParamProp pcRepeat pcRepeatX pcRepeatY 
        pcIndexX pcIndexY pcLayer pcPurpose padMaster padWidth_um
        fullBBox minX maxX minY maxY gap ringW inX1 inY1 inX2 inY2 outX1 outY1 outX2 outY2
        ) 

    (pcLib = (pcCellView~>lib)) 
    (pcParameters = ((pcCellView~>parameters)~>value)) 
    (pcParamProp = car(exists(prop pcParameters 
            ((prop~>name) == "fingers")
        )
    )) 
    (fingers = (pcParamProp~>value) )
        if((fingers < 1) then
            (fingers = 1.0)
        )
        (fingers = fix(fingers))

    (pcParamProp = car(exists(prop pcParameters 
            ((prop~>name) == "l")
        )
    )) 
    (length_um = (pcParamProp~>value) * 1000000) 

    (pcParamProp = car(exists(prop pcParameters 
            ((prop~>name) == "w")
        )
    ))
    (widthPerFinger_um = (pcParamProp~>value) * 1000000 / fingers )

    if((widthPerFinger_um < 20.0) then 
        (widthPerFinger_um = 20.0)
    ) 
    if((length_um < 3) then 
        (length_um = 3.0)
    ) 

    sd_w_um = sd_w * 1000000
    gateStep = sd_w_um + length_um 
    lov_um = lov * 1000000
    gateBus_width_um = gateBus_width * 1000000
    gateOut_um = gateOut * 1000000
    padWidth_um = 100.0

    dbReplaceProp(pcCellView "function" "string" "transistor") 
    dbReplaceProp(pcCellView "viewSubType" "string" "maskLayoutParamCell")
    dbReplaceProp(pcCellView "model" "string" "ptft")

    (pcRepeat = (pcRepeatX = (pcRepeatY = 1.0) ) )  
    (pcRepeat = (pcRepeatY = fingers) ) 
    (pcIndexX = 0) 

    for(pcIndexY 0 
        (fix(pcRepeatY) - 1) nil

        let((startX)
        ;; --- 核心判断逻辑 ---
        if( (fix(pcRepeatY) - 1) == 0 then
            startX = 0.0
        else
            if(oddp(pcIndexY) then
                startX = 0.0 - 20.0
            else
                startX = 0.0 + 20.0
            )
        )

        ;; --- 绘制 M1 (S/D 电极) ---
        pcLayer = 1 
        pcPurpose = "drawing" 
        pcInst = dbCreateRect(pcCellView 
            list(pcLayer pcPurpose) 
            list( 
                (startX : (gateStep + (pcIndexY * gateStep))) 
                (startX + widthPerFinger_um : (gateStep + sd_w_um + (pcIndexY * gateStep)))
            )
        )
    )

        ;; --- 绘制 M2 (Gate 电极) ---
        (pcLayer = 2)
        (pcPurpose = "drawing") 
        (pcInst = dbCreateRect(pcCellView 
            list(pcLayer pcPurpose) 
            list(( (0.0 - gateOut_um):(0.0 + sd_w_um - lov_um + (pcIndexY * gateStep) ) ) 
            ( (widthPerFinger_um + gateOut_um):(sd_w_um + length_um + lov_um + (pcIndexY * gateStep) ) )
            )
        ))

        ;; --- 绘制 PTFT 层 ---      
        (pcLayer = 90)
        (pcPurpose = "drawing") 
        (pcInst = dbCreateRect(pcCellView 
            list(pcLayer pcPurpose) 
            list( (0.0: (0.0 + sd_w_um - lov_um + pcIndexY * gateStep ) ) 
            ( widthPerFinger_um:(sd_w_um + lov_um + length_um + (pcIndexY * gateStep)))
            )
        ))      
    )

    ;; -------- Gate Bus (LEFT & RIGHT) --------
    (gateBus_y_lo = sd_w_um - lov_um)
    (gateBus_y_hi = sd_w_um + length_um + lov_um + (fingers - 1) * gateStep)
    (pcLayer = 2)
    (pcPurpose = "drawing")
    ;; Left Bus 
    (pcInst = dbCreateRect(pcCellView 
        list(pcLayer pcPurpose) 
        list(( (0.0 - gateOut_um - gateBus_width_um):gateBus_y_lo ) 
        ( (0.0 - gateOut_um):gateBus_y_hi )
        )
    ))
    ;; Right Bus
    (pcInst = dbCreateRect(pcCellView 
        list(pcLayer pcPurpose) 
        list(
            ((widthPerFinger_um + gateOut_um):gateBus_y_lo)
            ((widthPerFinger_um + gateOut_um + gateBus_width_um):gateBus_y_hi)
        )
    ))

    ;; ---  绘制两侧的连接S/D母线 (Bus Bars) ---
    if( (fix(pcRepeatY) > 1) then
        let((minYR maxYR minYL maxYL)
            resultR = fix(pcRepeatY / 2.0 + 0.6 ) - 1
            resultL = fix(pcRepeatY / 2.0 ) 
            minYR = gateStep
            maxYR = gateStep + resultR * 2 * gateStep + sd_w_um
            minYL = 0.0
            maxYL = resultL * 2 * gateStep + sd_w_um

            dbCreateRect(pcCellView list(1 "drawing") list((widthPerFinger_um : minYR) ((widthPerFinger_um + 20.0) : maxYR)))
            dbCreateRect(pcCellView list(1 "drawing") list((0.0 : minYL) ((0.0 - 20.0) : maxYL)))
        )
    )

    ;; --- 绘制第一个 M1 (S/D 电极) ---
    let((startX)
        if( (fix(pcRepeatY) - 1) == 0 then
            startX = 0.0
        else
            if(oddp(pcIndexY) then
                startX = 0.0 + 20.0
            else
                startX = 0.0 - 20.0
            )
        )
        (pcLayer = 1) 
        (pcPurpose = "drawing") 
        (pcInst = dbCreateRect(pcCellView 
            list(pcLayer pcPurpose) 
            list( (startX : 0.0) (startX + widthPerFinger_um : sd_w_um))
        ))
    )

    ;; --- 绘制 Pad ---
    padMaster = dbOpenCellViewByType("PDK_OTFT_4INT" "pad_100" "layout")
    if( padMaster then
            dbCreateInst(pcCellView padMaster "PAD_S" list(0.0  0.0 - padWidth_um/2.0) "R90")
            dbCreateInst(pcCellView padMaster "PAD_D" list(0.0  (sd_w_um + (fingers * gateStep) + padWidth_um/2.0)) "R270" )
            dbCreateInst(pcCellView padMaster "PAD_G" list(widthPerFinger_um + padWidth_um/2.0  ( (fingers/2.0 * gateStep) + padWidth_um/2.0)) "R180" )
            dbClose(padMaster)
        else
            warn("无法找到 pad 单元。")
    )

    ;; ============================================================
    ;; --- 新增功能：绘制保护环 (Guard Ring) ---
    ;; ============================================================
    let( (fullBBox minX maxX minY maxY gap ringW inX1 inY1 inX2 inY2 outX1 outY1 outX2 outY2)
        ;; 1. 获取当前所有图形的边界框 (包含所有电极和 Pad)
        fullBBox = pcCellView~>bBox
        minX = xCoord(lowerLeft(fullBBox))
        maxX = xCoord(upperRight(fullBBox))
        minY = yCoord(lowerLeft(fullBBox))
        maxY = yCoord(upperRight(fullBBox))

        gap = 50.0    ; 间距 50um
        ringW = 40.0  ; 环宽 40um

        ;; 2. 计算内边界 (距离图形 50um)
        inX1 = minX - gap
        inY1 = minY - gap
        inX2 = maxX + gap
        inY2 = maxY + gap

        ;; 3. 计算外边界 (在内边界基础上再加 40um)
        outX1 = inX1 - ringW
        outY1 = inY1 - ringW
        outX2 = inX2 + ringW
        outY2 = inY2 + ringW

        ;; 4. 使用 M1 (Layer 1) 绘制四个矩形组成环
        ;; 底边
        dbCreateRect(pcCellView list(1 "drawing") list(outX1:outY1 outX2:inY1))
        ;; 顶边
        dbCreateRect(pcCellView list(1 "drawing") list(outX1:inY2 outX2:outY2))
        ;; 左边
        dbCreateRect(pcCellView list(1 "drawing") list(outX1:inY1 inX1:inY2))
        ;; 右边
        dbCreateRect(pcCellView list(1 "drawing") list(inX2:inY1 outX2:inY2))
    )
    ;; ============================================================

    t
    )      
)