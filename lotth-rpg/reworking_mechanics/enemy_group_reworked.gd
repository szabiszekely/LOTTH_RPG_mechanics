extends Node2D
class_name Enemy_group

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var menu: PanelContainer = $"../../UI_battle_menu/Menu"
@onready var act_options = RefrenceNode.ActButtonHandler
@onready var menu_system = RefrenceNode.Menu
@onready var initiative = RefrenceNode.InitiativeHandler
@onready var player = RefrenceNode.PlayerGroup
@onready var turn_handler = RefrenceNode.TurnHandler


var card_againts_enemies
var item_againts_enemies
var p_actions

var enemies: Array = []
var all_e_action: Array = []

var sub_e_index: int = 0
var e_index: int = 0
var all_play_out_e: int = 100

var start_choosing = false
var enemy_turn_end = false

func _ready() -> void:
	enemies = get_children()

func _start_enemy_section(player_actions):
	all_play_out_e = 0
	for i in initiative.sorted_enemies:
		all_play_out_e += i.MaxPlayOutOptions
	all_e_action.clear()
	enemy_turn_end = false
	e_index = 0
	initiative.sorted_enemies[e_index].your_turn = true
	p_actions = player_actions
	
func _process(delta: float) -> void:
	print(e_index)
	if not menu.visible and start_choosing == true and len(enemies) != 1:
		# when pressed one derections than it moves up or down in the list and if that list is out of context 
		# than it loops back around!
		if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left"):
			if e_index > 0:
				e_index -= 1
				switch_focus(e_index, e_index+1)
			else:
				e_index = enemies.size() -1
				switch_focus(e_index,0)
		
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right"):
			if e_index < enemies.size() - 1:
				e_index += 1
				switch_focus(e_index, e_index-1)
			else:
				e_index = 0
				switch_focus(e_index,enemies.size() - 1)
				
		# When you press space it will check on which menu should it bring up and than execute it!
		if Input.is_action_just_pressed("ui_accept") and start_choosing == true:
			_player_action_to_enemy()
					
	elif not menu.visible and start_choosing == true and len(enemies) == 1:
		if Input.is_action_just_pressed("ui_accept") and start_choosing == true:
			_player_action_to_enemy()
	
	
	if all_play_out_e == len(all_e_action) and !enemy_turn_end:
		enemy_turn_end = true

		for i in p_actions:
			initiative.all_actions.append(i)
		for i in all_e_action:
			initiative.all_actions.append(i)
		turn_handler._actions(initiative.all_actions)



func _player_action_to_enemy():
	# the enemy has its own act options other than check,focus and guard and than that is send to act_options where it gets added!
	if menu_system.act == true:
		menu_system.act = false
		menu_system.current_state = menu_system.Menu_state.ACTIONS
		#print(Data.get_actions_of_enemy(enemies[index].Fight_stats.Id))
		act_options.act_add_actions(Data.get_actions_of_enemy(enemies[e_index].Fight_stats.Id))
		enemies[e_index]._unfocus_indicator()
		enemies[e_index].cam_target.enabled = false
		start_choosing = false
		_reset_focus()
	
	# every player have their own abilities and thus when this option show up all of their option gets
	# signed to a ability button
	if menu_system.abi == true:
		menu_system.abi = false
		player.all_p_actions.push_back(["atk",card_againts_enemies,e_index,0,player.p_index,initiative.sorted_player[player.p_index]])
		_reset_focus()
		initiative.sorted_player[player.p_index].PlayOutOptions -= 1
		if initiative.sorted_player[player.p_index].PlayOutOptions != 0:
			call_menu_appear()
	# the bag conntent is stored in a save file and when selected it will bring out all of the options from
	# the save file
	if menu_system.bag == true:
		menu_system.bag = false
		player.all_p_actions.push_back(["bag", item_againts_enemies , e_index ,1, player.p_index,menu.bagpack_choice,initiative.sorted_player[player.p_index]])
		_reset_focus()
		initiative.sorted_player[player.p_index].PlayOutOptions -= 1
		if initiative.sorted_player[player.p_index].PlayOutOptions != 0:
			call_menu_appear()



# han you start choosing the enemy you reset the focus and focus on the first enemy!
func _start_choosing():
	_reset_focus()
	enemies[0]._focus_indicator()
	start_choosing = true
	
# clears all index and set it self to the first enemy! 
func _reset_focus():
	e_index = 0
	start_choosing = false
	for enemy in enemies:
		enemy._unfocus_indicator()
	
# this is where you switch indicator focus from on enemy and switch to the next!
func switch_focus(x, y):
	enemies[x]._focus_indicator()
	enemies[y]._unfocus_indicator()


func call_menu_appear():
	menu.menu_index = 0
	menu.switching_buttons()
	menu.current_state = menu.Menu_state.MENU
