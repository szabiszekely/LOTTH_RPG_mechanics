extends PanelContainer
class_name Bagpack_controls
@onready var inventory: ItemList = $test/Inventory
@onready var no_items: Label = $test/Label
var item_list: Array = []

func _ready() -> void:
	self.hide()
	$CanvasLayer.hide()
	item_list = ItemData.load_data(item_list)
	
	for i in item_list:
		inventory.add_slot(i)
	inventory.select(0)
	inventory.ensure_current_is_visible()
	item_count_check()
	

func bag_appear():
	inventory.grab_focus()
	self.show()
	inventory.select(0)
	inventory.ensure_current_is_visible()
	item_count_check()
	
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,333),0.3).set_trans(Tween.TRANS_QUAD)
	#print("Run Apear")
	
func bag_disappear():
	inventory.release_focus()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,653),0.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished

func _on_item_list_item_activated(index: int) -> void:
	var my_data = ItemData.get_item_name(item_list[index])
	print(my_data)
	inventory.remove_item(index)
	item_list.remove_at(index)
	inventory.select(index)
	item_count_check()
	
func _on_add_button_pressed() -> void:
	var random_item = randi() % 4
	
	if not inventory.item_count >= 24:
		inventory.add_slot(random_item)
		item_list.append(ItemData.get_item_id(random_item))
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
	ItemData.save_data(item_list)
