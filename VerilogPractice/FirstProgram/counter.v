//-----------------------------------------------------
// This is my second Verilog Design
// Design Name : first_counter
// File Name : first_counter.v
// Function : This is a 4 bit up-counter with
// Synchronous active high reset and
// with active high enable signal
//-----------------------------------------------------

module counter (
  clk,	
	reset,
	enable,
	count_out);
  
  // Input ports
  input clk, reset, enable;

  // Output ports
  output [3:0] count_out;

  // By rule, all input ports should be wires
  wire clk;
  wire reset;
  wire enable;

  // All outputs sould be storage elements (reg) or wires
  reg [3:0] count_out;

  always @(posedge clk) begin
    if (reset == 1'b1) begin
    	count_out <= 4'b0000;
    end else if (enable == 1'b1) begin
      count_out <= count_out + 1;
    end 
  end
endmodule 