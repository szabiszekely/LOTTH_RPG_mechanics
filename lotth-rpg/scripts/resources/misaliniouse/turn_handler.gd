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
#region New Code Region
#  Key ,Who? ,Index ,Data1 ,Data2 ,Data3 ,Data4

#   ["atk", card_againts_enemies, index,     0, menu.player_group.index] FROM THE PLAYER!
#   ["atk", card_againts_players, sub_index, 1, index]					 TO A PLAYER

#   ["bag", item_againts_enemies, index ,    1]							 FROM THE PLAYER
#   ["bag", item_againts_players, sub_index ,0]							 TO A PLAYER

#   ["act", i.text, 			  self,		 0, enemy_group.enemies[enemy_group.index]]
#endregion

func _ready() -> void:
	baseTiming = initiative.timeSpentBetweenTurns 

func _actions(stack):
	#print(stack)
	var play_out_action = []
	for i in initiative.all_rolls:
		for j in stack:
			if i[-1] == j[-1]:
				play_out_action.append(j)
	
	var stackIndex: int = 0
	for i in play_out_action:
		# ECT, ECT
		
		enemy_group.enemies = get_children()
		player_group.player = get_children()

		if i[-1] == null:
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
