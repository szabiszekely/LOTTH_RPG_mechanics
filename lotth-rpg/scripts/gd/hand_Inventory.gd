extends ItemList

func add_slot(ID = 0):
	var item_texture = load("res://assets/sprite/Items/" + Data.get_texture_name(ID))
	var item_name = Data.get_item_name(ID)
	add_item(item_name.replace("_"," "),item_texture)
