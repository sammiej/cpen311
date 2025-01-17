`default_nettype none
module ksa(

	//// CLOCK ////
   CLOCK_50,
	
	//// KEY ////
   KEY,    
	
	//// SWITCH ////
   SW,
	
	//// LED ////
   LEDR,
	LEDG,
	
	//// SEG7 ////
   HEX0,
   HEX1,
   HEX2,
   HEX3,
   HEX4,
   HEX5,
	
);

//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input                       CLOCK_50;

//////////// LED //////////
output           [17:0]      LEDR;
output 			  [7:0]		  LEDG;

//////////// KEY //////////
input            [3:0]      KEY;

//////////// SW //////////
input           [17:0]      SW;

//////////// SEG7 //////////
output           [6:0]      HEX0;
output           [6:0]      HEX1;
output           [6:0]      HEX2;
output           [6:0]      HEX3;
output           [6:0]      HEX4;
output           [6:0]      HEX5;

//=======================================================
//  REG/WIRE declarations
//=======================================================
// Input and output declarations
logic CLK_50M;
logic CLOCK_50;
logic [3:0] KEY;
logic [17:0] SW;
logic [6:0]  HEX0;
logic [6:0]  HEX1;
logic [6:0]  HEX2;
logic [6:0]  HEX3;
logic [6:0]  HEX4;
logic [6:0]  HEX5;
logic [7:0]  LEDG1;
logic [7:0]  LEDG2;
logic [7:0]  LEDG3;
logic [7:0]  LEDG4;
logic [7:0]  LEDG;
logic [17:0] LEDR1;
logic [17:0] LEDR2;
logic [17:0] LEDR3;
logic [17:0] LEDR4;
logic [17:0] LEDR;
logic [23:0] secret_key1;
logic [23:0] secret_key2;
logic [23:0] secret_key3;
logic [23:0] secret_key4;
logic [23:0] secret_key;
logic cracked1;
logic cracked2;
logic cracked3;
logic cracked4;
logic cracked;
logic stop;
assign CLK_50M = CLOCK_50;

//Control fsm
fsm_1 core1( .clk(CLK_50M), .LEDG(LEDG1), .LEDR(LEDR1), .secret_key(secret_key1), .cracked(cracked1), .stop(stop) );
fsm_2 core2( .clk(CLK_50M), .LEDG(LEDG2), .LEDR(LEDR2), .secret_key(secret_key2), .cracked(cracked2), .stop(stop) );
fsm_3 core3( .clk(CLK_50M), .LEDG(LEDG3), .LEDR(LEDR3), .secret_key(secret_key3), .cracked(cracked3), .stop(stop) );
fsm_4 core4( .clk(CLK_50M), .LEDG(LEDG4), .LEDR(LEDR4), .secret_key(secret_key4), .cracked(cracked4), .stop(stop) );

control_fsm control( .LEDG1(LEDG1), .LEDG2(LEDG2), .LEDG3(LEDG3), .LEDG4(LEDG4), 
									.LEDR1(LEDR1), .LEDR2(LEDR2), .LEDR3(LEDR3), .LEDR4(LEDR4),
									.secret_key1(secret_key1), .secret_key2(secret_key2), .secret_key3(secret_key3), .secret_key4(secret_key4), 
									.cracked1(cracked1), .cracked2(cracked2), .cracked3(cracked3), .cracked4(cracked4), 
									.LEDG(LEDG), .LEDR(LEDR), .secret_key(secret_key), .cracked(cracked), .stop(stop) );
									
//Hex display for secret_key
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst0(.ssOut(HEX0), .nIn(secret_key[3:0]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst1(.ssOut(HEX1), .nIn(secret_key[7:4]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst2(.ssOut(HEX2), .nIn(secret_key[11:8]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst3(.ssOut(HEX3), .nIn(secret_key[15:12]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst4(.ssOut(HEX4), .nIn(secret_key[19:16]));
SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst5(.ssOut(HEX5), .nIn(secret_key[23:20]));

endmodule
