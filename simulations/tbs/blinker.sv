module blinker #(
	parameter OUTPUT_WIDTH = 4
) 
(
	input                           clk,
	output [OUTPUT_WIDTH-1:0]       out 
);
    reg [OUTPUT_WIDTH-1:0] seed = 0;

    assign out = seed;
    
    always @(posedge clk) begin
	    seed <= ~seed;
    end

endmodule