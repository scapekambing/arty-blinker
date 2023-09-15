module looper # (

    // Parameters 
    parameter                       COUNT_WIDTH = 32,
    parameter   [COUNT_WIDTH-1:0]   MAX_COUNT = 25_000_000,
    parameter                       OUTPUT_WIDTH = 4
)(
    input                           clk,
    //input                           enable,
    output     [OUTPUT_WIDTH-1:0]  out 
);

    integer i;
    
    reg[OUTPUT_WIDTH-1:0] seed = 4'b0011;
    reg [COUNT_WIDTH-1:0] counter;
    assign out = seed;
    
    always @(posedge clk) begin
        //if (enable) begin
            if (counter < MAX_COUNT) // 250 ms delay at 100 MHz clock
                counter <= counter + 1;
            else begin
                counter <= 0;
                for (i=0; i<OUTPUT_WIDTH; i=i+1) begin
                    seed[i+1] <= seed[i];
                end
                seed[0] <= seed[OUTPUT_WIDTH-1];
            end
        //end 
    end       
endmodule