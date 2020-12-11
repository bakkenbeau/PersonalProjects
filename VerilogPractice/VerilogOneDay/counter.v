module counter (clk, rst, enable, count)
	input clk, rst, enable;
	otuput [3:0] count;
	reg    [3:0] count;

	always @ (posedge clk or posedge rst)
		if (rst) begin
			count <= 0;
		end else begin
			while (enable) begin
				count <= count + 1;
			end 
		end 
endmodule