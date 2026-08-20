module hamming_13_8_decoder (
    input  logic [11:0] c_in,               // 12-bit received codeword
    output logic [7:0]  d_out,              // 8-bit extracted data
    output logic        error_detected,     // High if a single-bit error occurred and was corrected
    output logic        invalid_syndrome    // High if an out-of-bounds syndrome (13-15) was generated
);

    logic [3:0]  s;                         // 4-bit syndrome [s0, s1, s2, s3]
    logic [11:0] c_corrected;               // Corrected codeword

    // 1. Calculate the 4-bit Syndrome: s = H * c^T over GF(2)
    // Rows of H correspond to binary values 1 to 12
    assign s[0] = c_in[0]  ^ c_in[2]  ^ c_in[4]  ^ c_in[6]  ^ c_in[8]  ^ c_in[10];
    assign s[1] = c_in[1]  ^ c_in[2]  ^ c_in[5]  ^ c_in[6]  ^ c_in[9]  ^ c_in[10];
    assign s[2] = c_in[3]  ^ c_in[4]  ^ c_in[5]  ^ c_in[6]  ^ c_in[11];
    assign s[3] = c_in[7]  ^ c_in[8]  ^ c_in[9]  ^ c_in[10] ^ c_in[11];

    // 2. Flags for error handling
    // A syndrome between 13 and 15 indicates corruption beyond single-bit capability
    assign invalid_syndrome = (s > 4'd12);
    assign error_detected   = (s != 4'b0000) && !invalid_syndrome;

    // 3. Direct-indexing Error Correction
    always_comb begin
        c_corrected = c_in;
        if (error_detected) begin
            c_corrected[s - 1] = ~c_in[s - 1]; // Flip bit at index (s - 1)
        end
    end

    // 4. Extract 8-bit Data Payload
    assign d_out[0] = c_corrected[2];
    assign d_out[1] = c_corrected[4];
    assign d_out[2] = c_corrected[5];
    assign d_out[3] = c_corrected[6];
    assign d_out[4] = c_corrected[8];
    assign d_out[5] = c_corrected[9];
    assign d_out[6] = c_corrected[10];
    assign d_out[7] = c_corrected[11];

endmodule