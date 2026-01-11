* File: OR2D1.cdl.OR2D1.pxi
* Created: Wed Jan 15 19:04:35 2025
* 
x_PM_OR2D1%net12 N_net12_MI3_d N_net12_MI4_d N_net12_MI6_d N_net12_MI7_g
+ N_net12_c_2_p N_net12_c_9_p N_net12_c_3_p N_net12_c_4_p N_net12_MI5_g
+ N_net12_c_13_p N_net12_c_7_p N_net12_c_15_p PM_OR2D1%net12
x_PM_OR2D1%IN1 N_IN1_MI3_g N_IN1_MI0_g IN1 N_IN1_c_47_n N_IN1_c_50_n
+ PM_OR2D1%IN1
x_PM_OR2D1%IN2 N_IN2_MI4_g N_IN2_MI6_g IN2 N_IN2_c_67_n N_IN2_c_70_n
+ PM_OR2D1%IN2
x_PM_OR2D1%VSS N_VSS_MI3_s N_VSS_MI4_s N_VSS_MI5_s VSS PM_OR2D1%VSS
x_PM_OR2D1%VDD N_VDD_MI0_s N_VDD_MI7_s VDD PM_OR2D1%VDD
x_PM_OR2D1%OUT N_OUT_MI7_d N_OUT_MI5_d OUT PM_OR2D1%OUT
cc_1 N_net12_MI3_d IN1 1.22113f
cc_2 N_net12_c_2_p IN1 0.137416f
cc_3 N_net12_c_3_p IN1 0.0510617f
cc_4 N_net12_c_4_p IN1 0.0490198f
cc_5 N_net12_MI3_d N_IN1_c_47_n 1.63897f
cc_6 N_net12_MI5_g N_IN1_c_47_n 0.0287599f
cc_7 N_net12_c_7_p N_IN1_c_47_n 0.0420803f
cc_8 N_net12_c_2_p N_IN1_c_50_n 0.094835f
cc_9 N_net12_c_9_p N_IN1_c_50_n 0.0058638f
cc_10 N_net12_MI3_d IN2 0.974371f
cc_11 N_net12_c_3_p IN2 0.0896537f
cc_12 N_net12_c_4_p IN2 0.362929f
cc_13 N_net12_c_13_p IN2 0.129161f
cc_14 N_net12_c_7_p IN2 2.04275f
cc_15 N_net12_c_15_p IN2 0.456731f
cc_16 N_net12_MI3_d N_IN2_c_67_n 1.63897f
cc_17 N_net12_c_3_p N_IN2_c_67_n 0.129161f
cc_18 N_net12_c_7_p N_IN2_c_67_n 0.14326f
cc_19 N_net12_c_3_p N_IN2_c_70_n 0.0648309f
cc_20 N_net12_MI5_g N_IN2_c_70_n 0.266153f
cc_21 N_net12_c_7_p N_IN2_c_70_n 0.162533f
cc_22 N_net12_c_15_p N_IN2_c_70_n 1.79602f
cc_23 N_net12_c_15_p N_VSS_MI4_s 0.697454f
cc_24 N_net12_c_3_p N_VSS_MI5_s 0.123547f
cc_25 N_net12_MI5_g N_VSS_MI5_s 3.60893f
cc_26 N_net12_MI3_d VSS 0.713736f
cc_27 N_net12_c_7_p VSS 0.268772f
cc_28 N_net12_MI3_d N_VDD_MI0_s 0.0827796f
cc_29 N_net12_c_9_p N_VDD_MI7_s 2.16793f
cc_30 N_net12_c_3_p N_VDD_MI7_s 0.393449f
cc_31 N_net12_MI5_g N_VDD_MI7_s 0.025847f
cc_32 N_net12_c_15_p N_VDD_MI7_s 0.248077f
cc_33 N_net12_c_7_p VDD 0.248077f
cc_34 N_net12_MI3_d OUT 0.0662048f
cc_35 N_net12_c_2_p OUT 0.511403f
cc_36 N_net12_c_9_p OUT 1.71187f
cc_37 N_net12_c_3_p OUT 0.560499f
cc_38 N_net12_c_4_p OUT 1.06248f
cc_39 N_net12_MI5_g OUT 3.45873f
cc_40 N_net12_c_15_p OUT 0.775786f
cc_41 N_net12_MI3_d net11 0.634665f
cc_42 N_net12_c_2_p net11 0.110179f
cc_43 IN1 IN2 0.404101f
cc_44 IN1 N_IN2_c_67_n 0.202189f
cc_45 N_IN1_c_47_n N_IN2_c_67_n 0.436026f
cc_46 N_IN1_c_50_n N_IN2_c_67_n 0.608536f
cc_47 N_IN1_c_47_n N_IN2_c_70_n 0.260254f
cc_48 N_IN1_c_47_n VSS 2.09409f
cc_49 N_IN1_c_50_n N_VDD_MI0_s 2.21227f
cc_50 IN1 net11 0.474123f
cc_51 N_IN1_c_50_n net11 1.49291f
cc_52 N_IN2_c_70_n N_VSS_MI4_s 1.78589f
cc_53 N_IN2_c_70_n VSS 0.452974f
cc_54 N_IN2_c_70_n N_VDD_MI7_s 0.00237668f
cc_55 N_IN2_c_67_n VDD 0.143842f
cc_56 N_IN2_c_67_n net11 1.49291f
cc_57 VSS N_VDD_MI0_s 0.198406f
cc_58 N_VSS_MI5_s N_VDD_MI7_s 0.396813f
cc_59 N_VSS_MI4_s VDD 0.198406f
cc_60 N_VSS_MI5_s OUT 1.43712f
cc_61 VSS net11 0.077912f
cc_62 N_VDD_MI7_s OUT 1.33139f
cc_63 N_VDD_MI0_s net11 0.647451f
cc_64 OUT net11 0.19343f
