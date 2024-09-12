extends CharacterBody2D

@export var speed: float = 400.0
@export var max_speed: float = 1000.0
@export var score_label: RichTextLabel
@export var start_text: RichTextLabel

@onready var scoreTemp: RichTextLabel = get_node("/root/Main/Score")
@onready var startTemp: RichTextLabel = get_node("/root/Main/StartText")


var forward = Vector2(1,1).normalized()
const PADDLE_WIDTH: float = 100.0
var current_score: int = 0
var is_running: bool = false
var play_again: bool = false

func _physics_process(delta: float) -> void:
	if (not is_running):
	#	start_text = startTemp
		if (Input.is_action_just_pressed("click_window")):
			start_text = startTemp
			if(play_again == true):
				print("Youd died!")
				get_tree().reload_current_scene()
			is_running = true
			start_text.visible = false
			visible = true

		return
	
	var collision: KinematicCollision2D = move_and_collide(forward * speed * delta)
	score_label = scoreTemp
	if (collision):
		forward = forward.bounce(collision.get_normal())
		speed = clamp(speed + 0.5, 1, max_speed)
		
		if (collision.get_collider().is_in_group("Bricks")):
			collision.get_collider().queue_free()
			current_score += 1
			score_label.text = "SCORE: " + str(current_score)
			#if(collision.get_collider().is_in_group("movingBrick")):
				##get_node(("/root/Main/brickBlock3")).visible = false
		if (collision.get_collider().is_in_group("SecondBall")):
			get_node("/root/Main/smallBall").speed = 250
			get_node("/root/Main/smallBall").set_collision_mask_value(1, true)
			
		
		# Paddle bounce should be based on ball position
		if (collision.get_collider().is_in_group("Paddle")):
			var paddle_x = collision.get_collider().position.x - PADDLE_WIDTH / 2
			var pos_on_paddle = (position.x - paddle_x) / PADDLE_WIDTH
			#print("Hit the paddle!" + str(pos_on_paddle))
			var bounce_angle = lerp(-PI * 0.8, -PI * 0.2, pos_on_paddle)
			forward = Vector2.from_angle(bounce_angle)
			
		#Handle game over conditions
		if (collision.get_collider().is_in_group("GameOver")):
			is_running = false
			visible = false
			start_text.visible = true
			start_text.text = "GAME OVER"
			play_again = true
	
	
func _on_slow_mo_timeout() -> void:
	Engine.time_scale = 1
