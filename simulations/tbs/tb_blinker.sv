`timescale 1ns/1ns

module tb_blinker();

	parameter OUTPUT_WIDTH = 4;
    integer i;

	reg clk = 0;;
	wire [OUTPUT_WIDTH-1:0] out;

    blinker #(
	.OUTPUT_WIDTH(OUTPUT_WIDTH)
	)
	blinker_inst (
        .out(out),
        .clk(clk)
    );

    localparam clk_period = 10;
    always begin
        #(clk_period/2) clk = ~clk;
    end

    initial begin
        $monitor("time=%0t, clk=%b, out=%b", $time, clk, out);
        for (i = 0; i < 10; i = i + 1) begin
            #(clk_period);
        end
        $finish;
    end

endmodule
