module counter_tb;

	// Testbench needs to consist of clock generator, reset
	// control, enable control, and monitor/checker logic
	
	// Declare inputs to DUT as regs and outputs of DUT as wires
	reg clk, reset, enable;
	wire [3:0] counter_out;

	// Initialize all variables
	initial begin
		$display("time\t clk reset enable counter");
		$monitor("%g\t %b   %b     %b      %b", 
  	  		$time, clk, reset, enable, counter_out);

		clk = 1;
		reset = 0;
		enable = 0;

		#5 reset = 1; // True for half cycle since the clock period is #10 time units
		#10 reset = 0; // True and blocks for a whole clock cycle before going to next line
		#10 enable = 1;
		#100 enable = 0;
		#5 $finish;
	end

	// Clock generator
	always begin
		#5 clk = ~clk;
	end
	// Connect DUT to testbench
	counter DuT (
		clk,
		reset,
		enable,
		counter_out);

endmodule 