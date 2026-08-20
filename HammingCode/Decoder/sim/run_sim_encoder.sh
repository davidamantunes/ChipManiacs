#!/bin/bash

iverilog -g2012 -o sim_encoder.out ../src/encoder_8to13.sv ../tb/encoder_8to13_tb.sv

vvp sim_encoder.out