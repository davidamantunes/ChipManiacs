#!/bin/bash

iverilog -g2012 -o sim_decoder.out ../src/decoder_13to8.sv ../tb/decoder_13to8_tb.sv

vvp sim_decoder.out