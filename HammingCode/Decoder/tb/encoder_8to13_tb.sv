module encoder_8to13_tb;

  logic [7:0] data;
  logic [12:0] encoded;
  integer i;

  logic [7:0] test_vectors [0:5];
  logic [7:0] test_vectors_encoded [0:5];

  encoder_8to13 dut (
      .data(data),
      .encoded(encoded)
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
      data = test_vectors[i];
      #10;
      $display("Data: 8'b%b (0x%02h) -> Encoded: 13'b%b (0x%04h)", 
               data, data, encoded, encoded);
    end
    $finish;
  end

endmodule