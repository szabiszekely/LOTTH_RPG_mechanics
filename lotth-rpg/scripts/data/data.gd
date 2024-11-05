extends Node

var content : Dictionary

func _ready() -> void:
	var file = FileAccess.open("res://scripts/data/LOTTH_Item_database.json",FileAccess.READ)
	
	content = JSON.parse_string(file.get_as_text())
	
	file.close()
	
func get_texture_name(ID = 0):
	return content["Sheet1"][ID]["Texture"]
	
func get_item_name(ID = 0):
	return content["Sheet1"][ID]["Name"]
