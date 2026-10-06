extends Area2D
@export var skin_number:int
@export var sprite_item:Texture2D
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = sprite_item


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	print_debug("tentei pegar o item")
	if area.get_parent() is Player:
		print_debug("peguei o item")
		var player:Player = area.get_parent()
		player.update_skin(skin_number)
