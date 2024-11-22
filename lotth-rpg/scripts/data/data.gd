extends Node

var content : Dictionary
#Save file we have
const  SAVE_FILE = "user://itemsavelist.dat"
#storing data

func _ready() -> void:
	
	
	var file = FileAccess.open("res://scripts/data/LOTTH_Item_database.json",FileAccess.READ)
	
	content = JSON.parse_string(file.get_as_text())
	
	file.close()
	
func get_texture_name(ID = 0):
	return content["Items"][ID]["Texture"]
	
func get_item_name(ID = 0):
	return content["Items"][ID]["Name"]

func get_item_id(ID = 0):
	return content["Items"][ID]["Id"]
	
func get_item_data(ID = 0):
	return content["Items"][ID]

func get_actions_of_enemy(ID = 0):
	var content_list = []
	for i in [content["Actions"][ID]["Action 1"],content["Actions"][ID]["Action 2"],content["Actions"][ID]["Action 3"],content["Actions"][ID]["Action 4"],content["Actions"][ID]["Action 5"],content["Actions"][ID]["Action 6"]]:
		if not i == "" and not i ==  " ":
			content_list.append(i)
	return content_list

# SAVES THE GAME
func save_data(list_of_items:Array):
	var file = FileAccess.open(SAVE_FILE,FileAccess.WRITE)
	
	file.store_var(list_of_items)
	
	file = null

# LOADS THE SAVE FILE FROM FILE
func load_data(list_of_items:Array):
	if not FileAccess.file_exists(SAVE_FILE):
		
		save_data(list_of_items)
	
	var file = FileAccess.open(SAVE_FILE,FileAccess.READ)
	list_of_items = file.get_var()
	
	return list_of_items
