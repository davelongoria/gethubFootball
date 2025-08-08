/// scr_palette_init(team_name)

// Master color palette (unchanged from your original)
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

// Create team palettes map if it doesn't exist yet:
if (!variable_global_exists("team_palettes")) {
    global.team_palettes = ds_map_create();

    var pal_default = [
        $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF,$FFFFFF,
        $FFFFFF, $00AEF0, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF,$FFFFFF,
        $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF,$FFFFFF,
        $3FA9F5, $FFFFFF, $00AEF0, $FFFFFF, $3FA9F5, $FFFFFF, $FFFFFF,
        $FFFFFF, $FFFFFF, $3FA9F5, $111111, $FFFFFF, $FFFFFF, $FFFFFF,
        $FFFFFF,$FFFFFF, $FFFFFF
    ];

    var pal_eagles = [
        $EDDFEC, $FFFFFF, $EDDFEC, $FFFFFF, $FFFFFF, $FFFFFF, $CECEAD, $FFFFFF,
        $0072AC, $FFFFFF, $22B14C, $196580, $39C13A, $FFFFFF, $FFFFFF, $22B14C,
        $FFFFFF, $FFFFFF, $E2CFC2, $22B14C, $FFFFFF, $1C6E85, $FFFFFF, $0068AB,
        $FFFFFF, $1C6E85, $FFFFFF, $22B14C, $FFFFFF, $E2CFC2, $1C6F8C, $111111,
        $FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF, $22B14C, $FFFFFF
    ];

    var pal_broncos = [
        $050607,$000086,$ECECEC,$ECECEC,$ECECEC,$560093,
		$0054A6,$EE145B,$0054A6,$8A0089,$F40000,$3939E5,
		$9E0B0F,$505050,$EE1C24,$CB2600,$F52F00,$EE1C24,
		$0000FF,$0000FF,$E35454,$0068AB,$E87800,$0054A6,
		$F069F0,$0068AB,$63DD63,$F0BD00,$EEC39A,$FFFFFF,
		$0068AB,$111111,$222222,$333333,$444444,$555555,
		$0000FF,$666666
    ];
	var pal_ponchos = [
        $FFFFFF,$FFFFFF,$FFFFFF,$ECECEC,$FFFFFF,$FFFFFF,$FFFFFF,
		$FFFFFF,$00AEF0,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,
		$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,
		$3FA9F5,$FFFFFF,$00AEF0,$FFFFFF,$3FA9F5,$FFFFFF,$FFFFFF,
		$FFFFFF,$FFFFFF,$3FA9F5,$111111,$FFFFFF,$FFFFFF,$FFFFFF,
		$FFFFFF,$FFFFFF,$FFFFFF
    ];
var pal_americans = [
        $B7B7B7,$FFFFFF,$B7B7B7,$D7D7D7,$D7D7D7,$FFFFFF,$0068AB,
		$EE1C24,$0072BC,$FFFFFF,$0000FF,$BD5415,$0000FF,$FFFFFF,
		$A0410D,$0000FF,$FFFFFF,$EE145B,$FFFFFF,$ECECEC,$FFFFFF,
		$1C75BC,$FFFFFF,$0072BC,$FFFFFF,$1C75BC,$FFFFFF,$FFFFFF,
		$FFFFFF,$FFFFFF,$1C75BC,$111111,$FFFFFF,$FFFFFF,$FFFFFF,
		$FFFFFF,$FFFFFF,$FFFFFF
    ];
var pal_redraiders = [
        $B7B7B7,$FFFFFF,$0000FF,$0000FF,$D7D7D7,$FFFFFF,$0068AB,$0000FF,
		$0068AB,$FFFFFF,$0000FF,$0000FF,$0000FF,$FFFFFF,$0000FF,$0000FF,
		$FFFFFF,$0000FF,$FFFFFF,$ECECEC,$FFFFFF,$1C6EA5,$FFFFFF,$0072BC,
		$FFFFFF,$1C6EA5,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$1C75BC,$111111,
		$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF
    ];
var pal_tennesseebears = [
        $B7B7B7,$FFFFFF,$0000FF,$0000FF,$D7D7D7,$FFFFFF,$0068AB,$0000FF,
		$0068AB,$FFFFFF,$0000FF,$0000FF,$0000FF,$FFFFFF,$0000FF,$0000FF,
		$FFFFFF,$0000FF,$FFFFFF,$ECECEC,$FFFFFF,$1C6EA5,$FFFFFF,$0072BC,
		$FFFFFF,$1C6EA5,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$1C75BC,$111111,
		$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF
    ];
	
	var pal_miamisharks = [
        $B7B7B7,$FFFFFF,$FFFF00,$BFA829,$D7D7D7,$FFFFFF,$0068AB,$FFFFFF,
		$0068AB,$FFFFFF,$FFF200,$FFF200,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,
		$FFFFFF,$BC9C1A,$FFFFFF,$FFF200,$FFFFFF,$1C6EA5,$FFFFFF,$0072BC,
		$FFFFFF,$1C6EA5,$FFFFFF,$FFFFFF,$FFFFFF,$00AEF0,$1C6EA5,$111111,
		$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF
    ];
	var pal_peckers = [
       $ECECEC,$FFFFFF,$00FFFF,$00FFFF,$FFFFFF,$FFFFFF,$00FFFF,$00A651,
	   $00AEF0,$FFFFFF,$22B14C,$22B14C,$22B14C,$FFFFFF,$ECECEC,$22B14C,
	   $FFFFFF,$00A99D,$39B54A,$00FFFF,$22B14C,$3FA9F5,$FFFFFF,$00AEF0,
	   $FFFFFF,$3FA9F5,$FFFFFF,$22B14C,$FFFFFF,$00FFFF,$3FA9F5,$111111,
	   $FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$00FFFF,$FFFFFF

    ];
	var pal_steelcity = [
       $B7B7B7,$FFFFFF,$363636,$363636,$D7D7D7,$FFFFFF,$0068AB,
       $00FFFF,$0068AB,$FFFFFF,$00FFFF,$00FFFF,$00FFFF,$FFFFFF,
       $363636,$363636,$FFFFFF,$33CCCC,$00FFFF,$ECECEC,$FFFFFF,
       $1C6EA5,$FFFFFF,$0072BC,$FFFFFF,$1C6EA5,$FFFFFF,$00FFFF,
       $FFFFFF,$363636,$1C75BC,$111111,$FFFFFF,$FFFFFF,$FFFFFF,
       $FFFFFF,$FFFFFF,$FFFFFF

    ];
	var pal_puffs = [
      $00AEF0,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,
      $0000FF,$00AEF0,$FFFFFF,$0000FF,$FFFFFF,$FFFFFF,$FFFFFF,
      $0000FF,$00AEF0,$FFFFFF,$ECECEC,$0000FF,$FFFFFF,$00AEF0,
      $3FA9F5,$FFFFFF,$00AEF0,$FFFFFF,$3FA9F5,$FFFFFF,$00AEF0,
      $FFFFFF,$FFFFFF,$3FA9F5,$00AEF0,$FFFFFF,$FFFFFF,$FFFFFF,
      $FFFFFF,$0000FF,$FFFFFF

    ];
	var pal_bolts = [
      $D7D7D7,$FFFFFF,$D53340,$EE145B,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,
      $00AEF0,$FFFFFF,$FFFFFF,$EE145B,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,
      $FFFFFF,$EE145B,$FFFFFF,$FFFFFF,$FFFFFF,$3FA9F5,$FFFFFF,$00AEF0,
      $FFFFFF,$3FA9F5,$FFFFFF,$00FFFF,$FFFFFF,$00FFFF,$3FA9F5,$00FFFF,
      $FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$00FFFF,$FFFFFF

    ];
	var pal_buffalos = [
      $FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,
	  $00AEF0,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$0000FF,
	  $FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$3FA9F5,$FFFFFF,$00AEF0,
	  $FFFFFF,$3FA9F5,$FFFFFF,$FFFFFF,$FFFFFF,$0000FF,$3FA9F5,$111111,
	  $FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$9E0B0F,$FFFFFF

    ];
    ds_map_add(global.team_palettes, "Default", pal_default);
    ds_map_add(global.team_palettes, "Eagles", pal_eagles);
    ds_map_add(global.team_palettes, "Broncos", pal_broncos);
	ds_map_add(global.team_palettes, "Ponchos", pal_ponchos);
	ds_map_add(global.team_palettes, "Americans", pal_americans);
	ds_map_add(global.team_palettes, "Red Raiders", pal_redraiders);
	ds_map_add(global.team_palettes, "Tennessee Bears", pal_tennesseebears);
	ds_map_add(global.team_palettes, "Steel City", pal_steelcity);
	ds_map_add(global.team_palettes, "Miami Sharks", pal_miamisharks);
	ds_map_add(global.team_palettes, "Peckers", pal_peckers);
	ds_map_add(global.team_palettes, "Puffs", pal_puffs);
	ds_map_add(global.team_palettes, "Bolts", pal_bolts);
	ds_map_add(global.team_palettes, "Buffalos", pal_buffalos);

}

// Set global.current_pal based on argument
if (ds_map_exists(global.team_palettes, argument0)) {
    global.current_pal = global.team_palettes[? argument0];
    global.current_team = argument0;
} else {
    global.current_pal = global.team_palettes[? "Default"];
    global.current_team = "Default";
}

global.palette_size = array_length(global.current_pal);
global.selected_sw = -1;

scr_palette_surface_refresh();

