#!/bin/bash

iverilog -g2012 -o sim_decoder.out ../src/decoder_13to8.sv ../src/encoder_8to13.sv ../tb/error_sim.sv

vvp sim_decoder.out