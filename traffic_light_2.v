module traffic_light_2 (
  input clk,
  input reset,
  input ped_ret,          // Pedestrian return request
  output reg ped_sat,     // Pedestrian signal (walk/don't walk)
  output reg [1:0] e_w,   // East-West traffic lights
  output reg [1:0] n_s    // North-South traffic lights
);

  // State register for the FSM
  reg [2:0] state;

  // Counter for timing
  reg [31:0] counter;

  // Parameter definitions for light colors
  parameter red = 2'b11, yellow = 2'b01, green = 2'b10;

  // Parameter definitions for states
  parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;

  // Parameter definitions for pedestrian signal
  parameter walk = 1'b1, d_walk = 1'b0;

  // Parameter definitions for timing durations
  parameter RED_DURATION = 30;
  parameter GREEN_DURATION = 25;
  parameter YELLOW_DURATION = 5;

  //----------------------------------------------------------------------
  // Initial Block: Initialize signals
  //----------------------------------------------------------------------
  initial begin
    state = s0;       // Start in state s0
    e_w = red;         // Initialize East-West to red
    n_s = red;         // Initialize North-South to red
    counter = 0;       // Initialize counter to 0
  end

  //----------------------------------------------------------------------
  // Sequential Logic: State transitions and output assignments
  //----------------------------------------------------------------------
  always @(posedge clk) begin
    if (reset) begin
      state <= s0;     // Reset to state s0
      counter <= 0;    // Reset counter to 0
    end else if (ped_ret && state == s4) begin
      ped_sat <= walk; // Grant pedestrian walk signal if requested in state s4
    end else begin
      if (counter > 0) begin
        counter <= counter - 1; // Decrement counter
      end else begin
        // State transition logic using a case statement
        case (state)
          s0: begin
            ped_sat <= d_walk; // Pedestrian don't walk
            state <= s1;       // Transition to state s1
            e_w <= green;      // East-West to green
            n_s <= red;        // North-South to red
            counter <= GREEN_DURATION; // Set counter for green duration
          end
          s1: begin
            ped_sat <= d_walk; // Pedestrian don't walk
            state <= s2;       // Transition to state s2
            e_w <= yellow;     // East-West to yellow
            n_s <= red;        // North-South to red
            counter <= YELLOW_DURATION; // Set counter for yellow duration
          end
          s2: begin
            ped_sat <= d_walk; // Pedestrian don't walk
            state <= s3;       // Transition to state s3
            e_w <= red;        // East-West to red
            n_s <= green;      // North-South to green
            counter <= GREEN_DURATION; // Set counter for green duration
          end
          s3: begin
            ped_sat <= d_walk; // Pedestrian don't walk
            state <= s4;       // Transition to state s4
            e_w <= red;        // East-West to red
            n_s <= yellow;     // North-South to yellow
            counter <= YELLOW_DURATION; // Set counter for yellow duration
          end
          s4: begin
            ped_sat <= walk;  // Pedestrian walk
            state <= s0;       // Transition to state s0
            e_w <= red;        // East-West to red
            n_s <= red;        // North-South to red
            counter <= RED_DURATION; // Set counter for red duration
          end
          default: begin
            state <= state;  // Default: Hold current state (for safety)
          end
        endcase
      end
    end
  end

endmodule
