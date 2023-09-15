module cycle_v2 # (
    // Parameters 
    parameter COUNT_WIDTH = 32,
    parameter MAX_COUNT = 50_000_000,
    parameter OUTPUT_WIDTH = 4       
) (
    // Inputs
    input clk,
    //input enable,
    
    // Outputs
    output  [OUTPUT_WIDTH-1:0] out
);

    // Internal Signals
    reg [COUNT_WIDTH-1:0] counter = 0; // 32-bit counter for 250 ms delay
    reg [2:0] cycle_index = 2'b00; // 2-bit cycle index
    reg direction = 1;
    reg [3:0] seq = 4'b0000;
    
    assign out = seq;

    always @(posedge clk) begin
        //if (enable) begin
            if (counter < MAX_COUNT)
                counter <= counter + 1;
            else begin
                counter <= 0;
                if (direction)
                    seq <= (seq << 1) + 1;
                else
                    seq <= seq >> 1;

                if (cycle_index == 2'b11) begin
                    cycle_index <= 2'b00;
                    direction <= ~direction;
                end
                else
                    cycle_index <= cycle_index + 1;     
            end
        //end
    end
endmodule
