extends CharacterBody2D

func _ready():
		set_physics_process(true)

func _physics_process(_delta):
# to get the global mouse position
	var target_x = get_global_mouse_position().x
# to calculate the new position for the paddle
	var new_position = Vector2(target_x, position.y)
# to get the paddle's half width
	var half_paddle_width = $length.shape.extents.x
# to calculate the minimum and maximum x positions
	var min_x = half_paddle_width
	var max_x = get_viewport_rect().size.x - half_paddle_width
# to ensure the new position stays within the screen bounds
	if new_position.x < min_x:
		new_position.x = min_x
	elif new_position.x > max_x:
		new_position.x = max_x
# updating the paddle's position
	position = new_position
