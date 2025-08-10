/// scr_make_random_roster(n) -> array of players with stats + portrait
function scr_make_random_roster(n)
{
    if (!variable_global_exists("PAL_SKIN")) scr_portrait_palettes_init();

    // Position “shape” for a reasonable 53. Tweak if you like.
    var shape = [
        ["QB", 3], ["RB", 4], ["FB",1],
        ["WR", 6], ["TE",3],
        ["OL", 9],
        ["DE",2], ["DT",3], ["DL",2], // you have DL too—keepers
        ["LB",7],                      // mix of MLB/OLB if you prefer
        ["CB",5], ["FS",2], ["SS",2], ["DB",2],
        ["K",1], ["P",1], ["LS",1]
    ];

    // Flatten to a list of desired positions up to n
    var positions = [];
    for (var i = 0; i < array_length(shape); i++) {
        var pos = shape[i][0], count = shape[i][1];
        for (var c = 0; c < count; c++) array_push(positions, pos);
    }
    // pad or trim:
    while (array_length(positions) < n) array_push(positions, "WR");
    if (array_length(positions) > n) array_resize(positions, n);

    var out = array_create(n, 0);

    for (var idx = 0; idx < n; idx++) {
        var pos = positions[idx];

        // quick stat ranges by position (tune to your game feel)
        var spd = irandom_range(50, 95);
        var agi = irandom_range(50, 95);
        var tck = irandom_range(20, 95);
        var thr = irandom_range(10, 95);
        var brs = irandom_range(40, 95);
        var trk = irandom_range(20, 95);
        var dur = irandom_range(60, 95);

        // bias a few by role
        switch (pos) {
            case "QB": thr = irandom_range(80, 99); spd = irandom_range(55, 85); break;
            case "RB": spd = irandom_range(80, 99); agi = irandom_range(75, 99); trk = irandom_range(45, 90); break;
            case "WR": spd = irandom_range(82, 99); agi = irandom_range(80, 99); break;
            case "TE": agi = irandom_range(65, 85); trk = irandom_range(60, 95); break;
            case "OL": tck = irandom_range(75, 99); spd = irandom_range(45, 65); trk = irandom_range(70, 99); break;
            case "DL": case "DE": case "DT":
                tck = irandom_range(80, 99); spd = irandom_range(55, 80); trk = irandom_range(70, 99); break;
            case "LB": tck = irandom_range(80, 99); spd = irandom_range(60, 88); break;
            case "CB": case "FS": case "SS": case "DB":
                spd = irandom_range(82, 99); agi = irandom_range(80, 99); tck = irandom_range(60, 90); break;
            case "K":  thr = irandom_range(70, 95); spd = irandom_range(40, 60); break;
            case "P":  thr = irandom_range(70, 95); spd = irandom_range(40, 60); break;
            case "LS": tck = irandom_range(60, 85); spd = irandom_range(45, 65); break;
        }

        var num = irandom_range(1, 99);

        out[idx] = {
            name       : scr_random_name(), // small helper below
            pos        : pos,
            throw_pwr  : thr,
            speed      : spd,
            tackle     : tck,
            agility    : agi,
            burst      : brs,
            truck      : trk,
            durability : dur,
            num        : num,
            portrait   : scr_portrait_random() // uses your portrait stack
        };
    }
    return out;
}

/// scr_random_name() – dumb name generator (swap with your own lists)
function scr_random_name() {
    var first = ["David","Michael","Robert","John","William","Joseph","Charles","Christopher","Daniel","Matthew","Anthony","Joshua","Nathan","Kevin","Brian","George","Edward","Timothy","Jason","Jeffrey","Ryan","Jacob","Gary","Nicholas","Eric","Stephen","Jonathan","Larry","Justin","Scott","Brandon","Frank","Benjamin","Samuel","Gregory","Patrick","Raymond","Jack","Dennis","Jerry","Tyler","Aaron","Henry","Walter","Peter","Douglas","Zachary","Harold","Carl","Russell","Philip","Ethan","Adam","Shawn","Cameron","Logan","Connor","Travis"];
    var last  = ["Long","Johnson","Carter","Brown","Davis","Garcia","Martinez","Robinson","Lewis","Lee","Walker","Hall","Allen","Longoria","Adams","Baker","Gonzalez","Nelson","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Moore","Bennett","Turner","Scott","Bell","Hughes","Hill"];
    return first[irandom(array_length(first)-1)] + " " + last[irandom(array_length(last)-1)];
}
