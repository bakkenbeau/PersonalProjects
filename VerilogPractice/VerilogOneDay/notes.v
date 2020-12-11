// Notes for Verilog

// Top of file
module arbiter (
	clock,
	reset,
	req_0,
	req_1,
	gnt_0,
	gnt_1
);

	input clock;
	input reset;
	input req_0;
	input req_1;
	output gnt_0;
	output gnt_1;

	// --

endmodule

// Driver
// Data type that can drive a load
// 1. flip-flop
reg [7:0] address_bus;
// 2. Wire
wire and_gate_out;

// For simualtion purposes only. Will always run first at time 0
initial begin
	clk = 0;
	reset = 0;
	req_0 = 0;
	req_1 = 0;
end

// Combinitorial logic can be modeled using assign and always statements
// When alwasy is used for comb. logic, must use the "=" operator. 
// This acts as a blocking assignment which executes code sequentially
always @(a or b or sel) // Considered level-sensitive sensitivity list since it contains only comb. logic
	begin
		y = 0;
		if (sel == 0) begin
			y = a;
		end else begin 
			y = b;
		end 
	end 

// Models comb. logic
// Continuous assign statement
assign out = (enable) ? data : 1'bZ; // Simple tri-state buffer
assign out = data;

// Sequential logic can only be modeled with always statement
// Uses <= operator, a non-blocking assignment. Will execute code in parallel btwn begin/end
always @(posedge clk) begin // Considered edge-sensitive sensitivty list
	if (rst == 0) begin
		y <= 0;
	end else if (sel == 0) begin
		y <= a;
	end else begin
		y <= b;
	end

// Can have always block w/o sens. list, but must start with a delay
always begin
	#5 clk = ~clk;
end

// Functions (Same structure for Tasks)
// Cannot have delays, but Tasks can
// Can return a value, but Tasks cannot
function parity;
	input [31:0] data;
	integer i;
	begin
		parity = 0;
		for (i = 0; i < 32; i = i + 1) begin
			parity = parity ^ data[i];
		end 
	end 
endfunction

// Behavior Models: Higher level of modeling where behavior of logic is modeled
// RTL Models: Logic is modeled at register level
// Structural Models: Logic is modeled at bother register level and gate level

// Procedural Blocks
// 1) initial
// 2) always

module example_always(
	clock,
	reset,
	enable
	q_in,
	data);
	
	reg clk, reset, enable. q_in, data;

	always @(posedge clk) begin
		if (reset) begin
			data <= 0;
		end else if (enable) begin
			data <= q_in;
		end
	end 

endmodule 


// **** Procedural assignment statements assign values to reg, integer, real or time variables
// **** and not to nets (wire data types)
// You may assign a net to a register however
// Bad
module initial_bad();
	reg clk, reset;
	wire enable, data;

	initial begin
		clk = 0;
		reset = 0;
		enable = 0;
		data = 0;
	end
endmodule 

// Good
module initial_good();
	reg clk, reset, enable, data;

	initial begin
		clk = 0;
		reset = 0;
		enable = 0;
		data = 0;
	end
endmodule 

// Blocking vs. Nonblocking
module blocking_nonblocking();
	reg a, b, c,d;

	// Blocking examples
	initial begin
		#10 a = 0;
		#11 a = 1;
		#12 a = 0;
		#13 a = 1;
	end
    // <--- These are the same --->
	initial begin
		b = #10 0;
		b = #11 1;
		b = #12 0;
		b = #13 1;
	end 

	// Nonblocking examples
	initial begin
		#10 c <= 0;
		#11 c <= 1;
		#12 c <= 0;
		#13 c <= 1;
	end
    // <--- These are not the same --->
	initial begin	// Behaves as how I would expect
		d <= #10 0; // T = 10: d = 0
		d <= #11 1; // T = 11: d = 1
		d <= #12 0; // T = 12: d = 1
		d <= #13 1; // T = 13: d = 0
	end
endmodule 

// Procedural assignment
// 1) assign
// 2) deassign

// Module instantion -- 2 types --
module mod1(input a, b, output f);
	// ...
endmodule
// By order
module mod2 (input c, d, output g);
	mod1 i0(c, d, g);
endmodule
// By name
module mod3 (input c, d, output g);
	mod1 i0(.f(g), .b(d), .a(g));
endmodule

// Continuous assignment
module mux2(a, b, sel, f);
	output f;
	input a, b, sel;

				 // Enahnce data type instead of wire or reg
	logic c, d;  // <- Only values '0', '1'

	assign c = a & (~sel);
	assign d = b & sel;
	assign f = c | d;

	// Alternatively
	assign f = sel ? b : a;

	// Combinational Procedural Block
	always_comb begin
		// Comb. logic described
	end 
	// All of them in a module are independent and parallel to each other

	// IMPORTANT: If you are using this, must make output value "output logic f"
	always_comb begin
		if (sel == 0) begin
			f = a;
		end else begin
			f = b;
		end 
	end
endmodule 

// Constants and Concatentation
logic [3:0] a, b, c;
assign a = 1'b0010;		// == 0010
assign b = 1'hC;		// == 1100
assign c = 3;			// == 0011

logic signed [3:0] d;
assign d = -2;			// 2's complement == 1100

logic [7:0] e;
logic [1:0] f;
assign e = {a,b};		// == 0010_1100
assign f = a[2:1];		// == 01

// Sequential Logic Description
// i.e FFs, registers, FSMs
always_ff @(posedge clk) begin // <- Indicated that block with be sequential (FF)
	// Use wiht nonblocking assignment "<="
end

// Aother common implementation
always_ff @(posedge clk, negedge reset_n) begin

end

// Flip-flop
module ff (d_single, d_mult, q_single, q_mult, clk);
	input d_single, clk;
	output logic q_single; // <---- REMEMBER IF USING ENHANCED ALWAYS NEED TO MAKE LOGIC

	input [7:0] d_mult;
	output logic [7:0] q_mult; // <---- REMEMBER IF USING ENHANCED ALWAYS NEED TO MAKE LOGIC

	always_ff @(posedge clk) begin
		q_single <= d_single;
		q_mult 	 <= d_mult;
	end
endmodule

// Parameters
module my_flipflop(d, q, clk, rst_n);
	parameter WIDTH = 16;
	input [WIDTH-1:0] d;
	input clk, reset_n;
	output logic [WIDTH-1:0] q;

endmodule 
// How to instantiate
my_flipflop f0(d, q, clk, rst_n); // Uses the defaults values
my_flipflop #(12) f0(d, q, clk, rst_n); // Chnages paramter to 12 for this instance

// Blocking vs Nonblocking .. again
// Nonblocking (synchronous)
always_ff @(posedge clk) begin
	b <= a;
	c <= b;
end

// Blocking (asynchronous)
always_comb begin
	b = a;
	c = b;
end 

// FSM example
module fsm(clk, rst, x, y);
	input clk, rst, x;
	output logic [1:0] y;
	enum { STATEA = 2'b00, STATEB = 2'b01, STATEC = 2'b10, 
		   STATED = 2'b11} state, next_state;

	// register
	always_ff @(posedge clk) begin
		if (rst) begin
			state <= STATEA;
		else
			state <= next_state;
		end
	end

	// next-state logic
	always_comb begin
		case(state)
			STATEA: next_state = x ? STATEB : STATEA;
			STATEB: next_state = x ? STATEC : STATED;
			STATEC: next_state = x ? STATED : STATEA;
			STATED: next_state = x ? STATEC : STATEB;
		endcase
	end

	 // output logic
	 always_comb begin
	 	case(state)
	 		STATEA: y = 2'b00;
	 		STATEB: y = 2'b00;
	 		STATEC: y = 2'b11;
	 		STATED: y = 1'b10;
	 	endcase
	 end 
endmodule

// Arrays
logic [3:0] myarray [2:0]; // 3 element array of 4 bit values
$display("myarray[1][1:0] = %b", myarray[2][1:0]);

// Assertions
// Test constructs that are automatically validatred as design is simulated