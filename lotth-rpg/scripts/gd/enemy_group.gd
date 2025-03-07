extends Node2D
class_name Enemy_group
# This node is for controlling choice between abilities and actions!
@onready var menu: PanelContainer = $"../../UI_battle_menu/Menu"

@export var act_options: Action_control
@export var menu_system: Menu_system

var card_againts_enemies
var item_againts_enemies
var enemies: Array = []
var index: int = 0
#var options_are_on = false
#
#var abi = false
#var act = false
#
#
#var should_be_able_to_interact_with_menu = true

var start_choosing = false

# gets all enemies and show choices! Which just brings up the menu!
func _ready() -> void:
	enemies = get_children()
	#print(enemies)
	#show_choices()
	


# I honestly want to replan this because this looks ugly af! (2024/10/12)
func _process(_delta: float) -> void:
	if not menu.visible and start_choosing == true:
		# when pressed one derections than it moves up or down in the list and if that list is out of context 
		# than it loops back around!
		if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left"):
			if index > 0:
				index -= 1
				switch_focus(index, index+1)
				#print("why")
			else:
				index = enemies.size() -1
				switch_focus(index,0)
				#print("not")
		
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right"):
			if index < enemies.size() - 1:
				index += 1
				switch_focus(index, index-1)
				#print("do")
			else:
				index = 0
				switch_focus(index,enemies.size() - 1)
				#print("you work?")
		# When you press space than it changes and brings up the action options!
		if Input.is_action_just_pressed("ui_accept") and start_choosing == true:
			if menu_system.act == true:
				menu_system.act = false
				menu_system.current_state = menu_system.Menu_state.ACTIONS
				# the enemy has its own act options other than check,focus and guard and than that is send to act_options where it gets added!
				print(Data.get_actions_of_enemy(enemies[index].Fight_stats.Id))
				act_options.act_add_actions(Data.get_actions_of_enemy(enemies[index].Fight_stats.Id))
				enemies[index]._unfocus_indicator()
				enemies[index].cam_target.enabled = false
				start_choosing = false
				_reset_focus()
				
			
			if menu_system.abi == true:
				menu_system.abi = false
				menu.Initiative.action_queued.push_back(["atk",card_againts_enemies,index,0,menu.player_group.index])
				_reset_focus()
				menu.player_group.player[menu.player_group.index].PlayOutOptions -= 1
				if menu.player_group.player[menu.player_group.index].PlayOutOptions != 0:
					call_menu_appear()
			
			if menu_system.bag == true:
				menu_system.bag = false
				menu.Initiative.action_queued.push_back(["bag", item_againts_enemies , index ,1, menu.player_group.index,menu.bagpack_choice])
				_reset_focus()				
				menu.player_group.player[menu.player_group.index].PlayOutOptions -= 1
				if menu.player_group.player[menu.player_group.index].PlayOutOptions != 0:
					call_menu_appear()
				
			

func call_menu_appear():
	menu.menu_index = 0
	menu.switching_buttons()
	menu.current_state = menu.Menu_state.MENU
	

# this is where you switch indicator focus from on enemy and switch to the next!
func switch_focus(x, y):
	
	enemies[x]._focus_indicator()
	
	enemies[y]._unfocus_indicator()
	
# this is where the it brings up the menu and grabs abilities as the focus!
func show_choices():
	menu.show()
	menu.find_child("Abilities").grab_focus()
# clears all index and set it self to the first enemy! 
func _reset_focus():
	index = 0
	start_choosing = false
	for enemy in enemies:
		enemy._unfocus_indicator()

		
# han you start choosing the enemy you reset the focus and focus on the first enemy!
func _start_choosing():
	_reset_focus()
	enemies[0]._focus_indicator()
	
	start_choosing = true
	
