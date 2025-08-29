extends Node

var content : Dictionary
#Save file we have
const  SAVE_FILE = "user://itemsavelist.dat"
#storing data

func _ready() -> void:
	
	
	var file = FileAccess.open("res://scripts/data/LOTTH_Item_database.json",FileAccess.READ)
	
	content = JSON.parse_string(file.get_as_text())
	
	file.close()

 
# Item-------------------------------------------

func get_texture_name(ID = 0):
	return content["Items"][ID]["Texture"]
	
func get_item_name(ID = 0):
	return content["Items"][ID]["Name"]

func get_item_id(ID = 0):
	return content["Items"][ID]["Id"]
	
func get_item_data(ID = 0):
	return content["Items"][ID]

func get_item_dmg(Name: String):
	for i in content["Items"]:
		if Name == i["Name"]:
			return i["Dmg"]

func get_item_t_dmg(Name: String):
	for i in content["Items"]:
		if Name == i["Name"]:
			return i["T.Dmg"]

func get_item_damage(Name: String):
	for i in content["Items"]:
		if Name == i["Name"]:
			if 0 < i["T.Dmg"]:
				return i["T.Dmg"]
			else:
				return i["Dmg"]

func get_item_eng(Name: String):
	for i in content["Items"]:
		if Name == i["Name"]:
			return i["Eng"]

func get_item_hp(Name: String):
	for i in content["Items"]:
		if Name == i["Name"]:
			return i["Hp"]

func get_item_atk_type(Name: String):
	for i in content["Items"]:
		if Name == i["Name"]:
			if "Melee" == i["Atk_Type"]:
				return 0
			if "Range" == i["Atk_Type"]:
				return 1
			if "Magic" == i["Atk_Type"]:
				return 2
			else:
				return 10

func get_item_damage_type(Name: String):
	for i in content["Items"]:
		if Name == i["Name"]:
			if 0 < i["T.Dmg"]:
				return true
			else:
				return false

func get_item_health_type(Name: String):
	for i in content["Items"]:
		if Name == i["Name"]:
			if 0 < i["Hp"]:
				return true
			else:
				return false

# Actions-------------------------------------------

func get_actions_of_enemy(ID = 0):
	var content_list = []
	for i in [content["Actions"][ID]["Action 1"],content["Actions"][ID]["Action 2"],content["Actions"][ID]["Action 3"],content["Actions"][ID]["Action 4"],content["Actions"][ID]["Action 5"],content["Actions"][ID]["Action 6"]]:
		if str(i) != str(0) and typeof(i) != TYPE_FLOAT:
			content_list.append(i)
	return content_list

# Cards-------------------------------------------

func get_card_damage(Name: String):
	for i in content["Abilities"]:
		if Name == i["Name"]:
			if 0 < i["T.Dmg"]:
				return i["T.Dmg"]
			else:
				return i["Dmg"]
			
func get_card_damage_type(Name: String):
	for i in content["Abilities"]:
		if Name == i["Name"]:
			if 0 < i["T.Dmg"]:
				return true
			else:
				return false
				
func get_card_ability_type(Name: String):
	for i in content["Abilities"]:
		if Name == i["Name"]:
			return i["Ability_Type"]
			
func get_card_attack_type(Name: String):
	for i in content["Abilities"]:
		if Name == i["Name"]:
			if "Melee" == i["Type"]:
				return 0
			if "Range" == i["Type"]:
				return 1
			if "Magic" == i["Type"]:
				return 2
			
func get_card_energy(Name: String):
	for i in content["Abilities"]:
		if Name == i["Name"]:
			return i["Eng"]
		
	return -1

func get_card_range(Name:String):
	for i in content["Abilities"]:
		if Name == i["Name"]:
			return i["Range"]
			
func get_card_eng_or_hp(Name:String):
	for i in content["Abilities"]:
		if Name == i["Name"]:
			return i["Eng_or_Hp"]
			
func get_card_eng_healed(Name:String):
	for i in content["Abilities"]:
		if Name == i["Name"]:
			return i["Eng_healed"]
			
func get_card_hp_healed(Name:String):
	for i in content["Abilities"]:
		if Name == i["Name"]:
			return i["Hp_healed"]

# SAVES THE GAME-------------------------------------------

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
