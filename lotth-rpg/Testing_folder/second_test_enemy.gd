extends Node
var my_turn = false
@onready var current_player_indicator = find_child("CurrentPlayerIndicator")

@export var enemy_section: Enemy_Selection
@export var test_order: Test_order
@export var ch_name: String
@export var MaxPlayOut: int = 2

var PlayOut: int = 0
var before_enemy_turn = []

func _process(delta: float) -> void:
	if my_turn == true:
		turn_red()
		enemy_turn()
		current_player_indicator.show()
			
	else:
		turn_normal()
		current_player_indicator.hide()
	

		
func enemy_turn():
	#prep for the enemy logic
	self.PlayOut -= 1
	before_enemy_turn = []
	_sort_before_self()
	_same_type_enemy()
	_get_actions()
	print(before_enemy_turn)
	var random_number = randi_range(1,4)
	
	#----------- LOGIC whith the player actions in count
	if len(before_enemy_turn) != 0:
		if before_enemy_turn[-1][1] <= random_number: enemy_section.all_enemy_action.append([ch_name,random_number,self]) 
		else: enemy_section.all_enemy_action.append([ch_name,"Defend",self])
	else: enemy_section.all_enemy_action.append([ch_name,random_number,self])
	#------------------
	if PlayOut <= 0:
		if not len(test_order.enemy_group) <= enemy_section.e_index + 1:
			test_order._switch_e(enemy_section.e_index+1,enemy_section.e_index)
			enemy_section.e_index += 1
		else:
			my_turn = false
	
# gets everything before the enemy
func _sort_before_self():
	for i in test_order.all_people: 
		if i != self:
			before_enemy_turn.append(i)
		else:
			break
# this one removes all enemies and only leave Players if their are any
func _same_type_enemy():
	for i in before_enemy_turn:
		for j in test_order.enemy_group:
			if i == j:
				before_enemy_turn.erase(i)

# get the players switched out with their actions
func _get_actions():
	var temp = []
	for i in enemy_section.p_actions:
		for j in before_enemy_turn:
			if i[2] == j:
				temp.append(i)
	before_enemy_turn.clear()
	for i in temp: before_enemy_turn.append(i)
	
	
func turn_red():
	self.self_modulate = Color.RED

func turn_normal():
	self.self_modulate = Color.WHITE
