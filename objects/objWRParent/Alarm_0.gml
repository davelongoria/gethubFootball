/// @description Insert description here
// You can write your code in this editor
// Alarm[0] Event

caught = false;
hasBall = false;
returning = false;
celebration_timer = 0;
jumping = false;

with (objFootball) {
    visible = true;
    speed = 0;
    attached_to = noone;
    x = objScrimmageMarker.x;
    y = 616;
}
/*
with (objQB) {
    x = objScrimmageMarker.x - 50;
    y = 664;
    sprite_index = sprQbPresnap_gry;
}
