/// objColorSwatchSpawner – Using your edited groupings & order

var cell        = 32;
var x_gap       = 4;
var y_gap       = 28;
var start_x     = 190;
var start_y     = 220;
var label_x     = start_x - 120;
var layer_name  = "GUI";

// === Your custom swatch list ===
var swatch_data = [
    // Row 1
    { group: "HELMET",      row: 1, pos: 1,  idx: 0 },
    { group: "NOT USED",    row: 1, pos: 2,  idx: 13 },
    { group: "SKIN",        row: 1, pos: 3,  idx: 20 },
    { group: "SKIN",        row: 1, pos: 4,  idx: 25 },
    { group: "HELMET",      row: 1, pos: 5,  idx: 36 },
    // Row 2
    { group: "NOT USED",    row: 2, pos: 1,  idx: 6 },
    { group: "PANTS",       row: 2, pos: 2,  idx: 9 },
    { group: "SHOES",       row: 2, pos: 3,  idx: 15 },
    { group: "HELMET",      row: 2, pos: 4,  idx: 16 },
    { group: "HELMET",      row: 2, pos: 5,  idx: 22 },
    { group: "SKIN",        row: 2, pos: 6,  idx: 23 },
    { group: "HELMET",      row: 2, pos: 7,  idx: 34 },
    // Row 3
    { group: "SKIN",        row: 3, pos: 1,  idx: 3 },
    { group: "FOOTBALL",    row: 3, pos: 2,  idx: 7 },
    { group: "NOT USED",    row: 3, pos: 3,  idx: 10 },
    { group: "WRISTBAND",   row: 3, pos: 4,  idx: 17 },
    { group: "WRISTBAND",   row: 3, pos: 5,  idx: 29 },
    // Row 4
    { group: "FOOTBALL",    row: 4, pos: 1,  idx: 5 },
    // Row 5
    { group: "SKIN",        row: 5, pos: 1,  idx: 14 },
    { group: "SKIN",        row: 5, pos: 2,  idx: 21 },
    { group: "SKIN",        row: 5, pos: 3,  idx: 30 },
    // Row 6
    { group: "SKIN",        row: 6, pos: 1,  idx: 24 },
    { group: "HAIR",        row: 6, pos: 2,  idx: 26 },
    { group: "SKIN",        row: 6, pos: 3,  idx: 27 },
    { group: "PANTS",       row: 6, pos: 4,  idx: 28 },
    { group: "NOT USED",    row: 6, pos: 5,  idx: 31 },
    // Row 7
    { group: "NOT USED",    row: 7, pos: 1,  idx: 1 },
    { group: "NOT USED",    row: 7, pos: 2,  idx: 2 },
    { group: "PANTS",       row: 7, pos: 3,  idx: 4 },
    { group: "JERSEY",      row: 7, pos: 4,  idx: 8 },
    { group: "JERSEY",      row: 7, pos: 5,  idx: 11 },
    { group: "PANTS",       row: 7, pos: 6,  idx: 12 },
    { group: "JERSEY",      row: 7, pos: 7,  idx: 18 },
    { group: "JERSEY",      row: 7, pos: 8,  idx: 19 },
    { group: "NOT USED",    row: 7, pos: 9,  idx: 32 },
    { group: "PANTS",       row: 7, pos: 10, idx: 33 },
    { group: "NOT USED",    row: 7, pos: 11, idx: 35 },
    { group: "NOT USED",    row: 7, pos: 12, idx: 37 }
];

// === Prepare label list for Draw GUI ===
if (!variable_global_exists("color_swatch_labels")) global.color_swatch_labels = [];
global.color_swatch_labels = [];

// === Build swatches and labels row by row ===
var curr_row = 0;
var curr_y = start_y;
var i = 0;
while (i < array_length(swatch_data)) {
    var rownum = swatch_data[i].row;
    // Collect all swatches for this row
    var j = i;
    while (j < array_length(swatch_data) && swatch_data[j].row == rownum) {
        j++;
    }
    // Now, from i to j-1 are all swatches for this row
    var label = swatch_data[i].group;
    array_push(global.color_swatch_labels, { text: label, x: label_x, y: curr_y + cell / 2 });
    // Place all swatches in this row
    for (var k = i; k < j; ++k) {
        var cx = start_x + (swatch_data[k].pos - 1) * (cell + x_gap);
        var cy = curr_y;
        var inst = instance_create_layer(cx, cy, layer_name, objColorSwatch);
        inst.palette_index = swatch_data[k].idx;
        inst.group = swatch_data[k].group;
    }
    curr_y += cell + y_gap;
    i = j;
}

instance_destroy();
