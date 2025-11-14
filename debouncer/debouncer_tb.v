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

    // Edge detector test #1: detect rising, positive pulse
    edge_detector #(.detect(1), .mode(1)) ed_rise_pos (.ck(ck), .x(z0), .z(z_rise_pos));

    // Edge detector test #2: detect falling, negative pulse
    edge_detector #(.detect(0), .mode(0)) ed_fall_neg (.ck(ck), .x(z0), .z(z_fall_neg));

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
