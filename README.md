# LED Intensity Control using VHDL and FPGA

## Project Overview
This project focuses on designing a digital circuit using VIVADO for the BASYS 3 FPGA board. It demonstrates LED intensity control through VHDL, showcasing a practical implementation of digital circuit design.

## Features
- Synchronous circuit design with reasonable complexity.
- Custom internal module creation using VHDL.
- User I/O integration with switches, push-buttons, LEDs, and 7-segment display.

## Technical Details
- **Input Counter**: Manages the brightness of the green LED using a clock (clk) and two switches for intensity adjustment.
- **Counter Clock**: A clock divider to manage input speed for brightness level adjustment.
- **LED Intensity Levels**: 15 different brightness levels, from off (0) to maximum brightness (15).
- **LED Controller**: Combines all components, including the seven-segment display driver for brightness level display.

## Software Requirements
- VIVADO Design Suite

## Hardware Requirements
- BASYS 3 FPGA Board
- LEDs, switches, push-buttons, and 7-segment display

## Borrowed Components
- Seven-segment display driver code “sseg” from Dr. Bryan Mealy, CalTech.

## Setup and Configuration
- Detailed instructions on setting up the hardware and loading the VHDL code onto the BASYS 3 board can be found in the files above.

## License
This project is open source.


