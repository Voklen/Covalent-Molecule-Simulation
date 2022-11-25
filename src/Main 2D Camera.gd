extends Camera2D

var pressed = false
var initial_camera_position
var initial_mouse_position

func _ready():
	pass

func _process(delta):
	if pressed:
		var current_mouse_position = get_viewport().get_mouse_position()
		var pos_offset = initial_mouse_position - current_mouse_position
		position = initial_camera_position + pos_offset

func _input(event):
	if event.is_action_pressed("Move Camera"):
		pressed = true
		initial_camera_position = position
		initial_mouse_position = get_viewport().get_mouse_position()
	if event.is_action_released("Move Camera"):
		pressed = false
