extends PanelContainer
class_name Bagpack_controls

@onready var inventory: ItemList = $test/Inventory
@onready var no_items: Label = $test/Label
@export var menu_system: Menu_system
@export var item_handler: Item_handler
var item_list: Array = []

func _ready() -> void:
	self.hide()
	$CanvasLayer.hide()
	item_list = Data.load_data(item_list)
	
	for i in item_list:
		inventory.add_slot(i)
	#inventory.ensure_current_is_visible()
	#inventory.select(0)
	item_count_check()
	

func bag_appear():
	inventory.grab_focus()
	inventory.select(0)
	self.show()
	inventory.ensure_current_is_visible()
	item_count_check()
	
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,519),0.3).set_trans(Tween.TRANS_QUAD)
	#print("Run Apear")
	
func bag_disappear():
	
	inventory.release_focus()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,843),0.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished

func _on_item_list_item_activated(index: int) -> void:
	var my_data = Data.get_item_data(item_list[index])
	
	menu_system.vanish()
	
	item_handler._get_item_and_redirect_it(my_data,menu_system,menu_system.player_group,menu_system.enemy_group)
	#inventory.remove_item(index)
	#item_list.remove_at(index)
	#inventory.select(index)
	#item_count_check()
	
func _on_add_button_pressed() -> void:
	var random_item = randi() % 4
	
	if not inventory.item_count >= 24:
		inventory.add_slot(random_item)
		item_list.append(Data.get_item_id(random_item))
		print(item_list)
		no_items.hide()
		
	else:
		print("Item is full!")

func item_count_check():
	if not inventory.item_count <= 0:
		
		no_items.hide()
	else:
		no_items.show()

func _on_save_button_pressed() -> void:
	Data.save_data(item_list)
