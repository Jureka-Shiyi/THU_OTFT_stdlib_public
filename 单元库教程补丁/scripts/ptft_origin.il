pcDefinePCell(list(ddGetObj("PDK_OTFT_4INT") "ptft" "layout") 
    ((fingers float 1.0) 
	(l float 4u) 
	(w float 10u)
    ) 
    let((w l width width0 width0offset length length1
	    length1offset pcMember pcStretchGroup stretchOffsetX stretchOffsetY
	    fingers pcLib pcMaster pcInst pcTerm
	    pcPin pcPinName pcNet pcTermNet pcNetName
	    pcTermNetName pcMosaicInst pcParameters pcParamProp pcStep
	    pcStepX pcStepY pcRepeat pcRepeatX pcRepeatY
	    pcIndexX pcIndexY pcLayer pcPurpose pcLabelText
	    pcLabelHeight pcPropText pcParamText pcCoords pcPathWidth
	    pcPolygonMargin lov
	) 
	(lov = 6.0)
	(pcLib = (pcCellView~>lib)) 
	(pcParameters = ((pcCellView~>parameters)~>value)) 
	(pcParamProp = car(exists(prop pcParameters 
		    ((prop~>name) == "fingers")
		)
	    )) 
	(fingers = (pcParamProp~>value))
	if(((pcParamProp~>valueType) == "boolean") 
	    (fingers = (fingers == "TRUE"))
	) 
        if((fingers < 1) then
            (fingers = 1.0)
        )
        (fingers = fix(fingers))
	(pcParamProp = car(exists(prop pcParameters 
		    ((prop~>name) == "l")
		)
	    )) 
	(length = (pcParamProp~>value) * 1000000) 
	if(((pcParamProp~>valueType) == "boolean") 
	    (length = (length == "TRUE"))
	) 
	(pcParamProp = car(exists(prop pcParameters 
		    ((prop~>name) == "w")
		)
	    ))
	(width = (pcParamProp~>value) * 1000000 / fingers) 
	if(((pcParamProp~>valueType) == "boolean") 
	    (width = (width == "TRUE"))
	) 
	(width0 = width) 
	(length1 = length) 
	if((width0 < 9) then 
	    (width0 = 9.0)
	)
	(width0offset = (width0 - 10)) 
	if((length1 < 3) then 
	    (length1 = 3.0)
	) 
	(length1offset = (length1 - 4)) 
	dbReplaceProp(pcCellView "function" "string" "transistor") 
	dbReplaceProp(pcCellView "instance#" "int" 1)
	dbReplaceProp(pcCellView "_pcCompiledCounter" "int" 1039) 
	dbReplaceProp(pcCellView "viewSubType" "string" "maskLayoutParamCell")
	 
	(pcRepeat = (pcRepeatX = (pcRepeatY = 1.0))) 
	(pcStep = (pcStepX = (pcStepY = 0.0))) 
	(pcStep = (pcStepY = car(errset((9 + length)))))
	(pcRepeat = (pcRepeatY = fingers)) 
	(pcStep = (pcStepY = (9 + length))) 
	(pcIndexX = 0) 
	for(pcIndexY 0 
	    (fix(pcRepeatY) - 1) nil 
	    (pcLayer = 5)
	    (pcPurpose = "drawing") 
	    (pcInst = dbCreateRect(pcCellView 
		    list(pcLayer pcPurpose) 
		    list((-5.0:(-4.0 + length + (pcIndexY * pcStepY))) 
			((5.0 + width0offset):(-4.0 + length + 9 + (pcIndexY * pcStepY)))
		    )
		)) 
	    (pcLayer = 1) 
	    (pcPurpose = "drawing") 
	    (pcInst = dbCreateRect(pcCellView 
		    list(pcLayer pcPurpose) 
		    list((-7.0:(-4.0 - lov + (pcIndexY * pcStepY))) 
			((7.0 + width0offset):(-4.0 + length + lov + (pcIndexY * pcStepY)))
		    )
		))
	    (pcLayer = 90)
	    (pcPurpose = "drawing") 
	    (pcInst = dbCreateRect(pcCellView 
		    list(pcLayer pcPurpose) 
		    list((-5.0:(-13.0 + (pcIndexY * pcStepY))) 
			((5.0 + width0offset):(-4.0 + length + 9 + (pcIndexY * pcStepY)))
		    )
		))		
	) 

	(pcLayer = 5) 
	(pcPurpose = "drawing") 
	(pcInst = dbCreateRect(pcCellView 
		list(pcLayer pcPurpose) 
		list((-5.0:-13.0) 
		    ((5.0 + width0offset):-4.0)
		)
	    )) t
    )
)
