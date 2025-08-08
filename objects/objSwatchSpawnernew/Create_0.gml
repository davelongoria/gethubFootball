var cell        = 32;
var x_gap       = 4;
var y_gap       = 6;
var start_x     = 190;
var start_y     = 180;
var label_x     = start_x - 120;
var layer_name  = "GUI";

var groups = [
    { name: "HELMET", indices: [0, 36, 20, 27, 15, 17, 31] },
    { name: "SKIN", indices: [25, 23, 21, 30, 8] },
    { name: "FOOTBALL", indices: [4] },
  //  { name: "HAIR", indices: [] },
    { name: "PANTS", indices: [3, 11, 2] },
    { name: "SHOES", indices: [14] },
    { name: "WRISTBAND", indices: [12, 19] },
    { name: "JERSEY", indices: [7, 29, 18, 6, 10] }
   // { name: "NOT_USED", indices: [16, 22, 34, 24, 5, 26, 9, 28, 33, 1, 13, 32, 35, 37] }
];



if (!variable_global_exists("color_swatch_labels")) global.color_swatch_labels = [];
global.color_swatch_labels = [];

var curr_y = start_y;
for (var g = 0; g < array_length(groups); ++g) {
    var group = groups[g];
    array_push(global.color_swatch_labels, { text: group.name, x: label_x, y: curr_y + cell / 2 });
    for (var i = 0; i < array_length(group.indices); ++i) {
        var cx = start_x + i * (cell + x_gap);
        var cy = curr_y;
        var inst = instance_create_layer(cx, cy, layer_name, objColorSwatch);
        inst.palette_index = group.indices[i];
        inst.group = group.name;
    }
    curr_y += cell + y_gap;
}
instance_destroy();
