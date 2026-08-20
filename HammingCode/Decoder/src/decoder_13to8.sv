module decoder_13to8 (
    input logic [12:0] codeword,
    output logic [7:0] decoded,
    output logic error_detected 
); 

logic [7:0] data = {codeword[12], codeword[11], codeword[10], codeword[9], codeword[7], codeword[6], codeword[5], codeword[3]};
logic [4:0] syndrome;
logic [12:0] corrected;

assign syndrome [0] = codeword[0] ^ (^{codeword[12:1]});
assign syndrome [1] = codeword[1] ^ codeword[3] ^ codeword[5] ^ codeword[7] ^ codeword[9] ^ codeword[11]; 
assign syndrome [2] = codeword[2] ^ codeword[3] ^ codeword[6] ^ codeword[7] ^ codeword[10] ^ codeword[11];
assign syndrome [3] = codeword[4] ^ codeword[5] ^ codeword[6] ^ codeword[7] ^ codeword[12];
assign syndrome [4] = codeword[8] ^ codeword[9] ^ codeword[10] ^ codeword[11] ^ codeword[12]; 


always @(*) begin
    //if no error copy the data bits into the dataword from the codeword 
    if (syndrome == 5'b00000) begin
        error_detected = 1'b0;
        decoded = data;
    //if one error occurs we detect and correct it     
    end else if (syndrome[4:1] < 13 && syndrome[0] == 1) begin
        corrected = codeword ^ (1 << (syndrome[4:1]));
        error_detected = 1'b0; 
        decoded = {corrected[12], corrected[11], corrected[10], corrected[9], corrected[7], corrected[6], corrected[5], corrected[3]};
    end else begin
        error_detected = 1'b1; 
        decoded = 8'b0;
    end        
end

endmodule

