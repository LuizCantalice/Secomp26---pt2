extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var going_up:bool = false
@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not going_up:
		velocity += get_gravity() * delta
	if is_on_floor():
		going_up = true
		timer.start()
		animated_sprite_2d.play("up")
	
	if going_up:
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file("res://Cenas/game_over_perdeu.tscn")


func _on_timer_timeout() -> void:
	going_up = false
	animated_sprite_2d.play("down")
	
