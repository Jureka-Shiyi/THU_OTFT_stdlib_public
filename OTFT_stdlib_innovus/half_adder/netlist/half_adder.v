/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP2
// Date      : Mon Jan  5 20:46:01 2026
/////////////////////////////////////////////////////////////


module half_adder ( CLK, reset, in1, in2, sum, cout );
  input CLK, reset, in1, in2;
  output sum, cout;
  wire   N5, N6, n50, n60, n7, n8;

  DFFD1 sum_reg ( .D(N5), .CK(CLK), .Q(sum), .QN() );
  DFFD1 cout_reg ( .D(N6), .CK(CLK), .Q(cout), .QN() );
  NAND2D1 U9 ( .IN1(in2), .IN2(in1), .OUT(n50) );
  NOR2D1 U10 ( .IN1(reset), .IN2(n50), .OUT(N6) );
  INVD1 U11 ( .IN(reset), .OUT(n60) );
  NAND2D1 U12 ( .IN1(n60), .IN2(n50), .OUT(n8) );
  NOR2D1 U13 ( .IN1(in2), .IN2(in1), .OUT(n7) );
  NOR2D1 U14 ( .IN1(n8), .IN2(n7), .OUT(N5) );
endmodule

