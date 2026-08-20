module encoder_8to13 (
    input  logic [7:0]  data,
    output logic [12:0] encoded
);

    assign encoded[12] = data[7];
    assign encoded[11] = data[6];
    assign encoded[10] = data[5];
    assign encoded[9]  = data[4];
    assign encoded[8]  = data[4] ^ data[5] ^ data[6] ^ data[7];
    assign encoded[7]  = data[3];
    assign encoded[6]  = data[2];
    assign encoded[5]  = data[1];
    assign encoded[4]  = data[1] ^ data[2] ^ data[3] ^ data[7];
    assign encoded[3]  = data[0];
    assign encoded[2]  = data[0] ^ data[2] ^ data[3] ^ data[5] ^ data[6];
    assign encoded[1]  = data[0] ^ data[1] ^ data[3] ^ data[4] ^ data[6];

    assign encoded[0]  = ^encoded[12:1];

endmodule