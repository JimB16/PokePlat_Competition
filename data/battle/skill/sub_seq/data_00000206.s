.include "source/macros_asm_.s"


Script_1: @ 0
	Cmd_45 0xff, 0xa
	Cmd_e
	Cmd_12 0x380, 0xf, 0xff
	Cmd_e
	Cmd_42 0xff, 0x0
	Cmd_1e 0x1e
	Cmd_34 0x7, 0xff, 0x34, 0x0
	Cmd_34 0xb, 0xff, 0x35, 0x8000000
	Cmd_34 0xb, 0xff, 0x35, 0x7
	Cmd_3c 0x122
	end
@ 84

@ end_0x84
