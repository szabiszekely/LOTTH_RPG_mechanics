extends Node2D

var enemies: Array = []
var index: int = 0

func _ready() -> void:
	enemies = get_children()
	#print(enemies)
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
	
	#if Input.is_action_just_pressed("ui_accept"):
		#enemies[index]._take_damage(4,4,index)
			
func switch_focus(x, y):
	enemies[x]._focus_indicator()
	enemies[y]._unfocus_indicator()
	
func _reset_focus():
	index = 0
	for enemy in enemies:
		enemy.unfocus()

func _start_choosing():
	_reset_focus()
	enemies[0].focus()
