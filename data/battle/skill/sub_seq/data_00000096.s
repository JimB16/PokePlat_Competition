.include "source/macros_asm_.s"


Script_1: @ 0
	Cmd_32 Cmd32_Store, 0x22, 0x18
	Cmd_3c 0xc
	Cmd_32 Cmd32_Orr, 0x6, 0x4001
	Cmd_32 Cmd32_Orr, 0x3c, 0x80
	Cmd_32 Cmd32_Store, 0x22, 0xf
	Cmd_3c 0xc
	Cmd_32 Cmd32_Store, 0x22, 0x10
	Cmd_3c 0xc
	Cmd_32 Cmd32_Bic, 0x3c, 0x2
	Cmd_32 Cmd32_Bic, 0x3c, 0x80
	end
@ 8c

@ end_0x8c