.include "source/macros_asm.s"

@ HP, Atk, Def, Spe, SpA, SpD, Type1, Type2, CatchRate, BaseExp, EV ((EV_HP)|(EV_Atk<<2)|(EV_Def<<4)|(EV_Spe<<6)|(EV_SpA<<8)|(EV_SpD<<10)), Item1, Item2, Gender, HatchCycle, BaseHappiness, ExpRate, EggGroup1, EggGroup2, Ability1, Ability2, Flee, unknown, unknown, unknown, unknown, unknown, unknown
PkmnBaseData 28, 25, 25, 40, 45, 35, PSYCHIC, PSYCHIC, 235, 70, ((0)|(0<<2)|(0<<4)|(0<<6)|(1<<8)|(0<<10)), NO_ITEM, NO_ITEM, 127, 20, 35, 5, EGGGROUP_AMORPHOUS, EGGGROUP_AMORPHOUS, SYNCHRONIZE, TRACE, 0, 8, 0, 0xb49b8e28, 0x381bf03, 0xa763124, 0