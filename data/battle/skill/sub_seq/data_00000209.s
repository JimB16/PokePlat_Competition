.include "source/macros_asm_.s"


Script_1: @ 0
	Cmd_45 0xff, 0xa
	Cmd_e
	Cmd_12 0x255, 0xf, 0xff
	Cmd_e
	Cmd_1e 0x1e
	Cmd_34 0xa, 0xff, 0x35, 0x100000
	Cmd_3c 0x122
	end
@ 50

@ end_0x50
