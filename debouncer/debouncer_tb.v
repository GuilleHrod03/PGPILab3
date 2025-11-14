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

/*
   Every button or switch may produces "bounces" when changing from on to off or
   from off to on: the contact oscillates during the connection or disconnection
   process and several pulses can be produced before the connection settles to
   an stable value. In digital, the signal may oscillate between '0' and '1'
   before reaching the final state.

   For this reason, in any practical digital circuits, inputs coming from
   switches or push buttons are filtered through special circuits called
   "debouncers" that eliminate the oscillating part of the signal and produce
   a single transition when the signal changes from one value to the other.

   Because bounces are produced very quickly and last for a very short time
   (less than 1ms) a possible strategy to implement a bouncer is to use a
   counter so that the input (bouncing) value is copied to the output only
   when it has been stable for a given number of clock cycles.

   In this examples, a debouncer circuit with an input x and an output z is
   implemented so that the input is considered stable and copied to the
   output when it has been stable for about 1ms. The system clock is
   considered to run at 50MHz.

   An edge detector is also implemented. The edge detector generates single
   clock cycle pulse when the input changes its value. In this example, only
   positive (rising) edges are detected. An edge detector can be used together
   with a debouncer to generate a clean single cycle pulse from a noisy input.
*/

`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////
// Debouncer                                                            //
//////////////////////////////////////////////////////////////////////////

module debouncer #(
    parameter delay = 50000   // cycles to consider stable
    )(
    input wire ck,
    input wire x,
    output reg z = 0
    );

    reg [15:0] count = 0;

    always @(posedge ck) begin
        if (x == z) begin
            count <= delay;
        end else begin
            if (count == 0) begin
                z <= x;
                count <= delay;
            end else begin
                count <= count - 1;
            end
        end
    end
endmodule // debouncer

//////////////////////////////////////////////////////////////////////////
// Edge detector WITH detect + mode                                    //
//////////////////////////////////////////////////////////////////////////

module edge_detector #(
    parameter detect = 1,   // 1=rising, 0=falling
    parameter mode   = 1    // 1=positive pulse, 0=negative pulse
)(
    input wire ck,
    input wire x,
    output reg z
);

    reg old_x = 0;

    initial begin
        z = (mode == 1) ? 0 : 1;
    end

    always @(posedge ck) begin
        old_x <= x;

        wire rising  = (old_x == 0 && x == 1);
        wire falling = (old_x == 1 && x == 0);
        wire event   = (detect == 1) ? rising : falling;

        if (mode == 1) begin
            if (event)
                z <= 1;
            else
                z <= 0;
        end else begin
            if (event)
                z <= 0;
            else
                z <= 1;
        end
    end
endmodule // edge_detector
