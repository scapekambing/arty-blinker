module blinker # (

    // Parameters 
    parameter                       COUNT_WIDTH = 32,
    parameter   [COUNT_WIDTH-1:0]   MAX_COUNT = 25_000_000,
    parameter                       OUTPUT_WIDTH = 4
)(
    input                           clk,
    //input                           enable,
    output    [OUTPUT_WIDTH-1:0]    out 
);
    reg [COUNT_WIDTH-1:0] counter;
    reg [OUTPUT_WIDTH-1:0] seed;

    assign out = seed;
    
    always @(posedge clk) begin
        //if (enable) begin
            if (counter < MAX_COUNT) // 250 ms delay at 100 MHz clock
                counter <= counter + 1;
            else begin
                counter <= 0;
                seed <= ~seed;
            end
        //end 
    end       
endmodule