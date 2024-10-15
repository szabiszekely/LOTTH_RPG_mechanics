extends Node2D

# this is a list that gets all placeable props!
@onready var OBJ_randomizer: Array = [preload("res://Objects_scripts_and_scenes/rock_obj_1.tscn")
,preload("res://Objects_scripts_and_scenes/tree_obj_1.tscn")
,preload("res://Objects_scripts_and_scenes/trunk_obj_1.tscn")
,preload("res://Objects_scripts_and_scenes/bush_obj_1.tscn")
,preload("res://Objects_scripts_and_scenes/puddle_obj.tscn")
] 
# get all spots!
@onready var OBJ_spots: Array = [$Marker2D,$Marker2D2,$Marker2D3,$Marker2D4, $Marker2D5, $Marker2D6,$Marker2D7, $Marker2D8, $Marker2D9, $Marker2D10, $Marker2D11, $Marker2D12]

#when game starts then:
func _ready() -> void:
	# randomize just simply and than pick a spot at random!
	randomize()
	#pick a number between 0 and all spots!
	var spot_randomizer = randi_range(0,OBJ_spots.size())
	#print(spot_randomizer)
	for s in spot_randomizer:
		#every randomized spot!
		randomize()
		# grab a random value between all objects than pick that object and add that one to the scene and than just place it to the spot it can spawn!
		var object = randi_range(0,OBJ_randomizer.size() - 1)
		var instance = OBJ_randomizer[object].instantiate()
		add_child(instance)
		var spot_pick = OBJ_spots.pick_random()
		#print(spot_pick)
		instance.position = spot_pick.position
		OBJ_spots.erase(spot_pick)
		
