# RISC-V RV32I Core

Core RISC-V 32-bit được viết bằng SystemVerilog, hướng tới tập lệnh RV32I. Thiết kế gồm các khối xử lý instruction, giải mã lệnh, register file, ALU, điều khiển branch và memory.

## Overview

Các module chính:

- `fetch` và `instruction_memory`: lấy instruction theo PC.
- `decode` và `control`: giải mã instruction và tạo tín hiệu điều khiển.
- `register_file`: cung cấp 32 thanh ghi 32-bit.
- `alu`: thực hiện các phép toán số học, logic và so sánh.
- `branch_control`: xử lý điều kiện branch.
- `data_memory`: hỗ trợ các thao tác load/store.

![RISC-V Architecture](RISC-V%20Architecture.png)
