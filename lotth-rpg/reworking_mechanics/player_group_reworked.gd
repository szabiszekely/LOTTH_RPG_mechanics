extends Node2D
class_name Player_group

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var menu: PanelContainer = $"../../UI_battle_menu/Menu"
@onready var menu_system = RefrenceNode.Menu
@onready var initiative = RefrenceNode.InitiativeHandler
@onready var enemy = RefrenceNode.EnemyGroup


var item_againts_players
var card_againts_players

var p_index: int = 0
var sub_index: int = 0
var all_moves_p: int = 100

var player: Array = []
var all_p_actions: Array = []

var start_choosing = false
var player_turn_end = false

func _ready() -> void:
	player = get_children()
	

func _player_start_choosing():
	
	
	all_moves_p = 0
	for i in initiative.sorted_player:
		all_moves_p += i.MaxPlayOutOptions
	all_p_actions.clear()
	p_index = 0
	start_choosing = false
	player_turn_end = false
	initiative.sorted_player[0].your_turn = true
		
func _process(delta: float) -> void:
	if all_moves_p == len(all_p_actions) and !player_turn_end:
		player_turn_end = true
		enemy._start_enemy_section(all_p_actions)
		print("DONE")

	
	if start_choosing == true :
		# same as with the enemy, one set goes upwards in the chain, the other goes down and it loops
		if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left"):
			if sub_index > 0:
				sub_index -= 1
				switch_focus(sub_index, sub_index+1)
			else:
				sub_index = player.size() -1
				switch_focus(sub_index,0)
		
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right"):
			if sub_index < player.size() - 1:
				sub_index += 1
				switch_focus(sub_index, sub_index-1)
			else:
				sub_index = 0
				switch_focus(sub_index,player.size() - 1)
		
		if Input.is_action_just_pressed("ui_accept") and start_choosing == true:
			if menu_system.abi == true and start_choosing == true:
				menu_system.abi = false
				all_p_actions.push_back(["atk",card_againts_players,sub_index,1,p_index,initiative.sorted_player[p_index]])
				_reset_focus()
				menu.vanish()
				initiative.sorted_player[p_index]._play_out_tick_down()
				if initiative.sorted_player[p_index].PlayOutOptions != 0:
					call_menu_appear()
				
			if menu_system.bag == true:
				menu_system.bag = false
				all_p_actions.push_back(["bag", item_againts_players , sub_index ,0,menu.bagpack_choice,initiative.sorted_player[p_index]])
				_reset_focus()
				initiative.sorted_player[p_index]._play_out_tick_down()
				if initiative.sorted_player[p_index].PlayOutOptions != 0:
					call_menu_appear()


func _start_choosing():
	_reset_focus()
	initiative.sorted_player[0]._focus_indicator()
	
	start_choosing = true

func _reset_focus():
	sub_index = 0
	start_choosing = false
	for play in player:
		play._unfocus_indicator()

func switch_focus(x, y):
	initiative.sorted_player[x]._focus_indicator()
	initiative.sorted_player[y]._unfocus_indicator()
	

func call_menu_appear():
	menu.menu_index = 0
	menu.switching_buttons()
	menu.current_state = menu.Menu_state.MENU
