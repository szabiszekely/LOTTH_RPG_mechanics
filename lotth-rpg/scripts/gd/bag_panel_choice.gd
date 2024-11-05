extends PanelContainer

@onready var inventory: ItemList = $test/Inventory
@onready var no_items: Label = $test/Label

func _ready() -> void:
	inventory.grab_focus()
	if not inventory.item_count <= 0:
		inventory.select(0)
		no_items.hide()
	else:
		no_items.show()

func _on_item_list_item_activated(index: int) -> void:
	inventory.remove_item(index)
	if not inventory.item_count <= 0:
		inventory.select(0)
	else:
		no_items.show()
	
		
#


func _on_add_button_pressed() -> void:
	inventory.add_slot(randi() % 4)
	no_items.hide()
