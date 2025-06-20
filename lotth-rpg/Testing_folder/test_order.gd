extends Node2D
class_name Test_order

signal continue_order
@onready var all_people = [$Sprite2D, $Sprite2D2, $Sprite2D3, $Sprite2D4]
@onready var limiting_area: TextureRect = $LimitingArea

var actions = []
var not_started = false
var index = 0

		
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Cam_change") and !not_started:
		_reset()
		all_people.shuffle()
		print(all_people)
		all_people[index].my_turn = true
	
	if len(all_people) == len(actions) and !not_started:
		limiting_area._play_out(actions)
		not_started = true
		

		
func _switch(x,y):
	all_people[x].my_turn = true
	all_people[y].my_turn = false
	
func _reset():
	not_started = true
	for i in all_people:
		i.my_turn = false
	actions.clear()
	index = 0
	not_started = false

	
