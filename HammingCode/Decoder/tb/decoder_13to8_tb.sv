module decoder_13to8_tb;

  logic [7:0] data;
  logic [12:0] encoded;
  logic error_detection; 
  integer i;

  decoder_13to8 dut (
      .decoded(data),
      .codeword(encoded),
      .error_detected(error_detection)
  );

  initial begin
    $display("Testing Decoder");
      #10;
      encoded = 13'b0000010010111;
      $display("Data: %b (0x%02h) -> Encoded: %b", data, data, encoded);

      #10;
      encoded = 13'b0001100000010;
      $display("Data: %b (0x%02h) -> Encoded: %b", data, data, encoded);
    
    $finish;
  end

endmodule

