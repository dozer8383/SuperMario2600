 rem Super Mario Bros. for Atari 2600
 set kernel_options playercolors pfcolors
 set optimization speed
 set smartbranching on
 const pfscore=1

 playfield:
................................
................................
................................
................................
................................
......XX........................
................................
..............................XX
............................XXXX
..........................XXXXXX
XXXXXXXXXXXXXX........XXXXXXXXXX
end

 pfcolors:
 $27
 $27
 $27
 $27
 $27
 $27
 $39
 $39
 $39
 $39
 $25
end
 player1:
        %00111100
        %01011010
        %01011010
        %11111111
        %10111101
        %10100101
        %10100101
        %01100110
        %00111100
        %00011000
end

 COLUBK = $7a
 CTRLPF = $30
 pfscorecolor = $46
 scorecolor = $0f
 pfscore1= %01010101
 player0x = 20
 player0y = 80
 ballx = 20
 bally = 47
 ballheight = $07
 rem The variable U is vertical velocity, or the speed at which Mario ascends or descends during a jump.
 u = 0 
 rem The variable G is game flags.
 rem g{0} = is touching playfield? (formerly g)
 rem g{1} = is Super Mario? (formerly b)
 rem g{2} = switch vertical velocity? (formerly s)
 rem g{3} = is jump button held? (formerly p) (this prevents Mario from flying)
 rem g{4} = direction of mario (0 is right, 1 is left)
 rem g{5} = block hit? (helps block come back down after it jumps slightly)
 rem g{6} = 
 rem g{7} = 
 g = 0
 score = 0

mainloop
 drawscreen
 player0color:
    $F2;
    $F2;
    $72;
    $72;
    $2E;
    $2E;
    $42;
    $42;
    $42;
    $2E;
    $2E;
    $2E;
    $2E;
    $2A;
    $42;
    $42;
end
 if b = 1 then player0color:
    $F2;
    $F4;
    $72;
    $72;
    $72;
    $72;
    $2C;
    $2C;
    $2C;
    $42;
    $42;
    $42;
    $42;
    $42;
    $40;
    $2C;
    $2C;
    $2C;
    $2C;
    $2C;
    $2C;
    $28;
    $42;
    $42;
    $44;
end
 player0:
        %11100111
        %10100101
        %01011010
        %01000010
        %10000001
        %10100101
        %11000011
        %11011011
        %01011010
        %01111110
        %11110000
        %01011011
        %01010110
        %00110100
        %01111111
        %00111100
end
 if b = 1 then player0:
        %11100111
        %11100111
        %10100101
        %10011001
        %10000001
        %01000010
        %10000001
        %11000011
        %11000011
        %10100101
        %11011011
        %11011011
        %11011010
        %11011010
        %00110100
        %01111100
        %11111110
        %11110000
        %11011011
        %01010111
        %00010110
        %01110100
        %11111111
        %11111000
        %01111100
end
 pfscore1 = g
 if g{0} then NUSIZ0 = $00
 if f = 2 then f = 0 else f = f + 1
 
 if collision(player0,playfield) then g{0} = 1 else g{0} = 0
 if collision(player0,ball) then g{2} = 1 : u = 1 : bally = bally - 2
 
 if !g{2} then player0y = player0y - u else player0y = player0y + u
 if !g{0} && f = 1 && !g{2} then u = u - 1
 if !g{0} && f = 1 && g{2} then u = u + 1
 if u < 1 then g{2} = 1 : u = u + 1
 if player0y > 80 || !u = 0 then u = 0 : player0y = 80
 
 if joy0right then player0x = player0x + 1
 if joy0left then player0x = player0x - 1
 if joy0up && u = 0 && p = 0 then g{2} = 0 : u = 4 : p = 1
 if !joy0up then p = 0
 
 goto mainloop
 