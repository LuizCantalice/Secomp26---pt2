extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var bullet:PackedScene
@onready var dash_timer: Timer = $dash_timer
var dash:float = 1
var jump_count:int = 0
@onready var mira: Marker2D = $mira
@onready var padrao:AnimatedSprite2D = $Node2D/padrao
var animated_sprite_2d:AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var skin_number:int = 0
var running:String = "running"
var double_jump:String = "double_jump"
var fall:String = "fall"
var idle:String = "idle"
var jump:String = "jump"


func _ready() -> void:
	animated_sprite_2d = padrao
	
func _physics_process(delta):
	# Se o personagem NÃO estiver no chão, a gravidade o puxa para baixo
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		jump_count = 0
	# Se o personagem pressionar uma tecla de pulo E estiver no chão
	if Input.is_action_just_pressed("jump") and jump_count <2:
		velocity.y = JUMP_VELOCITY
		if jump_count == 1:
			animated_sprite_2d.play(double_jump)
			print_debug(double_jump)
		jump_count += 1
	# Controla a movimentação lateral
	var direction = Input.get_axis("left", "right")
	if Input.is_action_just_pressed("dash"):
		dash = 5
		dash_timer.start()
	if direction:
		velocity.x = direction * SPEED*dash
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("shoot"):
		shoot()

	UpdateAnimations(direction)
	move_and_slide()

func UpdateAnimations(direction):
	if direction != 0:
		animated_sprite_2d.flip_h = direction < 0
	if is_on_floor():
		if direction != 0:
			animated_sprite_2d.play(running)
		else: 
			animated_sprite_2d.play(idle)
	else:
		if velocity.y > 0:
			animated_sprite_2d.play(fall)
		else:
			animated_sprite_2d.play(jump)


func _on_dash_timer_timeout() -> void:
	print_debug("timeout")
	dash = 1
	
func shoot():
	print_debug("atirei!")
	var b = bullet.instantiate()
	if animated_sprite_2d.flip_h:
		b.speed *= -1
	get_tree().get_first_node_in_group("Fase").add_child(b)
	b.transform = mira.global_transform

func update_skin(skin:int):
	print_debug("atualizado, ",skin)
	running = "running_" + str(skin)
	double_jump = "double_jump_"+ str(skin)
	fall = "fall_"+ str(skin)
	idle = "idle_"+ str(skin)
	jump = "jump_"+ str(skin)
