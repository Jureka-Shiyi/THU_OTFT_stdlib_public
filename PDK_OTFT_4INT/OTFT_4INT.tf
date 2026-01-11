; Technology File 2021_Q4MPG_THU_20220105_check
; Generated on Aug 23 09:51:34 2022
; with @(#)$CDS: virtuoso version 6.1.7-64b 12/16/2018 07:36 (sjfhw317) $

;********************************
; CONTROLS
;********************************
controls(
 techVersion("1.0")

 techParams(
 ;( parameter           value             )
 ;( ----------          -----             )
  ( maskGrid       	0.05 )
  ( cadGrid        	0.05 )
  ( drcGrid        	0.05 )
  ( mfgGrid        	0.05 )
  ( scale          	1.0 )
 ) ;techParams

 viewTypeUnits(
 ;( viewType            userUnit       dbuperuu           )
 ;( --------            --------       --------           )
  ( maskLayout     	"_def_"        	1000             )
  ( hierDesign     	"_def_"        	1000             )
 ) ;viewTypeUnits

 mfgGridResolution(
      ( 0.05000 )
 ) ;mfgGridResolution

) ;controls

;********************************
; LAYER DEFINITION
;********************************
layerDefinitions(

 techLayers(
 ;( LayerName                 Layer#     Abbreviation )
 ;( ---------                 ------     ------------ )
 ;User-Defined Layers:
  ( M1                        1          M1           )
  ( MC                        2          MC           )
  ( Via1                      3          Via1         )
  ( M2                        4          M2           )
  ( Via2                      5          Via2         )
  ( M3                        6          M3           )
  ( Via3                      7          Via3         )
  ( M4                        8          M4           )
  ( Via4                      9          Via4         )
  ( M5                        10         M5           )
  ( PTFT                      90         PTFT         )
  ( SU8                       91         SU8          )
  ( Text                      92         Text         )  
 ) ;techLayers

 techLayerPurposePriorities(
 ;layers are ordered from lowest to highest priority
 ;( LayerName                 Purpose    )
 ;( ---------                 -------    )
  ( M1                        drawing    )
  ( M1                        grid       )
  ( M1                        track      )
  ( M1                        blockage   )
  ( MC                        drawing    )
  ( MC                        grid       )
  ( MC                        track      )
  ( MC                        blockage   )  
  ( Via1                      drawing    )
  ( Via1                      grid       )
  ( Via1                      blockage   )  
  ( M2                        drawing    )
  ( M2                        grid       )
  ( M2                        track      )
  ( M2                        blockage   )  
  ( Via2                      drawing    )
  ( Via2                      grid       )
  ( Via2                      blockage   )  
  ( M3                        drawing    )
  ( M3                        grid       )
  ( M3                        track      )
  ( M3                        blockage   ) 
  ( Via3                      drawing    )
  ( Via3                      grid       )
  ( Via3                      blockage   )  
  ( M4                        drawing    )
  ( M4                        grid       )
  ( M4                        track      )
  ( M4                        blockage   ) 
  ( Via4                      drawing    )
  ( Via4                      grid       )
  ( Via4                      blockage   )  
  ( M5                        drawing    )
  ( M5                        grid       )
  ( M5                        track      )
  ( M5                        blockage   ) 
  ( SU8                       drawing    )
  ( SU8                        grid       )
  ( SU8                        track      )
  ( SU8                        blockage   )  
  ( Text                      boundary   )  
  ( PTFT                      drawing    )
  ( M1                        pin        )
  ( MC                        pin        )
  ( M2                        pin        )
  ( M3                        pin        )
  ( M4                        pin        )
  ( M5                        pin        )
  ( SU8                       pin        )  
 ) ;techLayerPurposePriorities

 techDisplays(
 ;( LayerName    Purpose      Packet          Vis Sel Con2ChgLy DrgEnbl Valid )
 ;( ---------    -------      ------          --- --- --------- ------- ----- )
  ( M1           drawing      M1_drawing       t t t t t )
  ( M1           track        M1_drawing       nil nil t t nil )
  ( M1           grid         M1_grid          t nil nil nil nil )
  ( M1           blockage     M1_blockage      t nil t t nil )  
  ( MC           drawing      MC_drawing       t t t t t )
  ( MC           track        MC_drawing       nil nil t t nil )
  ( MC           grid         MC_grid          t nil nil nil nil )
  ( MC           blockage     MC_blockage      t nil t t nil )
  ( Via1         drawing      Via1_drawing     t t t t t )
  ( Via1           track      Via1_drawing       nil nil t t nil )
  ( Via1           grid       Via1_grid          t nil nil nil nil )
  ( Via1           blockage   Via1_blockage      t nil t t nil )   
  ( M2           drawing      M2_drawing       t t t t t )
  ( M2           track        M2_drawing       nil nil t t nil )
  ( M2           grid         M2_grid          t nil nil nil nil )
  ( M2           blockage     M2_blockage      t nil t t nil )
  ( Via2         drawing      Via2_drawing     t t t t t )
  ( Via2           track      Via2_drawing       nil nil t t nil )
  ( Via2           grid       Via2_grid          t nil nil nil nil )
  ( Via2           blockage   Via2_blockage      t nil t t nil )     
  ( M3          drawing      M3_drawing      t t t t t )
  ( M3           track        M3_drawing       nil nil t t nil )
  ( M3           grid         M3_grid          t nil nil nil nil )
  ( M3           blockage     M3_blockage      t nil t t nil )
  ( Via3         drawing      Via3_drawing     t t t t t )
  ( Via3           track      Via3_drawing       nil nil t t nil )
  ( Via3           grid       Via3_grid          t nil nil nil nil )
  ( Via3           blockage   Via3_blockage      t nil t t nil )           
  ( M4          drawing      M4_drawing      t t t t t )
  ( M4           track        M4_drawing       nil nil t t nil )
  ( M4           grid         M4_grid          t nil nil nil nil )
  ( M4           blockage     M4_blockage      t nil t t nil )
  ( Via4         drawing      Via4_drawing     t t t t t )
  ( Via4           track      Via4_drawing       nil nil t t nil )
  ( Via4           grid       Via4_grid          t nil nil nil nil )
  ( Via4           blockage   Via4_blockage      t nil t t nil )   
  ( M5          drawing      M5_drawing      t t t t t )
  ( M5           track        M5_drawing       nil nil t t nil )
  ( M5           grid         M5_grid          t nil nil nil nil )
  ( M5           blockage     M5_blockage      t nil t t nil )       
  ( SU8          drawing      SU8_drawing      t t t t t )
  ( SU8           track        SU8_drawing       nil nil t t nil )
  ( SU8           grid        SU8_grid          t nil nil nil nil )
  ( SU8           blockage    SU8_blockage      t nil t t nil )  
  ( M1           pin          M1_pin           t t t t t )
  ( MC           pin          MC_pin           t t t t t )
  ( M2           pin          M2_pin           t t t t t )
  ( M3           pin          M3_pin           t t t t t )
  ( M4           pin          M4_pin           t t t t t )
  ( M5           pin          M5_pin           t t t t t )
  ( SU8           pin          SU8_pin           t t t t t )
  ( Text         boundary     Text_boundary    t t t t t )
  ( PTFT         drawing      PTFT_drawing     t t t t t )
 ) ;techDisplays

) ;layerDefinitions

;********************************
; LAYER RULES
;********************************
layerRules(

 functions(
 ;( layer                       function        [maskNumber])
 ;( -----                       --------        ------------)
  ( M1                        "metal"    1            )
  ( MC                        "pseudoMetal"   2       )
  ( Via1                      "cut"      3            )
  ( M2                        "metal"    4            )
  ( Via2                      "cut"      5            )
  ( M3                        "metal"    6            )
  ( Via3                      "cut"      7            )
  ( M4                        "metal"    8            )
  ( Via4                      "cut"      9            )
  ( M5                        "metal"    10           )
  ( SU8                       "passivationCut"   91   )
 ) ;functions

 routingDirections(
 ;( layer                       direction     )
 ;( -----                       ---------     )
  ( M1                       	"horizontal")
  ( MC                       	"none"      )
  ( M2                       	"vertical"  )
  ( M3                       	"horizontal")
  ( M4                       	"vertical"  )
  ( M5                       	"horizontal")  
 ) ;routingDirections 

 stampLabelLayers(
 ;( textLayer   layers        )
 ;( ---------   ----------------------------------        )
  ( ("M1" "pin")	M1         )
  ( ("MC" "pin")	MC         )
  ( ("M2" "pin")	M2         )
  ( ("M3" "pin")	M3         )
  ( ("M4" "pin")	M4         )
  ( ("M5" "pin")	M5         )
  ( ("SU8" "pin")	SU8        )
 ) ;stampLabelLayers

) ;layerRules

;********************************
; VIADEFS
;********************************
viaDefs(

 standardViaDefs(
 ;( viaDefName	layer1	layer2	(cutLayer cutWidth cutHeight [resistancePerCut]) 
 ;   (cutRows	cutCol	(cutSpace)	[(l_cutPattern)]) 
 ;   (layer1Enc) (layer2Enc)	(layer1Offset)	(layer2Offset)	(origOffset) 
 ;   [implant1	 (implant1Enc)	[implant2	(implant2Enc) [well/substrate]]]) 
 ;( -------------------------------------------------------------------------- ) 
  ( M2_MC     	MC     M2     	("Via1" 5.0 5.0 5.0)
     (1 1 (5.0 5.0))
     (5.0 5.0)	(5.0 5.0)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( M2_M1     	M1     M2     	("Via1" 5.0 5.0 5.0)
     (1 1 (5.0 5.0))
     (5.0 5.0)	(5.0 5.0)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( M3_M2     	M2     M3     	("Via2" 5.0 5.0 5.0)
     (1 1 (5.0 5.0))
     (5.0 5.0)	(5.0 5.0)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( M4_M3     	M3     M4     	("Via3" 5.0 5.0 5.0)
     (1 1 (5.0 5.0))
     (5.0 5.0)	(5.0 5.0)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( M5_M4     	M4     M5     	("Via4" 5.0 5.0 5.0)
     (1 1 (5.0 5.0))
     (5.0 5.0)	(5.0 5.0)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
 ) ;standardViaDefs

) ;viaDefs

;********************************
; CONSTRAINT GROUPS
;********************************
constraintGroups(

 ;( group	[override]	[definition]	[operator] )
 ;( -----	----------	------------	---------- )
  ( "virtuosoDefaultSetup"	nil

    interconnect(
     ( validLayers    (M1 M2 M3 M4 M5 ) )
     ( validVias     ( M2_M1 M2_MC M3_M2 M4_M3 M5_M4 ) )
    ) ;interconnect

  ) ;virtuosoDefaultSetup

 ;( group	[override]	[definition]	[operator] )
 ;( -----	----------	------------	---------- )
  ( "virtuosoDefaultExtractorSetup"	nil

    interconnect(
     ( validLayers  ( ( M1  drawing) ( M1  pin) ( M2  drawing) ( M2  pin) ( M3 drawing) (M3 pin) ( M4 drawing) ( M4 pin) ( M5 drawing) ( M5 pin) ) )  
     ( validVias     (M2_M1 M2_MC M3_M2 M4_M3 M5_M4 ) )
    ) ;interconnect

  ) ;virtuosoDefaultExtractorSetup

 ;( group	[override]	[definition]	[operator] )
 ;( -----	----------	------------	---------- )
  ( "VLMDefaultSetup"	nil

    interconnect(
     ( validLayers   (M1 MC M2 M3 M4 M5  ) )
     ( validVias     (M2_M1  M2_MC  M3_M2 M4_M3 M5_M4    ) )

    ) ;interconnect

  ) ;VLMDefaultSetup

 ;( group	[override]	[definition]	[operator] )
 ;( -----	----------	------------	---------- )
  ( "LEFDefaultRouteSpec"	nil    "LEFDefaultRouteSpec"

    interconnect(
     ( validLayers   (M1  M2 M3 M4 M5 ) )
     ( validVias     (M2_M1  M3_M2 M4_M3 M5_M4   ) )
    ) ;interconnect

    routingGrids(
     ( verticalPitch              "M1"	   30.0 )
     ( horizontalPitch            "M1"	   30.0 )
     ( verticalOffset             "M1"	   15.0 )
     ( horizontalOffset           "M1"	   15.0 )
     ( verticalPitch              "M2"	   30.0 )
     ( horizontalPitch            "M2"	   30.0 )
     ( verticalOffset             "M2"	   15.0 )
     ( horizontalOffset           "M2"	   15.0 )
     ( verticalPitch              "M3"	   30.0 )
     ( horizontalPitch            "M3"	   30.0 )
     ( verticalOffset             "M3"	   15.0 )
     ( horizontalOffset           "M3"	   15.0 )
     ( verticalPitch              "M4"	   30.0 )
     ( horizontalPitch            "M4"	   30.0 )
     ( verticalOffset             "M4"	   15.0 )
     ( horizontalOffset           "M4"	   15.0 )
     ( verticalPitch              "M5"	   30.0 )
     ( horizontalPitch            "M5"	   30.0 )
     ( verticalOffset             "M5"	   15.0 )
     ( horizontalOffset           "M5"	   15.0 )     
    ) ;routingGrids
    placementGrids(
     ( horizontalPitch            30.0 )
     ( verticalPitch              30.0 )
    ) ;placementGrids

  ) ;LEFDefaultRouteSpec

 ;( group	[override]	[definition]	[operator] )
 ;( -----	----------	------------	---------- )
  ( "foundry"	nil
	memberConstraintGroups(
 	; listed in order of precedence
 	; -----------------------------
       "minProtrusionNumCutCG"
	); memberConstraintGroups

    spacings(
     ( minWidth                   "M1"	12.0  'ref  "M1.W.1"  'description  "Minimum M1 Width" )
     ( minSpacing                 "M1"	8.0   'ref  "M1.S.1"  'description  "Minimum M1 Space" )
     ( minWidth                   "MC"	12.0  'ref  "MC.W.1"  'description  "Minimum MC Width" )
     ( minSpacing                 "MC"	8.0   'ref  "MC.S.1"  'description  "Minimum MC Space" )
     ( minWidth                   "M2"	12.0  'ref  "M2.W.1"  'description  "Minimum M2 Width" )
     ( minSpacing                 "M2"	8.0   'ref  "M2.S.1"  'description  "Minimum M2 Space" )
     ( minWidth                   "M3"	12.0  'ref  "M3.W.1"  'description  "Minimum M3 Width" )
     ( minSpacing                 "M3"	8.0   'ref  "M3.S.1"  'description  "Minimum M3 Space" )
     ( minWidth                   "M4"	12.0  'ref  "M4.W.1"  'description  "Minimum M4 Width" )
     ( minSpacing                 "M4"	8.0   'ref  "M4.S.1"  'description  "Minimum M4 Space" )
     ( minWidth                   "M5"	12.0  'ref  "M5.W.1"  'description  "Minimum M5 Width" )
     ( minSpacing                 "M5"	8.0   'ref  "M5.S.1"  'description  "Minimum M5 Space" )
    ) ;spacings
  
    orderedSpacings(

    ) ;orderedSpacings
  ) ;foundry

) ;constraintGroups

;********************************
; VIASPECS
;********************************

viaSpecs(
 ;(layer1  layer2  (viaDefName ...) 
 ;   [(        
 ;	(layer1MinWidth layer1MaxWidth layer2MinWidth layer2MaxWidth 
 ;            (viaDefName ...)) 
 ;	...         
 ;   )])       
 ;( ------------------------------------------------------------------------ ) 
   ( MC  M2  ("M2_MC")
   )
   ( M1  M2  ("M2_M1")
   )
   ( M2  M3  ("M3_M2")
   )
   ( M3  M4  ("M4_M3")
   )
   ( M5  M4  ("M5_M4")
   )
) ;viaSpecs