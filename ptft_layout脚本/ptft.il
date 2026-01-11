pcDefinePCell(list(ddGetObj("PDK_OTFT_4INT") "ptft" "layout") 
    (
        (fingers float 1.0) 
        (l float 10u) 
        (w float 10u)
        (lov float 6u)  
        (sd_w float 20u)
		(gateBus_width float 20u) 
		(gateOut float 10u)
    ) 
    let( ( widthPerFinger_um  gateStep offsetY gateBus_y_lo gateBus_y_hi
		gateOut_um length_um sd_w_um lov_um gateBus_width_um
		pcMembre pcStretchGroup stretchOffsetX stretchOffsetY
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


	dbReplaceProp(pcCellView "function" "string" "transistor") 
	dbReplaceProp(pcCellView "viewSubType" "string" "maskLayoutParamCell")
	dbReplaceProp(pcCellView "model" "string" "ptft")

	(pcRepeat = (pcRepeatX = (pcRepeatY = 1.0) ) )  
	(pcRepeat = (pcRepeatY = fingers) ) 
	(pcIndexX = 0) 
	

	for(pcIndexY 0 
	    (fix(pcRepeatY) - 1) nil

		;; --- 绘制 M1 (S/D 电极) ---
        ;; 每一指绘制其“上方”的那个电极
	    (pcLayer = 1) 
	    (pcPurpose = "drawing") 
	    (pcInst = dbCreateRect(pcCellView 
		    list(pcLayer pcPurpose) 
		    list( (0.0:(gateStep + (pcIndexY * gateStep) ) ) 
			( widthPerFinger_um:(gateStep + sd_w_um + (pcIndexY * gateStep) ) )
		    )
		))

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

	;; --- 绘制最底下的 M1 (S/D 电极) ---
	(pcLayer = 1) 
	(pcPurpose = "drawing") 
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list( (0.0 : 0.0) 
		    ( widthPerFinger_um:sd_w_um)
		)
	    ))
		t
	)      
)