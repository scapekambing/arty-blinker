module lfsr # (

    // Parameters 
    parameter                       COUNT_WIDTH = 32,
    parameter   [COUNT_WIDTH-1:0]   MAX_COUNT = 25_000_000,
    parameter                       OUTPUT_WIDTH = 4
)(
    input                           clk,
    //input                           enable,
    output reg  [OUTPUT_WIDTH-1:0]  out 
);
    wire feedback;
    reg [COUNT_WIDTH-1:0] counter;

    assign feedback = ~(out[3] ^ out[2]);
    
    always @(posedge clk) begin
        //if (enable) begin
            if (counter < MAX_COUNT) // 250 ms delay at 100 MHz clock
                counter <= counter + 1;
            else begin
                counter <= 0;
                out <= {out[2:0], feedback};
            end
        //end 
    end       
endmodule