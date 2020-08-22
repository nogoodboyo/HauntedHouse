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


415 if f(26) <> 1 or rm <> 13 or vb <> 21 then goto 430
420 if (int(rnd(1) * 3) + 1) <>3 then m$ = "BAT'S ATTACKING!":goto 90
430 if rm = 44 and (int(rnd(1) * 2) + 1) = 1 and f(24) <> 1 then f(27) = 1
440 if f(0) = 1 then ll = ll - 1
450 if ll < 1 then f(0) = 0

1587 goto 90
1588 print "complete"
1599 end
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