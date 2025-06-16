extends Node2D
class_name  Player_group

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")


@onready var menu: PanelContainer = $"../../UI_battle_menu/Menu"
@onready var player_damage = preload("res://scripts/resources/CH/Lil_Guy_Fighting_Stats.tres")
var card_againts_players
var item_againts_players
var index: int = 0
@onready var menu_system = RefrenceNode.Menu

var player: Array = []
var start_choosing = false
# this is importent for choosing players in any other ways like giving items or choosing while it is not their turn!
var sub_index: int = 0

func _ready() -> void:
	player = get_children()

func _process(delta: float) -> void:
	if start_choosing == true:
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
				menu.Initiative.action_queued.push_back(["atk",card_againts_players,sub_index,1,index])
				_reset_focus()
				menu.vanish()
				player[index].PlayOutOptions -= 1
				if player[index].PlayOutOptions != 0:
					call_menu_appear()
				
			if menu_system.bag == true:
				menu_system.bag = false
				menu.Initiative.action_queued.push_back(["bag", item_againts_players , sub_index ,0,menu.bagpack_choice])
				_reset_focus()
				player[index].PlayOutOptions -= 1
				if player[index].PlayOutOptions != 0:
					call_menu_appear()

func call_menu_appear():
	menu.menu_index = 0
	menu.switching_buttons()
	menu.current_state = menu.Menu_state.MENU

# it adds a debug option
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button_2"):
		player[index].Initiative._next_in_order() 
		player[index].Initiative.action_queued.push_back(["TEST"])

# this switches players frm one to another
func switch_player(x, y):
	player[x].player_switch_on()
	player[y].player_switch_off()
# and this is only switches focus
func switch_focus(x, y):
	player[x]._focus_indicator()
	player[y]._unfocus_indicator()
	
func _reset_focus():
	sub_index = 0
	start_choosing = false
	for play in player:
		play._unfocus_indicator()
		
# han you start choosing the enemy you reset the focus and focus on the first enemy!
func _start_choosing():
	_reset_focus()
	player[0]._focus_indicator()
	
	start_choosing = true
	
