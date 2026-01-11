/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP2
// Date      : Tue Dec 23 10:46:53 2025
/////////////////////////////////////////////////////////////


module half_adder ( CLK, reset, in1, in2, sum, cout );
  input CLK, reset, in1, in2;
  output sum, cout;
  wire   n6, n7, n8, n9, n10, n11;

  \**FFGEN**  sum_reg ( .next_state(n7), .clocked_on(CLK), .force_00(1'b0), 
        .force_01(1'b0), .force_10(1'b0), .force_11(1'b0), .Q(sum), .QN() );
  \**FFGEN**  cout_reg ( .next_state(n6), .clocked_on(CLK), .force_00(1'b0), 
        .force_01(1'b0), .force_10(1'b0), .force_11(1'b0), .Q(cout), .QN() );
  NOR2D1 U10 ( .IN1(in2), .IN2(in1), .OUT(n10) );
  INVD1 U11 ( .IN(reset), .OUT(n8) );
  NAND2D1 U12 ( .IN1(in2), .IN2(in1), .OUT(n11) );
  NAND2D1 U13 ( .IN1(n8), .IN2(n11), .OUT(n9) );
  NOR2D1 U14 ( .IN1(n10), .IN2(n9), .OUT(n7) );
  NOR2D1 U16 ( .IN1(reset), .IN2(n11), .OUT(n6) );
endmodule

