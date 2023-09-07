module cycle # (
    // Parameters 
    parameter                   COUNT_WIDTH = 32,
    parameter                   MAX_COUNT = 25_000_000,
    parameter                   OUTPUT_WIDTH = 4       
)(
    // Inputs
    input clk,
    //input enable,
    
    // Outputs
    output reg [OUTPUT_WIDTH-1:0] out
);

    // Internal Signals
    reg [COUNT_WIDTH-1:0] counter = 0; // 32-bit counter for 250 ms delay
    reg [2:0] cycle_index = 3'b000; // 3-bit cycle index
    reg direction = 0;
    reg [3:0] seq = 4'b0000;

    always @(posedge clk) begin
        //if (enable) begin
            if (counter < MAX_COUNT)
                counter <= counter + 1;
            else begin
                counter <= 0;
                if (direction)
                    case (cycle_index)
                        3'b000: seq <= 4'b0000;
                        3'b001: seq <= 4'b0001;
                        3'b010: seq <= 4'b0011;
                        3'b011: seq <= 4'b0111;
                        3'b100: seq <= 4'b1111;
                    endcase
                else
                    case (cycle_index)
                        3'b000: seq <= 4'b1111;
                        3'b001: seq <= 4'b0111;
                        3'b010: seq <= 4'b0011;
                        3'b011: seq <= 4'b0001;
                        3'b100: seq <= 4'b0000;
                    endcase
    
                if (cycle_index == 3'b100) begin
                    cycle_index <= 3'b000;
                    direction <= ~direction;
                end
                else
                    cycle_index <= cycle_index + 1;     
        
                out <= seq;
            end
        //end
    end
endmodule
