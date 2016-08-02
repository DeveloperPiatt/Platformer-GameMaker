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
    
    // control jump height
    if (up_release && vspd < -6) {
        vspd = -6;
    }
} else {
    vspd = 0;
    
    // Jump code
    if (up) {
        vspd = -16;
    }
}

if (right) {
    hspd = spd;
}

if (left) {
    hspd = -spd;
}

// Flips the sprite to face correct direction
if (hspd != 0) {
    image_xscale = sign(hspd);
}

// Friction
if (!right && !left) {
    hspd = 0;
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

    state = ledge_grab_state;
}
