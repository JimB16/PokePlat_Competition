

@ HACK
@ ivs = hp<<0 atk<<5 def<<10 spe<<15 spa<<20 spd<<25
@ evs = hp<<0 atk<<8 def<<16 spe<<24 spa<<32 spd<<40
/* Personality Value
0xff Gender 250=male 0=female
0x1 Ability 1=Ab2 0=Ab1
%25 Nature =Nature-Ab
*/
.macro	GivePokemon2	pkmn=0, altform=0, lvl=0, item=0, move1=0, move2=0, move3=0, move4=0, personalityvalue=0, ivs=0, evs1=0, evs2=0, gender=male, ability=0, nature=0, hiddenpower=dark, res=0x8000
.ifc \gender, male
.equ gender_, 0
@.equ gender_, 200
@.equ gender_, 192
.endif
.ifc \gender, female
.equ gender_, 1
.endif
/*.if \ability, 0
.equ ability_nature, \nature
.endif
.if \ability, 1
.if \nature%1, 0
.equ ability_nature, \nature+25
.endif
.endif*/
@.equ ability_nature, \nature

/* A complete chart of Hidden Power 70's.
http://www.gamefaqs.com/boards/989552-pokemon-black-version/58772271
*/
.ifc \hiddenpower, dark1
.equ ivs_, 31<<0 | 31<<5 | 31<<10 | 31<<15 | 31<<20 | 31<<25
.endif
.ifc \hiddenpower, dragon1
.equ ivs_, 30<<0 | 31<<5 | 31<<10 | 31<<15 | 31<<20 | 31<<25
.endif
.ifc \hiddenpower, ice1
.equ ivs_, 30<<0 | 31<<5 | 30<<10 | 31<<15 | 31<<20 | 31<<25
.endif
.ifc \hiddenpower, psychic1
.equ ivs_, 30<<0 | 31<<5 | 31<<10 | 31<<15 | 31<<20 | 30<<25
.endif
.ifc \hiddenpower, electric1
.equ ivs_, 30<<0 | 31<<5 | 30<<10 | 31<<15 | 31<<20 | 30<<25
.endif
.ifc \hiddenpower, grass1
.equ ivs_, 30<<0 | 31<<5 | 31<<10 | 30<<15 | 31<<20 | 31<<25
.endif
.ifc \hiddenpower, water1
.equ ivs_, 31<<0 | 30<<5 | 30<<10 | 30<<15 | 31<<20 | 31<<25
.endif
.ifc \hiddenpower, fire1
.equ ivs_, 31<<0 | 30<<5 | 31<<10 | 30<<15 | 31<<20 | 30<<25
.endif
.ifc \hiddenpower, steel1
.equ ivs_, 31<<0 | 30<<5 | 30<<10 | 30<<15 | 31<<20 | 30<<25
.endif
.ifc \hiddenpower, ghost1
.equ ivs_, 31<<0 | 30<<5 | 31<<10 | 31<<15 | 30<<20 | 31<<25
.endif
.ifc \hiddenpower, bug1
.equ ivs_, 31<<0 | 30<<5 | 30<<10 | 31<<15 | 30<<20 | 31<<25
.endif
.ifc \hiddenpower, rock1
.equ ivs_, 30<<0 | 30<<5 | 31<<10 | 31<<15 | 30<<20 | 30<<25
.endif
.ifc \hiddenpower, ground1
.equ ivs_, 30<<0 | 30<<5 | 30<<10 | 31<<15 | 30<<20 | 30<<25
.endif
.ifc \hiddenpower, poison1
.equ ivs_, 30<<0 | 30<<5 | 31<<10 | 30<<15 | 30<<20 | 31<<25
.endif
.ifc \hiddenpower, flying1
.equ ivs_, 30<<0 | 30<<5 | 30<<10 | 30<<15 | 30<<20 | 31<<25
.endif
.ifc \hiddenpower, fighting1
.equ ivs_, 30<<0 | 30<<5 | 31<<10 | 30<<15 | 30<<20 | 30<<25
.endif

.hword  0x2d9, \pkmn|\altform<<10, \lvl, \item, \move1, \move2, \move3, \move4
@.word   \personalityvalue
.word   \nature | \ability<<5 | gender_<<6 @gender_+ability_nature @|(gender_+ability_nature)<<16 @ PV
.word   ivs_, \evs1
.hword  \evs2
.hword  \res
.endm

