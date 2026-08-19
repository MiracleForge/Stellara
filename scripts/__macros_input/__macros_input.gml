#macro INPUT_HORIZONTAL \
    (keyboard_check(vk_right) || keyboard_check(ord("D"))) \
    - (keyboard_check(vk_left) || keyboard_check(ord("A")))

#macro INPUT_VERTICAL \
    (keyboard_check(vk_down) || keyboard_check(ord("S"))) \
    - (keyboard_check(vk_up) || keyboard_check(ord("W")))

#macro INPUT_ATTACK  keyboard_check(ord("Z"))

#macro JOYSTICK_BASE  32 
#macro JOYSTICK_KNOB 24