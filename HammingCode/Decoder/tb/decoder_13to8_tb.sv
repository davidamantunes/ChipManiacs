module decoder_13to8_tb;

  logic [7:0] data;
  logic [12:0] encoded;
  logic error_detection; 

  decoder_13to8 dut (
      .decoded(data),
      .codeword(encoded),
      .error_detected(error_detection)
  );

  initial begin
    $display("Testing Decoder");
    
      encoded = 13'b0000000111100;
      #10;
      $display("Data: %b (0x%02h) -> Encoded: %b, Error Detected %b", data, data, encoded, error_detection);
      #10;
      encoded = 13'b0000011111111;
      #10;
      $display("Data: %b (0x%02h) -> Encoded: %b, Error Detected %b", data, data, encoded, error_detection);
      #10;
      encoded = 13'b1010010110001;
      #10;
      $display("Data: %b (0x%02h) -> Encoded: %b, Error Detected %b", data, data, encoded, error_detection);
      #10;
      encoded = 13'b0101001011111;
      #10;
      $display("Data: %b (0x%02h) -> Encoded: %b, Error Detected %b", data, data, encoded, error_detection);
      #10;
      encoded = 13'b1100000101011;
      #10;
      $display("Data: %b (0x%02h) -> Encoded: %b, Error Detected %b", data, data, encoded, error_detection);
      #10;
      encoded = 13'b1111011101110;
      #10;
      $display("Data: %b (0x%02h) -> Encoded: %b, Error Detected %b", data, data, encoded, error_detection);
      #10;
    $finish;
  end

endmodule