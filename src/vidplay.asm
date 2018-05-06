

#include "../orix/src/include/orix.h"
#include "../orix/src/include/macro.h"
; ----------------------------------------------------------------------------

#define PTR_READ_DEST $2c


.text
_play:

read
  ;BRK_TELEMON(XHIRES)

  
  lda #<format
  sta PTR_READ_DEST
  lda #>format
  sta PTR_READ_DEST+1	

  lda #$08 ; Load the 8 first bytes : the movie type, and the length of each frames

  ldy #$00
  BRK_TELEMON(XFREAD)
 /*
  ldy number_of_frames+1
  lda number_of_frames
  BRK_TELEMON(XDECIM)
  */
loopme
  lda #<$a000
  sta PTR_READ_DEST
  lda #>$a000
  sta PTR_READ_DEST+1	

  lda sizeframe ; read a frame (6KB)

  ldy sizeframe+1
  BRK_TELEMON(XFREAD)
/*
  dec number_of_frames
  bne next
  dec number_of_frames+1
  bpl end
  */
next  
  jmp loopme ; never end but loop all the file
end  
  rts
.bss

  
format
  .dsb 3,0 ; VHI pattern
  .dsb 1,0 ; Type : 0 raw
number_of_frames
  .dsb 2,0
sizeframe
  .dsb 2,0

  



