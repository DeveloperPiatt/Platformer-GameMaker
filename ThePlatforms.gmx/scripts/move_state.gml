/// move_state()

var right = keyboard_check(vk_right);
var left = keyboard_check(vk_left);
var up = keyboard_check(vk_up);
var up_release = keyboard_check_released(vk_up);
var down = keyboard_check(vk_down);

// Gravity
if (!place_meeting(x, y+1, Solid)) {
    // we are in the air, nothing under us
    vspd += grav;
    
    // Player is in the air
    sprite_index = spr_player_jump;
    image_speed = 0;
    image_index = (vspd > 0);
    
    // control jump height
    if (up_release && vspd < -6) {
        vspd = -6;
    }
} else {
    vspd = 0;
    
    // Jump code
    if (up) {
        vspd = -jspd;
    }
    
    // Player is on the ground
    if (hspd == 0) {
        // not moving
        sprite_index = spr_player_idle;
    } else {
        // moving
        sprite_index = spr_player_walk;
        image_speed = .6;
    }
}

if (right || left) {
    hspd += (right-left)*acc;
    hspd_dir = (right-left);
    
    if (hspd > spd) {
        hspd = spd;
    }
    
    if (hspd < -spd) {
        hspd = -spd;
    }
} else {
    apply_friction(acc);
}

// Flips the sprite to face correct direction
if (hspd != 0) {
    image_xscale = sign(hspd);
}

move(Solid);

// Check for ledge grab state
var falling = y-yprevious > 0;
var wasnt_wall = !position_meeting(x+17*image_xscale, yprevious, Solid);
var is_wall = position_meeting(x+17*image_xscale, y, Solid);

if (falling && wasnt_wall && is_wall) {
    hspd = 0;
    vspd = 0;
    
    // Move against the ledge
    while (!place_meeting(x+image_xscale, y, Solid)) {
        x += image_xscale;
    }
    
    // Make sure we are the right height
    
    while (position_meeting(x+17*image_xscale, y-1, Solid)) {
        y -= 1;
    }
    sprite_index = spr_player_ledge_grab;
    state = ledge_grab_state;
}
