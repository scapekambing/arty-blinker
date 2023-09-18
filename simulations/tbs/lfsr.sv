module lfsr # (
    parameter                     OUTPUT_WIDTH = 4,
    parameter                     DEFAULT_SEED = 0
)(
    output    [OUTPUT_WIDTH-1:0]  out, 
    input                         clk,
    input                         rst,
    input                         enb,
    input     [OUTPUT_WIDTH-1:0]  seed
);

    reg [OUTPUT_WIDTH-1:0] state = DEFAULT_SEED;
    reg init_seed = 1;

    wire feedback;
    
    assign feedback = ~(state[3] ^ state[2]); // xnor

    assign out = state;
    
    always @(posedge clk) begin
        if (enb)
            if (rst)
                state <= seed;
            else
    	 	if (init_seed) begin
 	           state <= seed; // seed from input
     		   init_seed <= ~init_seed; //  after setting to seed, never again
                end
		else
                    state <= {state[OUTPUT_WIDTH-2:0], feedback};
        else
            state <= 0;
    end
            
endmodule