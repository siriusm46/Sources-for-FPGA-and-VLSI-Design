module(
  clk, 
  reset,
  in,
  out
);

 input  clk    ;
 input  reset  ;
 input  in     ;
 output wire [15:0]  out   ;


reg [3:0] bit_counter;
reg [15:0] temp_data;
reg [15:0] r_out;


always @(posedge clk)begin
    if (reset)begin
        temp_data <= 16'h0000;
        r_out <= 16'h0000;
        bit_counter <= 4'b0000;
    end else begin
        bit_counter <= bit_counter +1'b1;
        temp_data <= {temp_data[14:0], in};
        if (bit_counter == 4'b1111)begin
            r_out <= {temp_data[14:0],in};
        end  
    end

assign out = r_out;
end


endmodule


module sipo_tb();

reg clk    ;
reg reset  ;
reg in     ;
wire [15:0]  out   ;


serial_in_parallel_out dut_sipo(

    .clk  (clk),
    .reset(reset),
    .in   (in),
    .out  (out)

);

// 10ns clk and the parallel data is 16'hA518
initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end


initial begin
    reset = 1; 
    #10
    reset = 0;
    in = 1; #10
    in = 0; #10
    in = 1; #10
    in = 0; #10
    in = 0; #10
    in = 1; #10
    in = 0; #10
    in = 1; #10
    in = 0; #10
    in = 0; #10
    in = 0; #10
    in = 1; #10
    in = 1; #10
    in = 0; #10
    in = 0; #10
    in = 0;

end





endmodule
