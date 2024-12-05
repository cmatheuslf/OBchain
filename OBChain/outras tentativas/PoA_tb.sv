// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

module tb_ProofOfAuthority;

    // Entradas do módulo
    logic clk;
    logic reset;
    logic validate_block;
    logic [31:0] block_id;
    logic [31:0] validator_id;

    // Saídas do módulo
    logic block_valid;

    // Instancia o módulo DUT
    ProofOfAuthority dut(
        .clk(clk),
        .reset(reset),
        .validate_block(validate_block),
        .block_id(block_id),
        .validator_id(validator_id),
        .block_valid(block_valid)
    );

    // Geração de clock
    always #10 clk = ~clk; // Gera um sinal de clock com período de 20ns

    // Procedimento de teste
    initial begin
        // Inicialização
        clk = 0;
        reset = 1;
        validate_block = 0;
        block_id = 0;
        validator_id = 0;
        #40; // Espera para o reset
        reset = 0;

        // Teste com validador autorizado
        validator_id = 1; // Validador autorizado
        block_id = 101;
        validate_block = 1;
        #20; // Ativa a validação de bloco
        validate_block = 0;
        #20;

        // Verifica a saída
        if (block_valid) begin
            $display("Teste 1 Passou: Validador autorizado aprovou o bloco.");
        end else begin
            $display("Teste 1 Falhou: Validador autorizado não aprovou o bloco.");
        end

        // Teste com validador não autorizado
        validator_id = 999; // Não autorizado
        block_id = 102;
        validate_block = 1;
        #20; // Ativa a validação de bloco
        validate_block = 0;
        #20;

        // Verifica a saída
        if (!block_valid) begin
            $display("Teste 2 Passou: Validador não autorizado rejeitou o bloco.");
        end else begin
            $display("Teste 2 Falhou: Validador não autorizado aprovou o bloco.");
        end

        // Conclui os testes
        $finish;
    end

endmodule
