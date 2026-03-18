# FPGA Traffic Light Controller FSM


## Project Overview
This project implements a digital Traffic Light Controller for an intersection of two streets (Street A and Street B) using a **Moore Finite State Machine (FSM)**. The design is written in **SystemVerilog** and is structured to be synthesized on an FPGA board (e.g., Basys 3 or Intel/Altera families) with a 100 MHz clock.

### Key Features
- **Moore Machine Design:** Output logic depends solely on the current state.
- **Sensor-Based Control:** The FSM reacts to traffic presence on either street using the `TAORB` input sensor.
- **5-Second Yellow Light Timer:** Incorporates a custom clock divider and an internal 3-bit counter to ensure the yellow light remains active for exactly 5 seconds before transitioning.
- **Hierarchical Design:** Clean, modular structure separating the datapath (timer/divider) and control logic (FSM).

---

## State Machine Logic
The controller transitions between 4 primary states:

| State | Name | Street A | Street B | Transition Condition |
| :--- | :--- | :--- | :--- | :--- |
| **S0** | `GREENRED` |  Green | Red | Stays until traffic on A ends (`TAORB = 0`). |
| **S1** | `YELLOWRED`|  Yellow | Red | Waits for **5 seconds** (using internal timer), then goes to S2. |
| **S2** | `REDGREEN` | Red | Green | Stays until traffic on A resumes/B ends (`TAORB = 1`). |
| **S3** | `REDYELLOW`| Red | Yellow | Waits for **5 seconds**, then loops back to S0. |

---

## File Structure / Modules Breakdown

1. **`Traffic_top.sv` (Top-Level Entity):** The main wrapper that connects the clock divider and the core FSM. Maps the internal 1Hz clock to the FSM.
2. **`Traffic.sv` (Core FSM):** Contains the Moore state machine and the 3-bit counter logic for the 5-second yellow light delay.
3. **`halfsecond.sv` (Clock Divider):** Steps down the 100 MHz board clock to a 1 Hz clock tick. *(Note: For simulation purposes in `tb_Traffic_top`, the counter is reduced to allow rapid waveform verification).*
4. **`tb_Traffic_top.sv` (Testbench):** Provides the simulation environment. It generates a 100 MHz clock, initializes the system, and simulates traffic scenarios to verify state transitions and timer precision.

---

## Simulation & Verification
This project has been successfully simulated using **Questa Altera FPGA**. 

To run the simulation:
1. Create a new project in Intel Quartus Prime.
2. Set `Traffic_top.sv` as the Top-Level Entity.
3. Add `tb_Traffic_top.sv` to your EDA Tool simulation settings.
4. Compile and run RTL Simulation. 
5. In the Questa waveform window, observe the `led` vector (`[5:0]`) changing based on the `TAORB` sensor input and the internal 5-second delay logic.

*Outputs mapping:* `led[5:3]` controls Street A (R,Y,G) and `led[2:0]` controls Street B (R,Y,G).# Traffic-Light-FSM
Moore Machine based Traffic Light Controller
