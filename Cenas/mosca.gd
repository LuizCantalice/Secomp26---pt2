extends CharacterBody2D
var player:Player

const SPEED = 400.0
const JUMP_VELOCITY = -400.0
var is_chasing:bool = false

func _physics_process(delta: float) -> void:
	move_and_slide()



func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		player = area.get_parent()
		velocity = (player.global_position - global_position)*SPEED
		


func _on_timer_timeout() -> void:
	is_chasing
