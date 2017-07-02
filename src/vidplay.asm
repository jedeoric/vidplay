

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

  lda #$3 ; read a frame (6KB)

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
  .dsb 1,0
  
sizeframe
    .dsb 2,0

  



