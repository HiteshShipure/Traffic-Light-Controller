// Code your design here
module traffic_light_2(
  input clk,
  input reset,
  input ped_ret,
  output reg ped_sat,
  output reg [1:0] e_w,
  output reg [1:0] n_s
);
  reg [2:0] state;
  reg [31:0] counter;    
  parameter red = 2'b11, yellow = 2'b01, green = 2'b10;
  parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;
  parameter walk = 1'b1, d_walk = 1'b0;
  parameter RED_DURATION = 30;
  parameter GREEN_DURATION = 25;
  parameter YELLOW_DURATION = 5;

  initial begin
    state = s0;
    e_w = red;
    n_s = red;
    counter = 0;
  end
  
  always @(posedge clk) begin
   	if (reset) begin
    	state <= s0;
    	counter <= 0;
	end else if (ped_ret && state == s4) begin
    ped_sat <= walk;
    end else begin
      if (counter > 0) begin
        counter <= counter - 1;
      end else begin
        case (state)
          s0: begin
            ped_sat <= d_walk;
            state <= s1;
            e_w <= green;
            n_s <= red;
            counter <= GREEN_DURATION;  
          end
          s1: begin
            ped_sat <= d_walk;
            state <= s2;
            e_w <= yellow;
            n_s <= red;
            counter <= YELLOW_DURATION; 
          end
          s2: begin
            ped_sat <= d_walk;
            state <= s3;
            e_w <= red;
            n_s <= green;
            counter <= GREEN_DURATION;  
          end
          s3: begin
            ped_sat <= d_walk;
            state <= s4;
            e_w <= red;
            n_s <= yellow;
            counter <= YELLOW_DURATION;  
          end
          s4: begin    
            ped_sat <= walk;
            state <= s0;
            e_w <= red;
            n_s <= red;
            counter <= RED_DURATION; 
          end
          default: begin
           state<=state;
          end
        endcase
      end
    end
  end
endmodule