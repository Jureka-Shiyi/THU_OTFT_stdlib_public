;created by ZYJ,2026
pcDefinePCell(list(ddGetObj("PDK_OTFT_4INT") "ptft" "layout") 
    (
        (fingers float 1.0) 
        (l float 10u) 
        (w float 10u)
        (lov float 6u)  
        (sd_w float 20u)
		(gateBus_width float 20u)
		(gateOut float 10u)
		(SDbusWidth float 20u)			 
		(SDoutWidth float 20u)			
    ) 
    let( ( widthPerFinger_um  gateStep offsetY gateBus_y_lo gateBus_y_hi startX SDbusWidth SDoutWidth
		gateOut_um length_um sd_w_um lov_um gateBus_width_um minYR maxYR minYL maxYL
		pcMembre pcStretchGroup stretchOffsetX stretchOffsetY SDoutWidth_um SDbusWidth_um
	    pcLib pcMaster pcInst pcTerm
	    pcPin pcPinName pcNet pcTermNet pcNetName
	    pcTermNetName pcMosaicInst pcParameters pcParamProp pcStep
	    pcStepX pcStepY pcRepeat pcRepeatX pcRepeatY
	    pcIndexX pcIndexY pcLayer pcPurpose pcLabelText
	    pcLabelHeight pcPropText pcParamText pcCoords pcPathWidth
	    pcPolygonMargin) 

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
	SDbusWidth_um = SDbusWidth * 1000000		 
	SDoutWidth_um = SDoutWidth * 1000000

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
            ;; 如果总数只有一个(pcRepeatY=1)，startX 设为 0
            startX = 0.0
        else
            ;; 如果总数大于一个，则根据当前索引 pcIndexY 的奇偶性判断
            if(oddp(pcIndexY) then
                startX = 0.0 - SDoutWidth_um
            else
                startX = 0.0 + SDoutWidth_um
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
        ;; 关键：Gate 的中心对准沟道，高度 = sd_w_um + 2*lov_um
        ;; 它的起始 Y = 第一个电极结束点 - lov_um
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
		;; 只有当电极数量大于 1 时才需要连接
		if( (fix(pcRepeatY) > 1) then
			let((minYR maxYR minYL maxYL)
				; 左右母的条件不同		
				resultR = fix(pcRepeatY / 2.0 + 0.6 ) - 1
				resultL = fix(pcRepeatY / 2.0 ) 

				;右侧母线需要高一个gateStep
				minYR = gateStep
				maxYR = gateStep + resultR * 2 * gateStep + sd_w_um
				;左侧母线需要从最底层开始
				minYL = 0.0
				maxYL = resultL * 2 * gateStep + sd_w_um

				;; 绘制右侧母线 (连接 startX = SDoutWidth_um 的偶数层)
				;; 坐标从 20 开始，向右延伸 SDbusWidth_um
				dbCreateRect(pcCellView
					list(1 "drawing")
					list((widthPerFinger_um : minYR) ((widthPerFinger_um + SDbusWidth_um) : maxYR))
				)

				;; 绘制左侧母线 (连接 startX = -SDoutWidth_um 的奇数层)
				;; 坐标从 -20 开始，向左延伸 SDbusWidth_um (即到 -40)
				dbCreateRect(pcCellView
					list(1 "drawing")
					list((0.0 : minYL) ((0.0 - SDbusWidth_um) : maxYL))
				)
			)
		)

        ;; --- 绘制第一个 M1 (S/D 电极) ---
		let((startX)
        ;; --- 核心判断逻辑 ---
        if( (fix(pcRepeatY) - 1) == 0 then
            ;; 如果总数只有一个(pcRepeatY=1)，startX 设为 0
            startX = 0.0
        else
            ;; 如果总数大于一个，则根据当前索引 pcIndexY 的奇偶性判断，和其他的M1判断相反
            if(oddp(pcIndexY) then
                startX = 0.0 + SDoutWidth_um
            else
                startX = 0.0 - SDoutWidth_um
            )
        )

		(pcLayer = 1) 
		(pcPurpose = "drawing") 
		(pcInst = dbCreateRect(pcCellView 
			list(pcLayer pcPurpose) 
			list( (startX : 0.0) 
				( startX + widthPerFinger_um:sd_w_um)
			)
			))
    )
	t
	)      
)