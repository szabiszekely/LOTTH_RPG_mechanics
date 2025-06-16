extends Node2D

@export var all_people = [$LimitingArea,$Sprite2D, $Sprite2D2, $Sprite2D3, $Sprite2D4]


func _input(event: InputEvent) -> void:
	if event.is_action("Cam_change"):
		for i in all_people:
			pass
