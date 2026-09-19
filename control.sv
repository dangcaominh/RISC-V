import risc_pkg::*;

module control(
    // Instruction type flags
    input logic r_type,
    input logic i_type,
    input logic s_type,
    input logic b_type,
    input logic u_type,
    input logic j_type,

    // Instruction fields
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    input logic [6:0] optcode,

    // Output 
    output logic pc_sel,
    output logic op1_sel,
    output logic op2_sel,
    output alu_opt_t alu_op,
    output wb_scr_t rf_wr_data_sel,
    output logic dmem_req,
    output mem_size_t dmem_size,
    output logic dmem_wr_en,
    output logic dmem_zero_extend,
    output logic rf_wr_en
);

    // Internal signals
    logic [3:0] funct_r;
    logic [3:0] optcode_i;
    logic funct7_bit5;

    assign funct7_bit5 = funct7[5];

    control_t ctrl_r, ctrl_i, ctrl_s, ctrl_b, ctrl_u, ctrl_j, ctrl;

    // ----------------------------------------------
    // R-Type Control
    // ----------------------------------------------
    assign funct_r = {funct7_bit5, funct3};

    always_comb begin
        ctrl_r = '0;
        ctrl_r.rf_write_enable = 1'b1;

        case (funct_r)
            R_ADD   : ctrl_r.alu_op = ADD;
            R_SUB   : ctrl_r.alu_op = SUB;
            R_AND   : ctrl_r.alu_op = AND;
            R_OR    : ctrl_r.alu_op = OR;
            R_XOR   : ctrl_r.alu_op = XOR;
            R_SLL   : ctrl_r.alu_op = SLL;
            R_SRL   : ctrl_r.alu_op = SRL;
            R_SRA   : ctrl_r.alu_op = SRA;
            R_SLT   : ctrl_r.alu_op = SLT;
            R_SLTU  : ctrl_r.alu_op = SLTU;
        endcase
    end

    // ----------------------------------------------
    // I-Type Control
    // ----------------------------------------------
    assign optcode_i = {optcode[4], funct3};
    always_comb begin
        ctrl_i = '0;
        ctrl_i.rf_write_enable = 1'b1;
        ctrl_i.alu_b_scr_select = 1'b1;
        case(optcode_i)
            I_ADDI  : ctrl_i.alu_op = ADD;
            I_SLTI  : ctrl_i.alu_op = SLT;
            I_SLTIU : ctrl_i.alu_op = SLTU;
            I_XORI  : ctrl_i.alu_op = XOR;
            I_ORI   : ctrl_i.alu_op = OR;
            I_ANDI  : ctrl_i.alu_op = AND;
            I_SLLI  : ctrl_i.alu_op = SLL;
            I_SRLI_SRAI : ctrl_i.alu_op = funct7_bit5 ? SRA : SRL;

            I_LB    : {ctrl_i.mem_valid, ctrl_i.mem_size, ctrl_i.wb_scr, ctrl_i.load_zero_extend} = {1'b1, BYTE, WB_SCR_MEM, 1'b0};
            I_LH    : {ctrl_i.mem_valid, ctrl_i.mem_size, ctrl_i.wb_scr, ctrl_i.load_zero_extend} = {1'b1, HALF_WORD, WB_SCR_MEM, 1'b0};
            I_LW    : {ctrl_i.mem_valid, ctrl_i.mem_size, ctrl_i.wb_scr, ctrl_i.load_zero_extend} = {1'b1, WORD, WB_SCR_MEM, 1'b0};
            I_LBU   : {ctrl_i.mem_valid, ctrl_i.mem_size, ctrl_i.wb_scr, ctrl_i.load_zero_extend} = {1'b1, BYTE, WB_SCR_MEM, 1'b1};
            I_LHU   : {ctrl_i.mem_valid, ctrl_i.mem_size, ctrl_i.wb_scr, ctrl_i.load_zero_extend} = {1'b1, HALF_WORD, WB_SCR_MEM, 1'b1};
        endcase
    end

    // ----------------------------------------------
    // S-Type Control
    // ----------------------------------------------
    always_comb begin
        ctrl_s = '0;
        case(funct3)
            S_SB    :
            S_SH    :
            S_SW    : 
        endcase
    end

endmodule