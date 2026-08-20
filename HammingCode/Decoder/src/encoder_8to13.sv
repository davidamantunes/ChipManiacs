module encoder_8to13 (
    input logic [7:0] data,
    output logic [12:0] encoded
);

always_comb begin
    encoded[0] = ^encoded[12:1];
    encoded[1] = data[0]^data[1]^data[3]^data[4]^data[6];
    encoded[2] = data[0]^data[2]^data[3]^data[5]^data[6];
    encoded[3] = data[0];
    encoded[4] = data[1]^data[2]^data[3]^data[7];
    encoded[5] = data[1];
    encoded[6] = data[2];
    encoded[7] = data[3];
    encoded[8] = data[4]^data[5]^data[6]^data[7];
    encoded[9] = data[4];
    encoded[10] = data[5];
    encoded[11] = data[6];
    encoded[12] = data[7];
end

endmodule