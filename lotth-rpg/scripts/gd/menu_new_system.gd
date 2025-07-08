extends PanelContainer
class_name Menu_system

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

# Export values !
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var player_group = RefrenceNode.PlayerGroup
@export var get_the_children: HBoxContainer
@export var Mouse_camera_toggler: Mouse_Camera
@onready var Initiative = RefrenceNode.InitiativeHandler

# Buttons!
@onready var abilities: Button = $MarginContainer/HBoxContainer/Abilities
@onready var action: Button = $MarginContainer/HBoxContainer/Action
@onready var bagpack: Button = $MarginContainer/HBoxContainer/Bagpack
@onready var run: Button = $MarginContainer/HBoxContainer/Run

# Panels !
@onready var ability_card_choice = RefrenceNode.AbiCard
@onready var action_choice = RefrenceNode.ActButtonHandler
@onready var bagpack_choice = RefrenceNode.BagHandler
@onready var run_choice = RefrenceNode.RunHandler

# Miscellaneous !
@onready var menu: Control = $"."
@onready var act_dialogue_box: DialogueBox = $"../Action_option_box"
@onready var static_dialogue_box: DialogueBox = $"../Static_Dialogue_Box"

# all states
enum Menu_state {
	MENU,
	ABILITES,
	ACTIONS,
	BAG,
	RUN,
	CHOOSING_ENEMIES,
	CHOOSING_PLAYERS,
	ALL_GONE
}
# and memory states
enum Memory_state {
	MENU,
	ABILITES,
	ACTIONS,
	BAG,
	RUN,
	CHOOSING_ENEMIES,
	CHOOSING_PLAYERS,
	ALL_GONE
}

var menu_container = true
var abi_container = false
var act_container = false
var bag_container = false
var run_container = false
var choose_enemy_container = false
var choose_player_container = false

var current_state
var current_memory_state
var menu_buttons: Array = []
var menu_index: int = 0

var abi = false
var act = false
var bag = false

func _ready() -> void:
	current_state = Menu_state.MENU
	current_memory_state = current_state
	menu_buttons = get_the_children.get_children()
	switching_buttons()
	
func _process(_delta: float) -> void:
	#print(current_state)
	
	match current_state:
		# bring up the menu and a static dialouge box
		Menu_state.MENU:
			current_memory_state = current_state
			if menu_container == true:
				player_group.player[player_group.p_index]._camera_on()
				static_dialogue_box.show()
				menu_container = false
		# Bring up the abilities and replaces all of the empty buttons with the ones in the current player deck
		Menu_state.ABILITES:
			current_memory_state = current_state
			if abi_container == true:
				abi = true
				menu.show()
				ability_card_choice.deck = player_group.player[player_group.p_index].Fight_stats.PlayerDeck.Deck
				ability_card_choice.abi_appear()
				abi_container = false
		# brings up the actions already appearing with all the enemy act options
		Menu_state.ACTIONS:
			current_memory_state = current_state
			if act_container == true:
				menu.show()
				action_choice.act_appear()
				act_container = false
		# brings up the bagpack menu
		Menu_state.BAG:
			current_memory_state = current_state
			if bag_container == true:
				bag = true
				menu.show()
				bagpack_choice.bag_appear()
				bag_container = false
		Menu_state.RUN:
			current_memory_state = current_state
			if run_container == true:
				menu.show()
				run_choice.run_appear()
				run_container = false
		
		Menu_state.CHOOSING_ENEMIES:
			current_memory_state = current_state
			if choose_enemy_container == true:
				player_group._reset_focus()
				enemy_group._start_choosing()
				choose_enemy_container = false
		
		Menu_state.CHOOSING_PLAYERS:
			current_memory_state = current_state
			if choose_player_container == true:
				player_group._start_choosing()
				choose_player_container = false
		# disables every menu and every interaction
		Menu_state.ALL_GONE:
			all_gone()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		print("hi me 2x")
		match current_state:
			# goes back to the previous player
			Menu_state.MENU:
				if player_group.all_p_actions.size() != 0:
					
					player_group.all_p_actions.remove_at(player_group.all_p_actions.size() - 1)
					if Initiative.sorted_player[player_group.p_index].PlayOutOptions == Initiative.sorted_player[player_group.p_index].MaxPlayOutOptions:
						Initiative.switch_order_p(player_group.p_index-1,player_group.p_index)
						player_group.p_index -= 1
						await get_tree().create_timer(0.3).timeout
						Initiative.sorted_player[player_group.p_index].PlayOutOptions = 1
					else:
						Initiative.sorted_player[player_group.p_index].PlayOutOptions += 1
						
					menu_container = true
			# all of the other just go back by one step to their respective menu before
			Menu_state.ABILITES:
				menu_index = 0
				vanish()
				abi = false
				switching_buttons()
				menu_container = true
				current_state = Menu_state.MENU
			Menu_state.BAG:
				menu_index = 2
				vanish()
				bag = false
				switching_buttons()
				menu_container = true
				current_state = Menu_state.MENU
			Menu_state.RUN:
				menu_index = 3
				vanish()
				switching_buttons()
				menu_container = true
				current_state = Menu_state.MENU
				#switching_buttons()
			Menu_state.CHOOSING_ENEMIES:
				if act == true:
					menu_index = 1
					enemy_group._reset_focus()
					player_group.player[player_group.p_index]._camera_on()
					vanish()
					act = false
					act_container = false
					switching_buttons()
					menu_container = true
					current_state = Menu_state.MENU
				elif abi == true:
					enemy_group._reset_focus()
					vanish()
					player_group.player[player_group.p_index]._camera_on()
					abi = false
					abi_container = true
					
					current_state = Menu_state.ABILITES
				elif bag == true:
					enemy_group._reset_focus()
					menu.show()
					vanish()
					player_group.player[player_group.p_index]._camera_on()
					bag = false
					bag_container = true
					current_state = Menu_state.BAG
			Menu_state.CHOOSING_PLAYERS:
				if abi == true:
					vanish()
					player_group.player[player_group.p_index]._camera_on()
					player_group._reset_focus()
					abi = false
					abi_container = true
					current_state = Menu_state.ABILITES
				elif bag == true:
					player_group._reset_focus()
					menu.show()
					vanish()
					player_group.player[player_group.p_index]._camera_on()
					bag = false
					bag_container = true
					current_state = Menu_state.BAG
				else:
					print("SOMETHING WRONG!")
			Menu_state.ACTIONS:
				vanish()
				choose_enemy_container = true
				act_container = true
				act = true
				current_state = Menu_state.CHOOSING_ENEMIES
				#print("Hi")
	# disables all the UI stuff and you can look around
	if event.is_action_pressed("Cam_change"):
		if Mouse_camera_toggler.camera_toggle == true:
			vanish()
			current_state = Menu_state.ALL_GONE
		else:
			back_to_normal()
			match current_memory_state:
				Menu_state.ABILITES:
					abi_container = true
				Menu_state.ACTIONS:
					act_container = true
				Menu_state.BAG:
					bag_container = true
				Menu_state.RUN:
					run_container = true
				
				
			current_state = current_memory_state

# hides the UI (Kinda...)
func vanish():
	menu.hide()
	ability_card_choice.abi_disappear()
	action_choice.act_disappear()
	bagpack_choice.bag_disappear()
	run_choice.run_disappear()
	static_dialogue_box.hide()
	act_dialogue_box.hide()

# Disables EVERYTHING
func all_gone():
	abilities.process_mode = Node.PROCESS_MODE_DISABLED
	action.process_mode = Node.PROCESS_MODE_DISABLED
	bagpack.process_mode = Node.PROCESS_MODE_DISABLED
	run.process_mode = Node.PROCESS_MODE_DISABLED
	ability_card_choice.process_mode = Node.PROCESS_MODE_DISABLED
	action_choice.process_mode = Node.PROCESS_MODE_DISABLED
	bagpack_choice.process_mode = Node.PROCESS_MODE_DISABLED
	run_choice.process_mode = Node.PROCESS_MODE_DISABLED
	enemy_group._reset_focus()
	player_group._reset_focus()

# Brings back everything
func back_to_normal():
	if current_memory_state == 5:
		enemy_group.start_choosing = true
	if current_memory_state == 6:
		player_group.start_choosing = true
	abilities.process_mode = Node.PROCESS_MODE_INHERIT
	action.process_mode = Node.PROCESS_MODE_INHERIT
	bagpack.process_mode = Node.PROCESS_MODE_INHERIT
	run.process_mode = Node.PROCESS_MODE_INHERIT
	ability_card_choice.process_mode = Node.PROCESS_MODE_INHERIT
	action_choice.process_mode = Node.PROCESS_MODE_INHERIT
	bagpack_choice.process_mode = Node.PROCESS_MODE_INHERIT
	run_choice.process_mode = Node.PROCESS_MODE_INHERIT
	switching_buttons()

# focuses the button your menu were in
func switching_buttons():
	menu_buttons[menu_index].grab_focus()
	if enemy_group.start_choosing == false:
		menu.show()

func _on_abilities_pressed() -> void:
	vanish()
	abi_container = true
	current_state = Menu_state.ABILITES

func _on_action_pressed() -> void:
	vanish()
	act = true
	choose_enemy_container = true
	act_container = true
	current_state = Menu_state.CHOOSING_ENEMIES

func _on_bagpack_pressed() -> void:
	vanish()
	bag = true
	bag_container = true
	current_state = Menu_state.BAG

func _on_run_pressed() -> void:
	vanish()
	run_container = true
	current_state = Menu_state.RUN
