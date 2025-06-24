extends Node2D
class_name Test_order

signal continue_order
@onready var all_people = [$Player1, $Enemy1, $Enemy2, $Player2]
@onready var enemy_group = []
@onready var player_group = []

@export var play_out: test_play_out
@export var player_section: Player_Selection
@export var enemy_section: Enemy_Selection


var actions = []
var not_started = false
var index = 0

func _ready() -> void:
	_order()
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Cam_change") and !not_started:
		_reset()
		all_people.shuffle()
		_sort()
		print(all_people)
		
		player_section._start_player_section()
		

		
func _switch_p(x,y):
	player_group[y].my_turn = false
	await get_tree().create_timer(0.2).timeout
	player_group[x].my_turn = true

func _switch_e(x,y):
	enemy_group[x].my_turn = true
	enemy_group[y].my_turn = false


func _reset():
	not_started = true
	for i in all_people:
		i.my_turn = false
		i.PlayOut = i.MaxPlayOut
	actions.clear()
	index = 0
	not_started = false

func _order():
	for i in all_people:
		if "Player" in i.get_groups() :
			player_group.append(i)
		else:
			enemy_group.append(i)
	
func _sort():
	var temp = []
	for i in all_people:
		for j in player_group:
			if i == j:
				temp.append(j)
	player_group.clear()
	for i in temp: player_group.append(i)
	temp.clear()
	for i in all_people:
		for j in enemy_group:
			if i == j:
				temp.append(j)
	enemy_group.clear()
	for i in temp: enemy_group.append(i)
