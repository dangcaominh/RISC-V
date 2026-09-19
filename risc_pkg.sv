package risc_pkg;

    // RISC-V Opcodes

    typedef enum logic [6:0] {  
        OPTCODE_R_TYPE = 7'h33,
        OPTCODE_I_LOAD = 7'h03,
        OPTCODE_I_ALU  = 7'h13,
        OPTCODE_I_JALR = 7'h67,
        OPTCODE_S_TYPE = 7'h23,
        OPTCODE_B_TYPE = 7'h63,
        OPTCODE_LUI    = 7'h37,
        OPTCODE_AUIPC  = 7'h17,
        OPTCODE_JAL    = 7'h6f
    } optcode_t;

    // ALU Operation Selector

    typedef enum logic [3:0] {
        ADD,
        SUB,
        SLL,
        SRL,
        SRA,
        OR,
        AND,
        XOR,
        SLTU,
        SLT
    } alu_opt_t;

    // Memory Access Size

    typedef enum logic [1:0] {
        BYTE = 2'b00,
        HALF_WORD = 2'b01,
        WORD = 2'b11
    } mem_size_t;

    // B-Type Instructions (Funct3)

    typedef enum logic [2:0] {
        B_BEQ = 3'h0,
        B_BNE = 3'h1,
        B_BLT = 3'h4,
        B_BGE = 3'h5,
        B_BLTU = 3'h6,
        B_BGEU = 3'h7
    } b_type_instr_t;

    // R-Type Instructions (Funct7[5], Funct3)

    typedef enum logic [3:0] {
        R_ADD = 4'h0,
        R_SUB = 4'h8,
        R_SLL = 4'h1,
        R_SLT = 4'h2,
        R_SLTU = 4'h3,
        R_XOR = 4'h4,
        R_SRL = 4'h5,
        R_SRA = 4'hd,
        R_OR = 4'h6,
        R_AND = 4'h7
    } r_type_instr_t;

    // I-Type Instructions (Optcode[4], Funct3)

    typedef enum logic [3:0] {
        I_LB = 4'h0,
        I_LH = 4'h1,
        I_LW = 4'h2,
        I_LBU = 4'h4,
        I_LHU = 4'h5,
        I_ADDI = 4'h8,
        I_SLTI = 4'ha,
        I_SLTIU = 4'hb,
        I_XORI = 4'hc,
        I_ORI = 4'he,
        I_ANDI = 4'hf,
        I_SLLI = 4'h9,
        I_SRLI_SRAI = 4'hd  // shared funct 3
    } i_type_instr_t;

    // S-Type Instructions (Funct3)
    typedef enum logic [2:0] {
        S_SB = 3'h0,
        S_SH = 3'h1,
        S_SW = 3'h2,
    } s_type_instr_t;

    // Register File Writeback Sources

    typedef enum logic [1:0] {
        WB_SCR_ALU = 2'b00,
        WB_SCR_MEM = 2'b01,
        WB_SCR_IMM = 2'b10,
        WB_SCR_PC = 2'b11,
    } wb_scr_t;

    // Control Signal Struct
    
    typedef struct packed {
        logic mem_valid;
        logic mem_write;
        mem_size_t mem_size;
        logic load_zero_extend;
        logic rf_write_enable;
        logic pc_scr_select;
        logic alu_a_scr_select;
        logic alu_b_scr_select;
        wb_scr_t wb_scr;
        alu_opt_t alu_op;
    } control_t;

endpackage