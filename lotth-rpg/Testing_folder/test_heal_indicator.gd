extends Node2D

@onready var damage_indicator = preload("res://scenes/con_damage_number_indicator.tscn")


# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button"):
		var instance = damage_indicator.instantiate()
		instance.healing_or_damaging = true
		self.add_child(instance)
		instance.helaing_taken(1,1)
	if event.is_action_pressed("1"):
		var instance = damage_indicator.instantiate()
		instance.healing_or_damaging = true
		self.add_child(instance)
		instance.helaing_taken(0,2)
	if event.is_action_pressed("2"):
		var instance = damage_indicator.instantiate()
		instance.healing_or_damaging = true
		self.add_child(instance)
		instance.helaing_taken(2,2)
	if event.is_action_pressed("3"):
		var instance = damage_indicator.instantiate()
		instance.healing_or_damaging = true
		self.add_child(instance)
		instance.helaing_taken(60,1)
