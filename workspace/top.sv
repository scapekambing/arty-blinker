module top (
    input               clk, // defined in contraints file
    input       [3:0]   SW,
    output reg  [3:0]   LED
);
    reg [3:0]   sequence_0, 
                sequence_1, 
                sequence_2, 
                sequence_3, 
                sequence_4;

    cycle mode_0 (
        .clk(clk),
        .out(sequence_0)
    );
    
    lfsr mode_1 (
        .clk(clk),
        .out(sequence_1)
    );

    blinker mode_2 (
        .clk(clk),
        .out(sequence_2)
    );
    
    looper mode_3 (
        .clk(clk),
        .out(sequence_3)
    );

    cycle_v2 mode_4 (
        .clk(clk),
        .out(sequence_4)
    );

    // Conditional assignment based on mode_0.enable
    always @(*) begin
        case (SW[2:0])
            3'b000: LED <= sequence_0;
            3'b001: LED <= sequence_1;
            3'b010: LED <= sequence_2;
            3'b011: LED <= sequence_3;
            3'b100: LED <= sequence_4;
            3'b101: LED <= SW;
            3'b110: LED <= SW;
            3'b111: LED <= SW;
        endcase
    end
    
endmodule
