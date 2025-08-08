/// scr_palette_init()

// 1. master list you click-through with ← / →
global.master_palette = [
    $363636,$FFFF00,$00FF00,$00FFFF,$0000FF,$FF00FF,$FFFFFF,$ECECEC,
    $E2E2E2,$D7D7D7,$CDCDCD,$B7B7B7,$959595,$EE1C24,$FFF200,$00A651,
    $00A99D,$00AEF0,$0072BC,$0068AB,$0054A6,$2E3192,$662D91,$92278F,
    $ED008C,$EE145B,$9E0B0F,$A0410D,$A3620A,$ABA000,$197B30,$22B14C,
    $1B9D93,$3FA9F5,$1C75BC,$1C6EA5,$0E59A4,$3D3C9B,$934FA1,$A348A4,
    $EA4992,$ED1C5B,$D53340,$BD5415,$BF7020,$BFA829,$8DC63F,$39B54A,
    $33CCCC,$00AEEF,$0082C9,$0071BC,$163CA4,$403DA4,$633EA1,$C0589D,
    $E93F8E,$EA1C58,$D80F2F,$A23C1A,$A65F17,$BC9C1A,$799D3C,$009245,
    $008C8C,$0084C8,$0066B3,$00448B,$4B33A2,$7E3E98,$AB4596,$F277B4,
    $F25CA9,$CF2866,$B12017,$E1511A,$D47417,$D3BA18,$8DC73F
];

// 2. palette that matches the sprite indices (dark → light)
global.palette_size = 38; 
// **define before refresh**
//green/white
global.current_pal = [
    $EDDFEC, $FFFFFF, $EDDFEC, $FFFFFF, $FFFFFF, $FFFFFF, $CECEAD, $FFFFFF,
    $0072AC, $FFFFFF, $22B14C, $196580, $39C13A, $FFFFFF, $FFFFFF, $22B14C,
    $FFFFFF, $FFFFFF, $E2CFC2, $22B14C, $FFFFFF, $1C6E85, $FFFFFF, $0068AB,
    $FFFFFF, $1C6E85, $FFFFFF, $22B14C, $FFFFFF, $E2CFC2, $1C6F8C, $111111,
    $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $22B14C, $FFFFFF
];

// 3. helpers
global.selected_sw = -1;           // no swatch selected yet

// 4. build the 31×1 surface *after* palette_size exists
scr_palette_surface_refresh();

//all white team name white eagles
/*
global.current_pal = [
    $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF,$FFFFFF,
	$FFFFFF, $00AEF0, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF,$FFFFFF,
	$FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF,$FFFFFF,
	$3FA9F5, $FFFFFF, $00AEF0, $FFFFFF, $3FA9F5, $FFFFFF, $FFFFFF,
    $FFFFFF, $FFFFFF, $3FA9F5, $111111, $FFFFFF, $FFFFFF, $FFFFFF,
	$FFFFFF,$FFFFFF, $FFFFFF
];
*/

/*// 2. palette that matches the sprite indices (dark → light)
global.palette_size = 38;          // **define before refresh**
global.current_pal = [
   // original  team name Broncos
	$050607,$000086,$0000E7,$381600,$202020,$560093,$522100,
    $681A00,$970707,$8A0089,$F40000,$3939E5,$4E4E4E,$505050,
    $008A00,$CB2600,$F52F00,$A72AEE,$F700F7,$9B51CF,$E35454,
    $31BE23,$E87800,$B78450,$F069F0,$D9A066,$63DD63,$F0BD00,
    $EEC39A,$EFF000,$F2F2F2, $111111, $222222, $333333, 
    $444444, $555555, $666666, $666666
];