function SelectionBox()
constructor {
    entity = noone;

    pos_x = mouse_x;
    pos_y = mouse_y;

    update = function() {
        pos_x = mouse_x;
        pos_y = mouse_y;
    };

selectOnClick = function()
{
    if (mouse_check_button_pressed(mb_left)) {
        var clicked = instance_position( pos_x, pos_y, obj_clickable );

        if (clicked == entity) {
            entity = noone;
        } else if (clicked != noone) {
            entity = clicked;
        } else {
            entity = noone;
        }
    }
};
}