extends Node2D
class_name  Player_group

@onready var player_damage = preload("res://scripts/resources/CH/Lil_Guy_Fighting_Stats.tres")

var player: Array = []
var index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_children()
	player[0].player_cam_target.enabled = true
