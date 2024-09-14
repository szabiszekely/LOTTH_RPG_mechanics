extends Node2D

@onready var OBJ_randomizer: Array = [preload("res://Objects_scripts_and_scenes/rock_obj_1.tscn")
,preload("res://Objects_scripts_and_scenes/tree_obj_1.tscn")
,preload("res://Objects_scripts_and_scenes/trunk_obj_1.tscn")
,preload("res://Objects_scripts_and_scenes/bush_obj_1.tscn")
,preload("res://Objects_scripts_and_scenes/puddle_obj.tscn")
] 

@onready var OBJ_spots: Array = [$Marker2D,$Marker2D2,$Marker2D3,$Marker2D4, $Marker2D5, $Marker2D6]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var spot_randomizer = randi_range(0,OBJ_spots.size())
	#print(spot_randomizer)
	for s in spot_randomizer:
		randomize()
		
		var object = randi_range(0,OBJ_randomizer.size() - 1)
		var instance = OBJ_randomizer[object].instantiate()
		add_child(instance)
		var spot_pick = OBJ_spots.pick_random()
		#print(spot_pick)
		instance.position = spot_pick.position
		OBJ_spots.erase(spot_pick)
		
