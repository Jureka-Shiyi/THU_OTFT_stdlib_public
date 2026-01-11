; Technology File 2021_Q4MPG_THU_20220105_check
; Generated on Aug 23 09:51:34 2022
;     with @(#)$CDS: virtuoso version 6.1.7-64b 12/16/2018 07:36 (sjfhw317) $


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
  ( M1                        5          M1           )
  ( M1d                       95         M1d          )
  ( MC                        1          MC           )
  ( Via1                      3          Via1         )
  ( M2                        4          M2           )
  ( M2d                       94         M2d          )
  ( SU8                       6          SU8          )
  ( Text                      2          Text         )
  ( PTFT                      90         PTFT         )
 ) ;techLayers

; techLayers(
 ;( LayerName                 Layer#     Abbreviation )
 ;( ---------                 ------     ------------ )
 ;User-Defined Layers:
;  ( MC                        1          MC           )
;  ( Text                      2          Text         )
;  ( Via1                      3          Via1         )
;  ( M2                        4          M2           )
;  ( M1                        5          M1           )
;  ( SU8                       6          SU8          )
;  ( M2d                       94         M2d          )
;  ( M1d                       95         M1d          )
;  ( PTFT                      90         PTFT         )
; ) ;techLayers

 techLayerPurposePriorities(
 ;layers are ordered from lowest to highest priority
 ;( LayerName                 Purpose    )
 ;( ---------                 -------    )
  ( M1                        drawing    )
  ( M1                        grid       )
  ( M1                        track      )
  ( M1                        blockage   )
  ( M1d                       drawing    )
  ( M1d                       grid       )
  ( M1d                       track      )
  ( M1d                       blockage   )
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
  ( M2d                       drawing    )
  ( M2d                       grid       )
  ( M2d                       track      )
  ( M2d                       blockage   )  
  ( SU8                       drawing    )
  ( SU8                        grid       )
  ( SU8                        track      )
  ( SU8                        blockage   )  
;  ( Text                      drawing    )
  ( Text                      boundary   )  
  ( PTFT                      drawing    )
  ( M1                        pin        )
  ( MC                        pin        )
  ( Via1                      pin        )
  ( M2                        pin        )
  ( SU8                       pin        )  
 ) ;techLayerPurposePriorities

 techDisplays(
 ;( LayerName    Purpose      Packet          Vis Sel Con2ChgLy DrgEnbl Valid )
 ;( ---------    -------      ------          --- --- --------- ------- ----- )
  ( M1           drawing      M1_drawing       t t t t t )
  ( M1           track        M1_drawing       nil nil t t nil )
  ( M1           grid         M1_grid          t nil nil nil nil )
  ( M1           blockage     M1_blockage      t nil t t nil )  
  ( M1d          drawing      M1d_drawing      t t t t t )
  ( M1d           track        M1_drawing       nil nil t t nil )
  ( M1d           grid         M1_grid          t nil nil nil nil )
  ( M1d           blockage     M1_blockage      t nil t t nil )  
  ( MC           drawing      MC_drawing       t t t t t )
  ( MC           track        M1_drawing       nil nil t t nil )
  ( MC           grid         M1_grid          t nil nil nil nil )
  ( MC           blockage     M1_blockage      t nil t t nil )
  ( Via1         drawing      Via1_drawing     t t t t t )
  ( Via1           track        M1_drawing       nil nil t t nil )
  ( Via1           grid         M1_grid          t nil nil nil nil )
  ( Via1           blockage     M1_blockage      t nil t t nil )   
  ( M2           drawing      M2_drawing       t t t t t )
  ( M2           track        M1_drawing       nil nil t t nil )
  ( M2           grid         M1_grid          t nil nil nil nil )
  ( M2           blockage     M1_blockage      t nil t t nil )    
  ( M2d          drawing      M2d_drawing      t t t t t )
  ( M2d           track        M1_drawing       nil nil t t nil )
  ( M2d           grid         M1_grid          t nil nil nil nil )
  ( M2d           blockage     M1_blockage      t nil t t nil )   
  ( SU8          drawing      SU8_drawing      t t t t t )
  ( SU8           track        M1_drawing       nil nil t t nil )
  ( SU8           grid         M1_grid          t nil nil nil nil )
  ( SU8           blockage     M1_blockage      t nil t t nil )  
  ( M1           pin          M1_pin           t t t t t )
  ( MC           pin          MC_pin           t t t t t )
  ( Via1         pin          Via1_pin         t t t t t )
  ( M2           pin          M2_pin           t t t t t )
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
  ( M1                        "metal"    5            )
  ( M1d                       "pseudoMetal"   95           )
  ( MC                        "pseudoMetal"   1           )
  ( Via1                      "cut"      3            )
  ( M2                        "metal"    4            )
  ( M2d                       "pseudoMetal"   94           )
  ( SU8                       "passivationCut"      6           )
 ) ;functions

 routingDirections(
 ;( layer                       direction     )
 ;( -----                       ---------     )
  ( M1                       	"horizontal")
  ( M1d                       	"none"      )
  ( MC                       	"none"      )
  ( M2                       	"vertical"  )
  ( M2d                       	"none"      )
 ) ;routingDirections 

 stampLabelLayers(
 ;( textLayer   layers        )
 ;( ---------   ----------------------------------        )
  ( ("M1" "pin")	M1         )
  ( ("MC" "pin")	MC         )
  ( ("M2" "pin")	M2         )
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
  ( M2_MC     	MC     M2     	("Via1" 8.0 8.0 5.0)
     (1 1 (5.0 5.0))
     (6.0 6.0)	(6.0 6.0)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
  )
  ( M2_M1     	M1     M2     	("Via1" 8.0 8.0 5.0)
     (1 1 (5.0 5.0))
     (6.0 6.0)	(6.0 6.0)	(0.0 0.0)	(0.0 0.0)	(0.0 0.0)
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
     ( validLayers   (M1  MC  M2  ) )
     ( validVias     (M2_M1  M2_MC  ) )
    ) ;interconnect

  ) ;virtuosoDefaultSetup

 ;( group	[override]	[definition]	[operator] )
 ;( -----	----------	------------	---------- )
  ( "virtuosoDefaultExtractorSetup"	nil

    interconnect(
     ( validLayers  ( ( M1  drawing) ( M1  pin) ( Via1  drawing) ( Via1  pin) ( MC  drawing) ( MC  pin) ( M2  drawing) ( M2  pin) ) )
     ( validVias     (M2_M1 M2_MC  ) )
    ) ;interconnect

  ) ;virtuosoDefaultExtractorSetup

 ;( group	[override]	[definition]	[operator] )
 ;( -----	----------	------------	---------- )
  ( "VLMDefaultSetup"	nil

    interconnect(
     ( validLayers   (M1  M2  MC   ) )
     ( validVias     (M2_M1  M2_MC    ) )

    ) ;interconnect

  ) ;VLMDefaultSetup

 ;( group	[override]	[definition]	[operator] )
 ;( -----	----------	------------	---------- )
  ( "LEFDefaultRouteSpec"	nil    "LEFDefaultRouteSpec"

    interconnect(
     ( validLayers   (M1  M2  ) )
     ( validVias     (M2_M1   ) )
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
) ;viaSpecs