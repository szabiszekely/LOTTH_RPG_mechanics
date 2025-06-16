extends Node

var my_turn = false

func _process(delta: float) -> void:
	if my_turn:
		turn_red()
	else:
		turn_normal()
		
	
	
func turn_red():
	self.modulate = Color.RED

func turn_normal():
	self.modulate = Color.WHITE
