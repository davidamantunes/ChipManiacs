module error_sim;

logic [7:0] e_data;
logic [12:0] e_encoded;

logic [7:0] d_data;
logic [12:0] d_encoded;
logic error_detection;

integer i;
logic [7:0] test_vectors [0:5];

encoder_8to13 encoder_dut (
    .data(e_data),
    .encoded(e_encoded)
);

decoder_13to8 decoder_dut (
    .decoded(d_data),
    .codeword(d_encoded),
    .error_detected(error_detection) // Fixed undeclared variable name
);

initial begin
    // Populate test vectors individually for Icarus Verilog compatibility
    test_vectors[0] = 8'h03;
    test_vectors[1] = 8'h0F;
    test_vectors[2] = 8'hAA;
    test_vectors[3] = 8'h55;
    test_vectors[4] = 8'hC3;
    test_vectors[5] = 8'hFF;

    $display("Testing Encoder with Multi-Bit Inputs");
    for (i = 0; i < 6; i = i + 1) begin
        e_data = test_vectors[i];

        // NO ERROR
        #10;
        $display("Encoder:");
        $display("\tData: 8'b%b (0x%02h) -> Encoded: 13'b%b (0x%04h)", e_data, e_data, e_encoded, e_encoded);
        
        d_encoded = e_encoded;
        
        $display("Communication channel (No error induced):");
        $display("\t13'b%b (0x%04h) --------------------------------- 13'b%b (0x%04h)", e_encoded, e_encoded, d_encoded, d_encoded);
        #10;
        
        $display("Decoder:");
        $display("\tData: 8'b%b (0x%02h) -> Received word: 13'b%b, Error Detected but not corrected: %b", d_data, d_data, d_encoded, error_detection);
        #10;

        // DETECT 1, CORRECT 1
        $display("Encoder:");
        $display("\tData: 8'b%b (0x%02h) -> Encoded: 13'b%b (0x%04h)", e_data, e_data, e_encoded, e_encoded);
        
        d_encoded = e_encoded;
        d_encoded[3] = ~d_encoded[3];
        
        $display("Communication channel (1 error induced):");
        $display("\t13'b%b (0x%04h) --------------------------------- 13'b%b (0x%04h)", e_encoded, e_encoded, d_encoded, d_encoded);
        #10;
        
        $display("Decoder:");
        $display("\tData: 8'b%b (0x%02h) -> Received word: 13'b%b, Error Detected but not corrected: %b", d_data, d_data, d_encoded, error_detection);
        #10;

        // DETECT 2, CORRECT 0
        $display("Encoder:");
        $display("\tData: 8'b%b (0x%02h) -> Encoded: 13'b%b (0x%04h)", e_data, e_data, e_encoded, e_encoded);
        
        d_encoded = e_encoded;
        d_encoded[3] = ~d_encoded[3];
        d_encoded[11] = ~d_encoded[11];
        
        $display("Communication channel (2 errors induced):");
        $display("\t13'b%b (0x%04h) --------------------------------- 13'b%b (0x%04h)", e_encoded, e_encoded, d_encoded, d_encoded);
        #10;
        
        $display("Decoder:");
        $display("\tData: 8'b%b (0x%02h) -> Received word: 13'b%b, Error Detected but not corrected: %b", d_data, d_data, d_encoded, error_detection);
        #10;
        $display("\n\n");
    end

    $finish;
end

endmodule