`timescale 1ns/1ns

module tb_lfsr;

    parameter U_BITS = 4;

    integer i;

    reg clk;
    wire [U_BITS-1:0] out;
    reg enb;
    reg rst;

    wire [U_BITS-1:0] seed_val; 
    assign seed_val = 4'b0100;  // Initialize seed_val

    blinky # (.OUTPUT_WIDTH(U_BITS)) dut (
        .out(out),
        .clk(clk),
        .rst(rst),
        .enb(enb),
        .seed(seed_val)
    );

    localparam clk_period = 10;
    always begin
        #(clk_period/2) clk = ~clk;
    end

    initial begin
        $monitor("time=%0t, clk=%b, out=%b", $time, clk, out);
        clk = 0;
	enb = 1;
	rst = 0;
        for (i = 0; i < 10; i = i + 1) begin
            #(clk_period);
        end
    end

endmodule
