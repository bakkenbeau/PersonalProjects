module memory_asyncread(clk, data_in, data_out,
					   r_addr, wr_addr, wr_en);
	
	parameter WIDTH = 16, LOGSIZE = 256;
	localparam SIZE=2**LOGSIZE; // Very similar to regular paramter, but cannot
								// be modified by instantion
	input clk;
	input wr_en;
	input [WIDTH-1:0] data_in;
	input [LOGSIZE-1:0] r_addr;
	input [LOGSIZE-1:0] wr_addr;	
	output logic [WIDTH-1:0] data_out; // <-- Will fail since ModelSim does not recognize logic
  //output wire [WIDTH-1:0] data_out;  // <-- Will work

	logic [WIDTH-1:0] mem [SIZE-1:0]; // <-- Will fail since ModelSim does not recognize logic
  //reg [WIDTH-1:0] mem [SIZE-1:0];   // <-- Will work

	assign data_out = mem[r_addr];

	always_ff @(posedge clk) begin // <-- Will fail since ModelSim does not recognize logic
  //always @(posedge clk) begin	   // <-- Will work
		if (wr_en) begin
			mem[wr_addr] <= data_in;
		end
	end 
endmodule 