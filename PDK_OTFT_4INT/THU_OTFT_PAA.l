
*************************************************************
*** EsimFPD Model ver: 2020.10                            ***
***       Built at: 12/10/2020 16:11                      ***
***   (C) Copyright 2020 Huada Empyrean Software Co.      ***
***   THU_OTFT_PAA_260111                                 ***
*************************************************************
.LIB ptft_model

.model ptft_model pmos
+ level= 62             
+ version= 1              
+ capmod= 0              
+ shmod= 0              
+ isubmod= 0              
+ idsmod= 1              
+ vtmod= 1              
+ diblmod= 1              
+ acm= 0              
+ wmin= 0.0015         
+ wmax= 0.0015         
+ lmin= 5e-05          
+ lmax= 5e-05          
+ zeroc= 0              
+ cornermod= 0              
+ binmod= 0              
+ tox= 1e-07 /2.3         
+ eps= 11.7           
+ epsi= 2.82           
+ ld= 0              
+ wd= 0              
+ ldif= 0              
+ hdif= 0              
+ wmlt= 1              
+ lmlt= 1              
+ xw= 0              
+ xl= 0              
+ xj= 1.5e-07        
+ del= 0              
+ vto= -1.31228       
+ von= 0              
+ vfb= 0.183588       
+ vsi= 4.16898        
+ vst= 9.54391        
+ at= 2.31464e-08    
+ bt= 1.499e-06      
+ dvt= 0.0964         
+ cgso= 0              
+ cgdo= 0              
+ etac0= 7              
+ etac00= 0              
+ mc= 3              
+ kss= 0              
+ rsx= 0              
+ rdx= 0              
+ eta= 8.95259        
+ delta= 10.5331        
+ mus= 0.224589       
+ mu0= 2.83273        
+ mu1= 0.0027731      
+ mmu= 1.10314        
+ meta= 1              
+ theta= 8.2e-10        
+ ad= 1.99845e+06    
+ ag= 8.60898e+06    
+ dd= 5.00388e-07    
+ dg= 1.16158e-07    
+ blk= 9.33052e-05    
+ i0= 1.38321        
+ eb= 2              
+ i00= 150            
+ alphasat= 1.1705         
+ lasat= 3.04743e-07    
+ me= 2.5            
+ mss= 3              
+ vmax= 32800          
+ lambda= 0.0259748      
+ ls= 3.5e-08        
+ vp= 0.2            
+ lkink= 2.72841e-05    
+ mk= 1.34677        
+ vkink= 24.6571        
+ tnom= 27             
+ dvto= 0              
+ dmu1= 0              
+ dasat= 0              
+ kt1= 0              
+ teta= 0              
+ ute= 0              
+ mus1= 0              
+ vat= 0              
+ kat= 0              
+ kbt= 0              
+ prt= 0              
+ kasat= 0              
+ ki0= 0              
+ ki00= 0              
+ rth0= 0              
+ cth0= 0              
+ intdsnod= 0              
+ rsh= 0              
+ rd= 0              
+ rs= 0              
+ rdc= 0              
+ rsc= 0              

************************************************************
****                                     Data        Model
**** Eff. Mobility(cm2/volt/sec)     0.264539     0.375025
****                      Vth(V)     -1.47456     -1.53769
****  Sub-Threshold Slope(V/dec)     0.461732     0.556681
****          Ion(A) @ Vgs = 10V  9.29857e-06  1.20304e-05
****        Ioff(A) @ Vgs = -10V   1.1472e-11    5.706e-12
************************************************************

.ENDL ptft_model


.LIB ptft

.param a_vthmisp=0 a_mumisp=0 dvthp=0 dmup=0

.subckt ptft n1 n2 n3 w=w l=l
.param vthmisp='a_vthmisp*sqrt(10u*4u)/sqrt(w*l)' 
+ mumisp='a_mumisp*sqrt(10u*4u)/sqrt(w*l)'
main n1 n2 n3 ptft_model w=w l=l
.lib "THU_OTFT_PAA.l" ptft_model
.ends ptft

.ENDL ptft


.LIB ptft_mac

.lib "THU_OTFT_PAA.l" ptft

.param
+dvthp=agauss(0,1,3) dmup=agauss(0,5,3)
+a_vthmisp=agauss(0,0.1,3) a_mumisp=agauss(0,0.5,3)

.ENDL ptft_mac
