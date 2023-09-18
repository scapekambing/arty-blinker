`timescale 1ns/1ns

`include "vunit_defines.svh"

module tb_vunit_blinker;
    parameter OUTPUT_WIDTH = 4;

    integer i = 0;

    wire [OUTPUT_WIDTH-1:0] out;
    reg clk = 1'b0;

    reg [OUTPUT_WIDTH-1:0] check = 4'b0000;

    localparam clk_period = 10;
    always begin
        #(clk_period/2) clk <= ~clk;
    end

    // Instantiate a blinker
    blinker #(
        .OUTPUT_WIDTH(OUTPUT_WIDTH)
    ) 
    dut (
        .out(out),
        .clk(clk)
    );

    `TEST_SUITE begin 
        `TEST_CASE("sanity") begin
            $display("This test case is expected to pass");
            `CHECK_EQUAL(1, 1, "woo!");
        end
        `TEST_CASE("operation") begin
            $monitor("time=%0t, clk=%b, out=%b", $time, clk, out);
            for (i = 0; i < 10; i = i + 1) begin
                #(clk_period);
                check = ~check;
                `CHECK_EQUAL(out, check);
            end

        end
    end

endmodule
