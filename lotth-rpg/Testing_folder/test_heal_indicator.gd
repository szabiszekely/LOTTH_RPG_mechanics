extends Node2D

@onready var damage_indicator = preload("res://scenes/con_damage_number_indicator.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = damage_indicator.instantiate()
	self.add_child(instance)
	instance
