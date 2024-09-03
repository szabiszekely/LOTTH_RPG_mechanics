extends Node2D

var enemies: Array = []
var index: int = 0

func _ready() -> void:
	enemies = get_children()
	print(enemies)
	enemies[0]._focus_indicator()
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		if index > 0:
			index -= 1
			switch_focus(index, index+1)
	if Input.is_action_just_pressed("ui_down"):
		if index < enemies.size() - 1:
			index += 1
			switch_focus(index, index-1)
			
func switch_focus(x, y):
	enemies[x]._focus_indicator()
	enemies[y]._unfocus_indicator()
	
