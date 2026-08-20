module encoder_8to13_tb;

  logic [7:0] data;
  logic [12:0] encoded;
  integer i;

  encoder_8to13 dut (
      .data(data),
      .encoded(encoded)
  );

  initial begin
    $display("Testing Encoder");
    for (i = 0; i < 8; i = i + 1) begin
      data = 8'b1 << i;
      #10;
      $display("Data: %b (0x%02h) -> Encoded: %b", data, data, encoded);
    end
    $finish;
  end

endmodule