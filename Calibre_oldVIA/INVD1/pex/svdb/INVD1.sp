* SPICE NETLIST
***************************************

.SUBCKT INVD1 VSS VDD OUT IN
** N=5 EP=4 IP=0 FDC=6
M0 VSS VSS 1 ptft L=4e-05 W=0.0001 $X=-46900 $Y=-172000 $D=0
M1 1 IN VDD ptft L=1e-05 W=0.0002 $X=-46900 $Y=108000 $D=0
M2 VSS 1 OUT ptft L=1e-05 W=0.0002 $X=123100 $Y=-292000 $D=0
M3 VDD IN OUT ptft L=1e-05 W=0.0002 $X=123100 $Y=108000 $D=0
M4 OUT 1 VSS ptft L=1e-05 W=0.0002 $X=173100 $Y=-292000 $D=0
M5 OUT IN VDD ptft L=1e-05 W=0.0002 $X=173100 $Y=108000 $D=0
.ENDS
***************************************
