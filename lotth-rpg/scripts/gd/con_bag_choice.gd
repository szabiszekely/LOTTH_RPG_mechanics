extends PanelContainer
class_name Bagpack_controls

@onready var RefrenceNode: CrossRoad = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var inventory: ItemList = $test/Inventory
@onready var no_items: Label = $test/Label
@onready var menu_system = RefrenceNode.Menu
@onready var item_handler = RefrenceNode.ItemHandler
@onready var marker_2d: Marker2D = $"../Menu/MarginContainer/HBoxContainer/Bagpack/Marker2D"

const CON_FLYING_WARNING = preload("uid://c6xusk3c2kydl")
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
	for i in len(item_list):
		if inventory.is_item_disabled(i) == false:
			inventory.select(i)
			inventory.grab_focus()
			self.show()
			var scrollbar = inventory.get_v_scroll_bar()
			scrollbar.value = 0
			item_count_check()
			
			var tweens = get_tree().create_tween()
			tweens.tween_property(self,"position",Vector2(self.position.x,519),0.3).set_trans(Tween.TRANS_QUAD)
			break
		elif i == len(item_list)-1:
			var instaance = CON_FLYING_WARNING.instantiate()
			instaance.position = marker_2d.position
			RefrenceNode.MainNode.add_child(instaance)
			RefrenceNode.Menu.menu_index = 3
			RefrenceNode.Menu.vanish()
			RefrenceNode.Menu.bag = false
			RefrenceNode.Menu.switching_buttons()
			RefrenceNode.Menu.menu_container = true
			RefrenceNode.Menu.current_state = RefrenceNode.Menu.Menu_state.MENU
			RefrenceNode.Menu.switching_buttons()
			RefrenceNode.Menu.bagpack.disabled = true
			break
			

# Bag disappear
func bag_disappear():
	inventory.release_focus()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,843),0.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished

# when you press an item you add it to the quee
func _on_item_list_item_activated(index: int) -> void:
	#print(item_list)
	var my_data = Data.get_item_data(item_list[index][0])
	#print(my_data)
	menu_system.vanish()
	item_handler._get_item_and_redirect_it(my_data,menu_system,menu_system.player_group,menu_system.enemy_group,item_list[index][1])
	
# remove item from inventory! Currently unused.
func _remove_item_from_inventory(uuid):
	if _is_uuid_exist(uuid):
		inventory.remove_item(_uuid_to_index(uuid))
		item_list.remove_at(_uuid_to_index(uuid))
		inventory.select(_uuid_to_index(uuid))
		item_count_check()
	else:
		printerr("WARNING item was not able to be removed by UUID, Please check the cause")
		printerr("Helpful data: index: ", _uuid_to_index(uuid), "; can_removed: ", _is_uuid_exist(uuid), "; UUID: ", uuid)
		
# add a random item to the bag!
func _on_add_button_pressed() -> void:
	var random_item = randi() % 4
	
	if not inventory.item_count >= 27:
		inventory.add_slot(random_item)
		item_list.append(Data.get_item_id(random_item))
		#print(item_list)
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
	for place in 27:
		random_item = randi() % 7
		var uuid = _create_random_uuid()
		if not inventory.item_count >= 27:
			inventory.add_slot(random_item)
			item_list.append([Data.get_item_id(random_item),uuid])
			item_count_check()
			
		else:
			print("Item is full!")
	#print(item_list)
func _create_random_uuid():
	var random_uuid = randf_range(0,10000000)
	if item_list != []:
		for i in item_list:
			if i[1] != random_uuid:
				pass
			else:
				_create_random_uuid()
				break

	return random_uuid

func _refund_item(uuid):
	if _is_uuid_exist(uuid):
		inventory.set_item_disabled(_uuid_to_index(uuid),false)
		item_count_check()

func _uuid_to_index(uuid):
	var index = -1
	for i in item_list:
		index += 1
		if i[1] == uuid:
			return index
			
func _is_uuid_exist(uuid):
		for i in item_list:
			if i[1] == uuid:
				return true
		return false
