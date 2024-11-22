extends PanelContainer
class_name Menu_system

@export var enemy_group: Enemy_group
@export var player_group: Player_group
@export var Action_button_handler: Action_buttons_option_Handler
@export var get_the_children: HBoxContainer
@export var Mouse_camera_toggler: Mouse_Camera

# Buttons!
@onready var abilities: Button = $MarginContainer/HBoxContainer/Abilities
@onready var action: Button = $MarginContainer/HBoxContainer/Action
@onready var bagpack: Button = $MarginContainer/HBoxContainer/Bagpack
@onready var run: Button = $MarginContainer/HBoxContainer/Run

# Panels !
#@onready var action_choice: Action_control = $"../Action_Panel_choice"
@onready var action_choice: Action_control = $"../Action_Panel_choice"
@onready var bagpack_choice: Bagpack_controls = $"../Bagpack"
@onready var run_choice: Run_control = $"../Run_Panel_choice"

# ugly but it does its job! aka All ACTION BUTTONS
@onready var GUI = owner
@onready var check = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("Check")
@onready var focus = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("Focus")
@onready var guard = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("Guard")
@onready var top_left = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("top_left")
@onready var top_right = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("top_right")
@onready var middle_left = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("middle_left")
@onready var middle_right = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("middle_right")
@onready var bottom_left = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("bottom_left")
@onready var bottom_right = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("bottom_right")
@onready var menu: Control = $"."
@onready var act_dialogue_box: DialogueBox = $"../Action_option_box"
@onready var static_dialogue_box: DialogueBox = $"../Static_Dialogue_Box"


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

var abi_container = false
var act_container = false
var bag_container = false
var run_container = false
var choose_enemy_container = false

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
	print(menu_buttons)
	switching_buttons()
	

func _process(_delta: float) -> void:
	#print(current_state)
	match current_state:
		Menu_state.MENU:
			current_memory_state = current_state
			static_dialogue_box.show()
			
		Menu_state.ABILITES:
			pass
		Menu_state.ACTIONS:
			current_memory_state = current_state
			if act_container == true:
				menu.show()
				action_choice.act_appear()
				act_container = false
		Menu_state.BAG:
			current_memory_state = current_state
			if bag_container == true:
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
				enemy_group._start_choosing()
				choose_enemy_container = false
		Menu_state.ALL_GONE:
			all_gone()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		match current_state:
			Menu_state.ABILITES:
				pass
			Menu_state.BAG:
				menu_index = 2
				vanish()
				switching_buttons()
				current_state = Memory_state.MENU
			Menu_state.RUN:
				menu_index = 3
				vanish()
				switching_buttons()
				current_state = Menu_state.MENU
				#switching_buttons()
			Menu_state.CHOOSING_ENEMIES:
				if act == true:
					menu_index = 1
					enemy_group._reset_focus()
					vanish()
					act = false
					switching_buttons()
					current_state = Menu_state.MENU
					#switching_buttons()
				elif abi == true:
					enemy_group._reset_focus()
					menu.show()
					vanish()
					current_state = Menu_state.ABILITES
				elif bag == true:
					enemy_group._reset_focus()
					menu.show()
					vanish()
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
	
func vanish():
	menu.hide()
	action_choice.act_disappear()
	bagpack_choice.bag_disappear()
	run_choice.run_disappear()
	static_dialogue_box.hide()
	act_dialogue_box.hide()

func all_gone():
	abilities.process_mode = Node.PROCESS_MODE_DISABLED
	action.process_mode = Node.PROCESS_MODE_DISABLED
	bagpack.process_mode = Node.PROCESS_MODE_DISABLED
	run.process_mode = Node.PROCESS_MODE_DISABLED
	action_choice.process_mode = Node.PROCESS_MODE_DISABLED
	bagpack_choice.process_mode = Node.PROCESS_MODE_DISABLED
	run_choice.process_mode = Node.PROCESS_MODE_DISABLED
	enemy_group.start_choosing = false
	
func back_to_normal():
	if current_memory_state == 5:
		enemy_group.start_choosing = true
	abilities.process_mode = Node.PROCESS_MODE_INHERIT
	action.process_mode = Node.PROCESS_MODE_INHERIT
	bagpack.process_mode = Node.PROCESS_MODE_INHERIT
	run.process_mode = Node.PROCESS_MODE_INHERIT
	action_choice.process_mode = Node.PROCESS_MODE_INHERIT
	bagpack_choice.process_mode = Node.PROCESS_MODE_INHERIT
	run_choice.process_mode = Node.PROCESS_MODE_INHERIT
	switching_buttons()

func switching_buttons():
	menu_buttons[menu_index].grab_focus()
	if enemy_group.start_choosing == false:
		menu.show()

func _on_abilities_pressed() -> void:
	pass # Replace with function body.


func _on_action_pressed() -> void:
	vanish()
	act = true
	choose_enemy_container = true
	act_container = true
	current_state = Menu_state.CHOOSING_ENEMIES
	#action_choice.act_appear()


func _on_bagpack_pressed() -> void:
	vanish()
	bag_container = true
	current_state = Menu_state.BAG

func _on_run_pressed() -> void:
	vanish()
	run_container = true
	current_state = Menu_state.RUN
	


func hide_after_act_pressed_for_Text():
	enemy_group.act_options.act_disappear()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,753),0.2).set_trans(Tween.TRANS_QUAD)
	
	menu.hide()
	await tweens.finished

func action_button_pressed() -> void:
	
	
	if check.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(check.text,enemy_group.enemies[enemy_group.index],act_dialogue_box,self)
	if focus.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(focus.text,enemy_group.enemies[enemy_group.index],act_dialogue_box,self)
	if guard.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(guard.text,enemy_group.enemies[enemy_group.index],act_dialogue_box,self)
	if top_left.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(top_left.text,enemy_group.enemies[enemy_group.index],act_dialogue_box,self)
	if top_right.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(top_right.text,enemy_group.enemies[enemy_group.index],act_dialogue_box,self)
	if middle_left.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(middle_left.text,enemy_group.enemies[enemy_group.index],act_dialogue_box,self)
	if middle_right.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(middle_right.text,enemy_group.enemies[enemy_group.index],act_dialogue_box,self)
	if bottom_left.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(bottom_left.text,enemy_group.enemies[enemy_group.index],act_dialogue_box,self)
	if bottom_right.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(bottom_right.text,enemy_group.enemies[enemy_group.index],act_dialogue_box,self)
