!-============================================================================
!-v: the number of verbs
!-w: the number of nouns (objects)
!-g: the number of "gettable" objects?????
!-============================================================================
70 v=25:w=36:g=18
!- Off to read data in and initialise and populate arrays
80 gosub 1600

#region "Screen play field setup"
90 ?"{clear}":?"HAUNTED HOUSE"
100 ?"----------------------------------------"
!- Print location
110 ?"YOUR LOCATION"
120 ?d$(rm)
!- Print exists
130 ?"EXITS:";
140 for i = 1 to len(r$(rm))
150 ?mid$(r$(rm), i, 1);",";
160 next i
170 ?
!- Print visible objects
180 for i = 1 to g
190 if l(i) = rm and f(i) = 0 then ?"YOU CAN SEE ";o$(i);" HERE"
200 next i
210 ?"========================================"
#endregion

220 ?m$:m$="WHAT"

#region "The parser"
!- Get user input
230 input "WHAT WILL YOU DO NOW";q$
!- ==========================================================================
!- Clear the working variables
!- v$: the verb string
!- w$: the noun string
!- vb: the index into the verb array - v$(i)
!- ob: the index into the noun array - o$(i)
!- 
!- Our aim is to find 2 words separated by a space. The 1st is the verb,
!- the 2nd (if present) is the noun (object).
!-
!- ==========================================================================
240 v$="":w$="":vb=0:ob=0
!- index through q$ 1 character at a time...
250 for i = 1 to len(q$)
!- If we find a space, we store the prior charactersd as the verb, if we don't
!- already have one...
260 if mid$(q$, i, 1) = " " and v$ = "" then v$ = left$(q$, i - 1)
!- Otherwise check the next character in q$. If it is not a space and we have
!- the verb (ie: v$ is not empty), then deem the remaining segment of q$
!- as the noun (object). Bail from the for...next
270 ifmid$(q$,i+1,1)<>" "andv$<>""thenw$=mid$(q$,i+1, len(q$) - 1):i = len(q$)
280 next i
!- If there is no noun, then assume the user only gave a verb.
290 if w$ = "" then v$ = q$
!- Determine which verb we have...
300 for i = 1 to v
310 if v$ = v$(i) then vb = i
320 next i
!- Determine which noun we have.
330 for i = 1 to w
340 if w$ = o$(i) then ob = i
350 next i
!- The noun is not recongnised...
360 if w$ > " " and ob = 0 then m$ = "THAT'S SILLY!"
!- The verb is not recognised, so set the verb to "HELP".
370 if vb = 0 then vb = v + 1
!- Error messages for bad input.
380 if w$ = "" then m$ = "I NEED TWO WORDS."
!- Invalid verb with valid object...
390 if vb > v and ob > 0 then m$ = "YOU CAN'T '" + q$ + "'"
!- Invalid verb and invalid object...
400 if vb > v and ob = 0 then m$ = "YOU DON'T MAKE SENSE"
!- Valid verb and valid object, but you don't have the object...
410 if vb < v and ob > 0 AND c(ob) = 0 then m$ = "YOU DON'T HAVE '" + w$ + "'"
#endregion


#region "Events and Environment Status Control"
415 if f(26) <> 1 or rm <> 13 or vb <> 21 then goto 430
420 if (int(rnd(1) * 3) + 1) <>3 then m$ = "BAT'S ATTACKING!":goto 90
430 if rm = 44 and (int(rnd(1) * 2) + 1) = 1 and f(24) <> 1 then f(27) = 1
440 if f(0) = 1 then ll = ll - 1
450 if ll < 1 then f(0) = 0
#endregion

!- Branch to verb handlers...
459 if vb > 15 then 465
460 on vb gosub 500,570,640,640,640,640,640,640,640,980,980,1030,1070,1140,1180
462 goto 470
465 on vb - 15 gosub 1220,1250,1300,1340,1380,1400,1430,1460,1490,1510,1590

!- Handle the candle as turns pass...
470 if ll = 10 then m$ = "YOUR CANDLE IS WANING!"
480 if ll = 1 then m$ = "YOU CANDLE IS OUT!"
490 goto 90

#region "VERBS"
!- HELP
500 ? "WORDS I KNOW:"
510 for i = 1 to v
520 ? v$(i);","
530 next i
540 m$ = "":?
550 gosub 1580
560 return

!- CARRYING?
570 ? "YOU ARE CARRYING:"
580 for i = 1 to g
590 if c(i) = 1 then ? o$(i);",";
600 next i
610 m$ = "":?
620 gosub 1580
630 return

!- GO,N,S,W,E,U,D
640 d = 0
650 if ob = 0 then d = vb - 3
660 if ob = 19 then d = 1
670 if ob = 20 then d = 2
680 if ob = 21 then d = 3
690 if ob = 22 then d = 4
700 if ob = 23 then d = 5
710 if ob = 24 then d = 6
720 if rm = 20 then d = 5 then d = 1
730 if rm = 20 then d = 6 then d = 3
740 if rm = 22 then d = 6 then d = 2
750 if rm = 22 then d = 5 then d = 3
760 if rm = 36 then d = 6 then d = 1
770 if rm = 36 then d = 5 then d = 2
780 if f(14) = 1 then m$ = "CRASH! YOU FELL OUT OF THE TREE!":f(14) = 0:return
790 if f(27) = 1 and rm = 52 then m$ = "GHOSTS WILL NOT LET YOU MOVE":return
800 if rm=45 aN c(1)=1 aN f(34)=0 tH m$="A MAGICAL BARRIER TO THE WEST":return
810 if (rm=26 and f(0)=0) and (d=1 or d=4) then m$ = "YOU NEED A LIGHT":return
820 if rm = 54 and c(15) <> 1 then m$ = "YOU'RE STUCK!":return
830 ifc(15)=1aN nO(rm>52orrm<56orrm=47)tHm$="YOU CAN'T CARRY A BOAT!":return
840 if (rm>26 and rm<30) and f(0)=0 then m$="TOO DARK TO MOVE":return
850 f(35)=0:rl=len(r$(rm))
860 for i = 1 to rl
870 u$ = mid$(r$(rm), i, 1)
880 if (u$ ="N" and d=1 and f(35)=0) then rm = rm - 8:f(35) = 1
890 if (u$ ="S" and d=2 and f(35)=0) then rm = rm + 8:f(35) = 1
900 if (u$ ="W" and d=3 and f(35)=0) then rm = rm - 1:f(35) = 1
910 if (u$ ="e" and d=4 and f(35)=0) then rm = rm + 1:f(35) = 1
920 next i
930 m$ = "OK"
940 if f(35)=0 then m$="YOU CAN'T GO THAT WAY!"
950 if d<1 then m$= "GO WHERE?"
960 if rm=41 and f(23)=1 then r$(49)="SW":m$="THE DOOE SLAMS SHUT!":f(23)=0
970 return



!- GET,TAKE
980 if ob>g then m$ = "I CAN'T GET " + w$:return
990 if l(ob) <> rm then m$ = "IT ISN'T HERE"
1000 if c(ob) = 2 then m$ = "YOU ALREADY HAVE IT"
1010 ifob>0andl(ob)=rm and f(ob)=0 then c(ob)=1:l(ob)=65:m$="YOU HAVE THE "+w$
1020 return

!- OPEN
1030 if rm=43 and (ob=28 or ob=29) then f(17)=0:m$="DRAWER OPEN"
1040 if rm=28 and ob=25 then m$="IT'S LOCKED"
1050 if rm=38 and ob=32 then m$="THAT'S CREEPY!":f(2)=0
1060 return


!- EXAMINE
1070 if ob=30 then f(18)=0:m$="SOMETHING HERE!"
1080 if ob=31 then m$="THAT'S DISGUSTING!"
1090 if(ob=28 or ob=29) then m$="THERE'S A DRAWER..."
1100 if ob=33 or ob=5 then gosub 1140
1110 if rm=43 and ob=35 then m$="THERE IS SOMETHING BEYOND..."
1120 if ob=32 then gosub 1030
1130 return

!- READ
1140 if rm=42 and ob=33 then m$="THEY ARE DEMONIC WORKS"
1150 if(ob=3orob=36)andc(3)=1andf(34)=0tHm$="USE THIS WORD WITH CARE 'XZANFAR'"
1160 ifc(5)=1 and ob=5 then m$="THE SCRIPT IS IN AN ALIEN TONGUE"
1170 return

!- SAY
1180 m$="OK '" + w$ +"'"
1190 ifc(3)=1andob=34tHm$="*MAGIC OCCURS*":ifrm<>45thenrm=int(rnd(63)*63)+1
1200 if c(3)=1 and ob=34 and rm=45 then f(34) = 1
1210 return

!- DIG
1220 if c(12)=1 then m$="YOU MADE A HOLE"
1230 ifc(12)=1aNrm=30tHm$="DUG BARS OUT":d$(rm)="HOLE IN A WALL":r$(rm)="NSE"
1240 return

!- SWING
1250 if c(14)<>1 and rm=7 then m$="THIS IS NO TIME TO PLAY GAMES"
1260 if ob=14 and c(14)=1 then m$="YOU SWUNG IT"
1270 if ob=13 and c(13)=1 then m$"WHOOSH!"
1280 if ob<>13 or c(13)<>1 or rm<>43 then return
1285 r$(rm)="WN":d$(rm)="STUDY WITH SECRET ROOM":m$="YOU BROKE THE THIN WALL"
1290 return

!- CLIMB
1300 if ob<>14 then return
1305 if c(14)=1 then m$="IT ISN'T ATTACHED TO ANYTHING!"
1308 if rm<>7 then return
1310 ifc(14)<>1aNf(14)=0tHm$="YOU SEE FOREST AND CLIFF SOUTH":f(14)=1:return
1320 if c(14)<>1 and f(14)=1 then m$="GOING DOWN!":f(14)=0
1330 return

!- LIGHT
1340 if ob<>17 or c(17)<>1 then return
1345 if c(8)=0 then m$="IT WILL BURN YOUR HANDS"
1350 if c(9)=0 then m$="NOTHING TO LIGHT IT WITH"
1360 if c(9)=1 and c(8)=1 then m$="IT CASTS A FLICKERING LIGHT":f(0)-1
1370 return

!- UNLIGHT
1380 if f(0)=1 then f(0)=0:m$="EXTINGUISHED"
1390 return

!- SPRAY
1400 if ob=26 and c(16)=1 then m$="HISSSS"
1410 if ob=26 and c(16)=1 and f(26)=1 then f(26)=0:m$="PFFT! GOT 'EM"
1420 return

!- USE
1430 if ob=10 and c(10)=1 and c(11)=1 then m$="SWITCHED ON":f(24)=1
1440 if f(27)=1 and f(24)=1 then m$="WHIZZ-VACUUMED UP THE GHOSTS!":f(27)=0
1450 return

!- UNLOCK
1460 if rm=43 and (ob=27 or ob=28) then gosub 1030
1470 if rm<>28 or ob<>25 or f(25)<>0 then return
1475 ifc(18)=1tHf(25)=1:r$(rm)="SEW":d$(rm)="HUGE OPEN DOOR":m$="THE KEY TURNS!"
1480 return

!- LEAVE
1490 if c(ob)=1 then c(ob)=0:l(ob)=rm:m$="DONE"
1500 return

!- SCORE
1510 s=0
1520 for i = 1 to g
1530 if c(i)=1 then s = s + 1
1540 next i
1550 if s<>17 then ?"YOU HAVE MORE OBJECTS TO FIND...":goto 1580
1555 ifc(15)<>1aNrm<>57tH?"EVERYTHING FOUND!":?"RETURN TO GATE FOR FINAL SCORE"
1560 ifrm=57tH?"DOUBLE SCORE FOR REACHING HERE!":s=s*2
1570 ?"YOUR SCORE = ";s:if s>18 then ? "WELL DONE! YOU FINISHED THE GAME":END
1580 input "PRESS RETURN TO CONINUE...";q$
1590 return

TODO find gaps in the verbs to add QUIT
TODO QUIT should ask for option to start again or reset
TODO SCORE should give progress score
TODO add instructions and back story
TODO add sound effects and maybe a sprite or 4 for some events

#endregion

#region "Iinitialisation"
!-=============================================================================
!-r$: location descriptions
!-d$: location exits
!-o$: nouns (objects)
!-v$: verbs
!-c(w): the player inventory array
!-l??????
!-f(w): object flag array, with 1 flag for each object
!-=============================================================================
1600 dim r$(63),d$(63),o$(w),v$(v)
1610 dim c(w),l(g),f(w)
1620 data 46,38,35,50,13,18,28,42,10,25,26,4,2,7,47,60,43,32
1630 for i = 1 to g
1640 read l(i)
1650 next i
1660 data HELP,CARRYING?,GO,N,S,W,E,U,D,GET,TAKE,OPEN,EXAMINE,READ,SAY
1670 data DIG,SWING,CLIMB,LIGHT,UNLIGHT,SPRAY,USE,UNLOCK,LEAVE,SCORE
1680 for i = 1 to v
1690 read v$(i)
1700 next i

1710 data SE,WE,WE,SWE,WE,WE,SWE,WS
1720 data NS,SE,WE,NW,SE,W,NE,NSW
1730 data NS,NS,SE,WE,NWUD,SE,WSUD,NS
1740 data N,NS,NSE,WE,WE,NSW,NS,NS
1750 data S,NSE,NSW,S,NSUD,N,N,NS
1760 data NE,NW,NE,W,NSE,WE,W,NS
1770 data SE,NSW,E,WE,NW,S,SW,NW
1780 data NE,NWE,WE,WE,WE,NWE,NWE,W

1790 for i = 0 to 63
1800 read r$(i)
1810 next i

1820 data DARK CORNER,OVERGROWN GARDEN,BY LARGE WOODPILE,YARD BY RUBBISH
1830 data WEEDPATCH,FOREST,THICK FOREST,BLASTED TREE
1840 data CORNER OF HOUSE,ENTRANCE TO KITCHEN,KITCHEN & GRIMY COOKER
1845 data SCULLERY DOOR
1850 data ROOM WITH INCHES OF DUST,REAR TURRET ROOM,CLEARING BY HOUSE,PATH
1860 data SIDE IF HOUSE,BACK OF HALLWAY,DARK ALCOVE,SMALL DARK ROOM
1870 data BOTTOM OF SPIRAL STAIRCASE,WIDE PASSAGE,SLIPPERY STEPS,CLIFFTOP
1880 data NEAR CRUMBLING WALL,GLOOMY PASSAGE,POOL OF LIGHT
1885 data IMPRESSIVE VAULTED HALLWAY
1890 data HALL BY THICK WOODEN DOOR,TTROPHY ROOM,CELLAR WITH BARRED WINDOW
1895 data CLIFF PATH
1900 data CUPBOARD WITH AHNGING COAT,FRONT HALL,SITTING ROOM,SECRET ROOM
1910 data STEEP MARBLE STAIRS,DINING ROOM,DEEP CELLAR WITH COFFIN,CLIFF PATH
1920 data CLOSET,FRONT LOBBY,LIBRARY OF EVIL BOOKS
1925 data STUDY WITH DESK & HOLE IN WALL
1930 data WEIRD COBWEBBY ROOM,VERY OLD CHAMBER,SPOOKY ROOM,CLIFF PATH BY MARSH
1940 data RUBBLE STREWN VERANDAH,FRONT PORCH,FRONT TOWER,SLOPING CORRIDOR
1950 data UPPER GALLERY,MARSH BY WALL,MARSH,SOGGY PATH
1960 data TWISTED RAILING,PATH THROUGH IRON GATE,BY RAILINGS,BENEATH FRONT TOWER
1970 data DEBRIS FROM CRUMBLING FACADE,LARGE FALLEN BRICKWORK
1975 data ROTTING STONE ARCH,CRUMBLING CLIFFTOP

1980 for i = 0 to 63
1990 read d$(i)
2000 next i

2010 data PAINTING,RING,MAGIC SPELLS,GOBLET,SCROLL,COINS,STATUS,CANDLESTICK
2020 data MATCHES,VACUUM,BATTERIES,SHOVEL,AXE,ROPE,BOAT,AEROSOL,CANDLE,KEY
2030 data NORTH,SOUTH,EAST,WEST,UP,DOWN
2040 data DOOR,BATS,GHOSTS,DRAWER,DESK,COAT,RUBBISH
2050 data COFFIN,BOOKS,XZANFAR,WALL,SPELLS

2060 for i = 1 to w
2070 read o$(i)
2080 next i

2090 f(18)=1:f(17)=1:f(2)=1:f(26)=1:f(28)=1:f(23)=1:ll=60:rm=57:m$="OK"

2100 return
#endregion