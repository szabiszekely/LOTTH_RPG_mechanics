extends Node2D
class_name  Player_group
@onready var menu: PanelContainer = $"../../UI_battle_menu/Menu"
@onready var player_damage = preload("res://scripts/resources/CH/Lil_Guy_Fighting_Stats.tres")
var card_againts_players
var item_againts_players
@export var index: int = 0
@export var menu_system: Menu_system

var player: Array = []
var start_choosing = false
# this is importent for choosing players in any other ways like giving items or choosing while it is not their turn!
var sub_index: int = 0

func _ready() -> void:
	player = get_children()
	player[0].player_switch_on()
	

func _process(delta: float) -> void:
	if start_choosing == true:
		
		if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left"):
			if sub_index > 0:
				sub_index -= 1
				switch_focus(sub_index, sub_index+1)
				#print("why")
			else:
				sub_index = player.size() -1
				switch_focus(sub_index,0)
				#print("not")
		
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right"):
			if sub_index < player.size() - 1:
				sub_index += 1
				switch_focus(sub_index, sub_index-1)
				#print("do")
			else:
				sub_index = 0
				switch_focus(sub_index,player.size() - 1)
		if Input.is_action_just_pressed("ui_accept") and start_choosing == true:
			
			if menu_system.abi == true and start_choosing == true:
				#menu_system.abi = false
				player[index]._use_card_and_lose_eng(card_againts_players)
				player[sub_index]._use_card_and_gain_eng(card_againts_players,Data.get_card_eng_or_hp(card_againts_players))

			
				print("You have a chance to attack the enemy")
				start_choosing = false
			
			if menu_system.bag == true:
				#menu_system.bag = false
				
				if Data.get_item_health_type(item_againts_players) == true:
					player[sub_index].Bar.bar_health_restored(Data.get_item_hp(item_againts_players),2)
				else:
					player[sub_index].Bar.bar_health_restored(Data.get_item_eng(item_againts_players),1)

				
				start_choosing = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button_2"):
		if index > 0:
			index -= 1
			switch_player(index, index+1)
			#print("why")
		else:
			index = player.size() -1
			switch_player(index,0)
	
		
	if event.is_action_pressed("debug_button"):
		if index < player.size() - 1:
			index += 1
			switch_player(index, index-1)
			#print("do")
		else:
			index = 0
			switch_player(index,player.size() - 1)
	
	
func switch_player(x, y):
	player[x].player_switch_on()
	player[y].player_switch_off()

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
	
