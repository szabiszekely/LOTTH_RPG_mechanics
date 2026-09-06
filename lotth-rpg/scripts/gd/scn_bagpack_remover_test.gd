extends BattleMain

@export var item_removal: float

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button"):
		RefrenceNode.BagHandler._remove_item_from_inventory(item_removal)
