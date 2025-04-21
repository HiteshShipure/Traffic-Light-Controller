# Traffic Light Controller

## Overview
This repository contains a Verilog implementation of a traffic light controller that manages the signals for a two-way intersection with east-west and north-south directions. The controller also includes pedestrian crossing functionality.

## Features
- Controls traffic lights for east-west and north-south directions
- Manages pedestrian crossing signals
- Implements a standard traffic light sequence with appropriate timing
- Includes reset capability for system initialization

## Module Description

The `traffic_light_2` module manages traffic flow at an intersection with the following signals:

### Inputs
- `clk`: System clock input
- `reset`: System reset signal
- `ped_ret`: Pedestrian button input (request to cross)

### Outputs
- `ped_sat`: Pedestrian signal indicator (walk/don't walk)
- `e_w[1:0]`: East-West traffic signal (2-bit output)
- `n_s[1:0]`: North-South traffic signal (2-bit output)

### Signal Encoding
- Traffic lights: `2'b10` (green), `2'b01` (yellow), `2'b11` (red)
- Pedestrian signal: `1'b1` (walk), `1'b0` (don't walk)

### States
The controller implements a 5-state finite state machine:
- `s0`: All-direction red state with pedestrian crossing
- `s1`: East-West green, North-South red
- `s2`: East-West yellow, North-South red
- `s3`: East-West red, North-South green
- `s4`: East-West red, North-South yellow

### Timing Parameters
- `RED_DURATION`: 30 clock cycles
- `GREEN_DURATION`: 25 clock cycles
- `YELLOW_DURATION`: 5 clock cycles

## State Diagram
```
     ┌───────┐
     │       │
     ▼       │
s0(All Red)  │
     │       │
     ▼       │
s1(EW Green) │
     │       │
     ▼       │
s2(EW Yellow)│
     │       │
     ▼       │
s3(NS Green) │
     │       │
     ▼       │
s4(NS Yellow)┘
```

## Operation
1. System initializes to state `s0` with all lights red
2. Transitions through each state following standard traffic patterns
3. Pedestrian crossing is allowed during the all-red phase
4. Pedestrian button (`ped_ret`) triggers the pedestrian signal when in state `s4`


## Simulation
The controller can be tested using any Verilog simulator by applying clock signals and observing the state transitions and output signals.

## Contributing
Contributions to improve the traffic light controller are welcome. Please feel free to submit a pull request.
