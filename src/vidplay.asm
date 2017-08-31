

#include "../oric-common/include/asm/telemon.h"
#include "../oric-common/include/asm/macro_orix.h"
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

  lda #$06 ; Load the 3 first bytes : the movie type, and the length of each frames

  ldy #$00
  BRK_TELEMON(XFREAD)
  
loopme
  lda #<$a000
  sta PTR_READ_DEST
  lda #>$a000
  sta PTR_READ_DEST+1	

  lda sizeframe ; read a frame (6KB)

  ldy sizeframe+1
  BRK_TELEMON(XFREAD)

  jmp loopme ; never end but loop all the file
  
  rts

format
  .dsb 3,0 ; VHI pattern
  .dsb 1,0 ; Type : 0 raw
  
sizeframe
  .dsb 2,0

  



