extends Node2D

@export var brick_scene: Resource



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var width = get_viewport_rect().size.x/2.5
	var height = get_viewport_rect().size.y/2
	if(get_node("/root/Main/brickBlock1") == get_node(".")):
		print("YESS")
		for i in 4:
			for j in 8:
				if(((i != 3 && i != 0) || (j < 2 || j > 5)) && (j >= 2) && (j != 5)):
					var new_brick = brick_scene.instantiate()
					new_brick.position = Vector2(width / 5 * i, height / 5 * j)
					add_child(new_brick)
	if(get_node("/root/Main/brickBlock2") == get_node(".")):
		print("NO")
		for i in 4:
			for j in 8:
				if(((i != 3 && i != 0) || (j < 2 || j > 5)) && (j != 5)):
					var new_brick = brick_scene.instantiate()
					new_brick.position = Vector2(width / 5 * i, height / 5 * j)
					add_child(new_brick)
	if(get_node("/root/Main/brickBlock3") == get_node(".")):
		print("oh")
		var new_brick = brick_scene.instantiate()
		add_child(new_brick)
		new_brick.get_child(2).play("Brick_move")
		
	if(get_node("/root/Main/brickBlock4") == get_node(".")):
		print("oh")
		var new_brick = brick_scene.instantiate()
		add_child(new_brick)
		new_brick.get_child(2).play("Brick_move")
	

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
