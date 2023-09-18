`timescale 1ns/1ns

`include "vunit_defines.svh"

`define SEED_VAL 4'b0000;

module tb_vunit_lfsr;
    parameter U_BITS = 4;

    integer i = 0;

    wire [U_BITS-1:0] out;
    reg clk;
    reg rst;
    reg enb;


    logic [U_BITS-1:0] seed = `SEED_VAL;

    localparam clk_period = 10;

    always begin
        #(clk_period/2) clk = ~clk;
    end

    // Instantiate an LFSR
    lfsr # (.OUTPUT_WIDTH(U_BITS)) 
        dut (
            .out(out),
            .clk(clk),
            .rst(rst),
            .enb(enb),
            .seed(seed)
        );

    `TEST_SUITE begin
        
        `TEST_CASE("sanity") begin
            $display("This test case is expected to pass");
            `CHECK_EQUAL(1, 1, "woo!");
        end

        `TEST_CASE("test_clk") begin
            $monitor("time=%0t, clk=%b", $time, clk);
            clk = 0;
            #(clk_period/2);
            `CHECK_EQUAL(clk, 1);
            #(clk_period/2);
            `CHECK_EQUAL(clk, 0);
        end

        `TEST_CASE("test_seed") begin
            $monitor("time=%0t, clk=%b, enb=%b, rst=%b, seed=%b, out=%b", $time, clk, enb, rst, seed, out);
            clk = 0;
            enb = 1;
            rst = 0;
            #(clk_period);
            `CHECK_EQUAL(out, seed); // synchornous assignment
        end 

        `TEST_CASE("test_enb_off") begin
            $monitor("time=%0t, clk=%b, enb=%b, rst=%b, seed=%b, out=%b", $time, clk, enb, rst, seed, out);
            clk = 0;
            enb = 0;
            rst = 0;
            #(clk_period);
            `CHECK_EQUAL(out, 0);
            rst = 1; // rst should not have an effect
            #(clk_period);
            `CHECK_EQUAL(out, 0);
        end
        
        `TEST_CASE("test_reset") begin
            $monitor("time=%0t, clk=%b, enb=%b, rst=%b, seed=%b, out=%b", $time, clk, enb, rst, seed, out);
            for (i = 0; i < 10; i = i + 1) begin
                clk = 0;
                enb = 1;
                rst = 0;
                #(clk_period);
            end
            rst = 1;
            #(clk_period);
            `CHECK_EQUAL(out, seed); // synchronous reset
        end 

        `TEST_CASE("test_max_seq") begin
            $monitor("i=%d, time=%0t, clk=%b, enb=%b, rst=%b, seed=%b, out=%b", i, $time, clk, enb, rst, seed, out);
            for (i = 0; i < (2**U_BITS + 1); i = i + 1) begin
                clk = 0;
                enb = 1;
                rst = 0;
                #(clk_period);
            end
            `CHECK_EQUAL(out, seed); //  at 2 ^ n_bits - 1 clock cycles
        end 

    end

endmodule
