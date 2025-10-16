extends PanelContainer
class_name Bagpack_controls

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var inventory: ItemList = $test/Inventory
@onready var no_items: Label = $test/Label
@onready var menu_system = RefrenceNode.Menu
@onready var item_handler = RefrenceNode.ItemHandler
var deleting_item_index: int = 0
var item_list: Array = []
# set everything up
func _ready() -> void:
	self.hide()
	$CanvasLayer.hide()
	# get all the items from saved file and than put it into the inventory
	item_list = Data.load_data(item_list)
	for i in item_list:
		inventory.add_slot(i)
	
	_add_random_items()
	
	item_count_check()
	
	
# Bag appears
func bag_appear():
	inventory.grab_focus()
	inventory.select(0)
	self.show()
	inventory.ensure_current_is_visible()
	item_count_check()
	
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,519),0.3).set_trans(Tween.TRANS_QUAD)

# Bag disappear
func bag_disappear():
	inventory.release_focus()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,843),0.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished

# when you press an item you add it to the quee
func _on_item_list_item_activated(index: int) -> void:
	print(item_list)
	var my_data = Data.get_item_data(item_list[index])
	print(my_data)
	menu_system.vanish()
	item_handler._get_item_and_redirect_it(my_data,menu_system,menu_system.player_group,menu_system.enemy_group)

# remove item from inventory! Currently unused.
func _remove_item_from_inventory(index):
	inventory.remove_item(index)
	item_list.remove_at(index)
	inventory.select(index)
	item_count_check()
	
# add a random item to the bag!
func _on_add_button_pressed() -> void:
	var random_item = randi() % 4
	
	if not inventory.item_count >= 24:
		inventory.add_slot(random_item)
		item_list.append(Data.get_item_id(random_item))
		print(item_list)
		no_items.hide()
		
	else:
		print("Item is full!")

# check if the bagpack is bigger then nothing
func item_count_check():
	if not inventory.item_count <= 0:
		
		no_items.hide()
	else:
		no_items.show()

# there is a hidden save item button!
func _on_save_button_pressed() -> void:
	Data.save_data(item_list)
	
func _add_random_items():
	var random_item
	for place in 10:
		random_item = randi() % 5
		if not inventory.item_count >= 24:
			inventory.add_slot(random_item)
			item_list.append(Data.get_item_id(random_item))
			no_items.hide()
			
		else:
			print("Item is full!")
