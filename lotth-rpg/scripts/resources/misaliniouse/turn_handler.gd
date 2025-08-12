extends Node
class_name Turn_Handler

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

# Have to get the position where the characters will move
# It needs to access the other handlers and scripts that are important
# It is need to play it out in order one after another
@onready var ability_func = RefrenceNode.AbiHandler
@onready var Action_button_handler = RefrenceNode.ActHandler
@onready var Menu = RefrenceNode.Menu
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var player_group = RefrenceNode.PlayerGroup
@onready var initiative = RefrenceNode.InitiativeHandler
@onready var main_scene = RefrenceNode.MainNode

@onready var ability: Node = $Ability
@onready var action: Node = $Action
@onready var bagpack: Node = $Bagpack
@onready var run: Node = $Run
@onready var movement: Node = $Movement


var baseTiming: int

# [Key , Sub_Key , From Character ,To Character, Data 1, Data 2, Data 3]
# ["attack", 2 , Player1, Player2, HP]
func _ready() -> void:
	baseTiming = initiative.timeSpentBetweenTurns 

func _Does_opponent_exist(list:Array,is_this_heal):
	var grab_a_different_character
	var count_me_in = 0
	
	if list[3] == null:
		if list[3] in is_this_heal:
			if list[2].Fight_stats.Friend_or_Foe == 0:
				grab_a_different_character = player_group.player.pick_random()
				list.pop_at(3)
				list.insert(3,grab_a_different_character)
				return list
			else:
				grab_a_different_character = enemy_group.enemies.pick_random()
				list.pop_at(3)
				list.insert(3,grab_a_different_character)
				return list
			
		else:
			if list[2].Fight_stats.Friend_or_Foe == 0:
				grab_a_different_character = enemy_group.enemies.pick_random()
				list.pop_at(3)
				list.insert(3,grab_a_different_character)
				return list
			else:
				grab_a_different_character = player_group.player.pick_random()
				list.pop_at(3)
				list.insert(3,grab_a_different_character)
				return list


func _actions(stack):
	#print(stack)
	var play_out_action = []
	for i in initiative.all_rolls:
		for j in stack:
			if i[-1] == j[2]:
				play_out_action.append(j)
	
	var stackIndex: int = 0
	for i in play_out_action:
		# ECT, ECT
		
		enemy_group._get_me_some_of_that_gd_children_enemy()
		player_group._get_me_some_of_that_gd_children_player()

		if i[2] == null:
			i = ["pass_character"]
		
		match i[0]:
			"movement":
				movement._Movement_Turn(i)

			"atk":
				ability._Ability_Turn(i)
				
			"bag":
				bagpack._Bagpack_Turn(i)

			"act":
				action._Action_Turn(i)

			"TEST":
				print("WORKING!!")
				
			"pass_character":
				print("Character is unavailable")
		# WE NEED TO PUT A BREAKER HERE SO IT MAY ONLY CONTINUES AFTER THE THING ENDED
		if initiative.doTrapForLoop:
			await initiative.stopLoopInPlace
			#print("DOESN'T WROK ;-;")
			#break
		
		await Engine.get_main_loop().create_timer(initiative.timeSpentBetweenTurns).timeout
		Menu.vanish()
		initiative.timeSpentBetweenTurns = baseTiming
		stackIndex += 1
	
	
	stack.clear()
	initiative.initiative_index = 0
	initiative.action_start = false
	await Engine.get_main_loop().create_timer(2).timeout
	main_scene._full_reset()
