/// hurt_state()

// set the sprite

sprite_index = spr_player_hurt;

if (hspd != 0) {
    image_xscale = sign(hspd);
}

// apply gravity
if (!place_meeting(x,y+1, Solid)) {
    vspd += grav;
} else {
    vspd = 0;
    
    // use friction
    
    apply_friction(acc);
}

direction_move_bounce(Solid);

// change state back to move

if (hspd == 0 && vspd == 0) {
    image_blend = c_white;
    state = move_state;
}
