module top (
    input               clk, // defined in contraints file
    input       [3:0]   sw,
    output      [3:0]   led
);
    wire[3:0]   sequence_0, 
                sequence_1, 
                sequence_2, 
                sequence_3, 
                sequence_4;

    reg [3:0]   seq;

    assign led = seq;

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
        case (sw[2:0])
            3'b000: seq <= sequence_0;
            3'b001: seq <= sequence_1;
            3'b010: seq <= sequence_2;
            3'b011: seq <= sequence_3;
            3'b100: seq <= sequence_4;
            3'b101: seq <= sw;
            3'b110: seq <= sw;
            3'b111: seq <= sw;
        endcase
    end
    
endmodule
