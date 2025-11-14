// Design: debouncer
// Description: Counter-based debouncers.
// Author: Guillermo Federico Hurtado Rodriguez
// Copyright Universidad de Sevilla, Spain
// Date: 14-11-2025

////////////////////////////////////////////////////////////////////////////////
// This file is free software: you can redistribute it and/or modify it under //
// the terms of the GNU General Public License as published by the Free       //
// Software Foundation, either version 3 of the License, or (at your option)  //
// any later version. See <http://www.gnu.org/licenses/>.                     //
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

// Test bench

module test();

    reg ck;     
    reg x;      
    wire z0;    
    wire z_rise_pos;
    wire z_fall_neg;

    // Debouncer (delay 5)
    debouncer #(.delay(5)) deb1 (.ck(ck), .x(x), .z(z0));

    // --- Added debouncers for EXERCISE 5 ---
    debouncer #(.delay(3))  deb_d3  (.ck(ck), .x(x), .z(z_delay3));
    debouncer #(.delay(7))  deb_d7  (.ck(ck), .x(x), .z(z_delay7));
    debouncer #(.delay(12)) deb_d12 (.ck(ck), .x(x), .z(z_delay12));
    // -----------------------------------------

    // Waveform generation and simulation control
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, test);

        ck = 0;
        x  = 0;
    end

    always #10 ck = ~ck;

    initial begin
        #200   x = 1;
        #15    x = 0;
        #15    x = 1;
        #40    x = 0;
        #30    x = 1;
        #80    x = 0;
        #30    x = 1;
        #300   x = 0;
        #10    x = 1;
        #40    x = 0;
        #70    x = 1;
        #15    x = 0;
        #200   x = 1;
        #200   x = 0;
        #200   $finish;
    end
endmodule

/*
   EXERCISES

   3. Compile and simulate the examples with:

      $ iverilog debouncer.v debouncer_tb.v
      $ vvp a.out

   4. Display the results with:

      $ gtkwave test.vcd

      Compare the noisy input 'x' to the clean output 'z0' and the pulse output
      'z'.

   5. Modify the test bench to instantiate a debouncer with different delays
      (You may try values 3, 7 and 12 for example) and see what happens to the
      simulation results.

   6. Modify the edge detector desing to include two parameters "detect" and
      "mode":

      - detect=0: detect falling edge
      - detect=1: detect rising edge
      - mode=0: output is normally 1, detection makes a negative output pulse
      - mode=1: output is normally 0, detection makes a positive output pulse

      Default values should be detect=1, mode=1. Check the design with a
      suitable test bench.
*/
