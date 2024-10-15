extends Node2D
class_name  Player_group

@onready var player_damage = preload("res://scripts/resources/CH/Lil_Guy_Fighting_Stats.tres")

var player: Array = []
var index: int = 0

# when the game starts than grab player! if its his turn
func _ready() -> void:
	player = get_children()
	player[0].player_cam_target.enabled = true
