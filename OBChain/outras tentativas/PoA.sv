// Code your design here
  typedef struct {
    logic [255:0] previous_hash_block;
    logic [31:0] timestamp;
    logic [255:0] actual_hash_block;
  } block_content_input;

  typedef struct {
    logic [255:0] previous_hash_block;
    logic [31:0] timestamp;
    logic [255:0] actual_hash_block;
    logic [255:0] validator_signature;
  } block_content_output;


module ProofOfAuthority(
    input logic clk,
    input logic reset,
    input logic validate_block,
    input logic [31:0] block_id,
    input logic [31:0] validator_id,
    output logic block_valid,
  	input block_content_input content
);
  


    // Lista dos validadores autorizados (IDs)
    localparam integer NUM_VALIDATORS = 3;
    localparam integer authorized_validators[NUM_VALIDATORS] = {1, 2, 3};
  	
  	//Ultimo hash válido
    logic [255:0] last_hash_valid = 256'habc123456;

    // Verifica se o validador é autorizado
    function logic is_validator_authorized(input logic [31:0] id);
        for (int i = 0; i < NUM_VALIDATORS; i++) begin
            if (authorized_validators[i] == id) return 1;
        end
        return 0;
    endfunction

//flip-flop
    always_ff @(posedge clk) begin
        if (reset) begin
            block_valid <= 0;
        end else if (validate_block) begin
            // Verifica se o validador está autorizado a validar o bloco
            if (is_validator_authorized(validator_id)) begin
              block_valid <= validation(content);  // Bloco validado
              if(block_valid) begin
              	last_hash_valid <= content.actual_hash_block;
              end
            end else begin
                block_valid <= 0;  // Bloco rejeitado
            end
        end
    end

endmodule
