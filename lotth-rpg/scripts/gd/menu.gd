extends PanelContainer
class_name Menu_shared

@export var enemy_group: Enemy_group
@export var player_group: Player_group
@export var Action_button_handler: Action_buttons_option_Handler
@export var Run_button_handler: Run_control

@onready var abilities: Button = $MarginContainer/HBoxContainer/Abilities
@onready var action: Button = $MarginContainer/HBoxContainer/Action
@onready var bagpack: Button = $MarginContainer/HBoxContainer/Bagpack
@onready var run: Button = $MarginContainer/HBoxContainer/Run

@onready var menu: Control = $"."
@onready var action_options: Action_control = $"../Action_Panel_choice"
@onready var break_out_and_spare: Run_control = $"../Run_Panel_choice"
@onready var order_counter: PanelContainer = $"../Order_counter"
@onready var bar_system: Indicator_bar = $"../Bar_System"
@onready var act_dialogue_box: DialogueBox = $"../Action_option_box"
@onready var static_dialogue_box: DialogueBox = $"../Static_Dialogue_Box"


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

enum Menu_State {
	MENU,
	ABILITES,
	ACTIONS,
	BAG,
	RUN,
	CHOOSING_ENEMY,
	CHOOSING_ALLY,
	ACTION_OPTIONS,
	ALL_GONE
}
enum Memmory_State {
	MENU,
	ABILITES,
	ACTIONS,
	BAG,
	RUN,
	CHOOSING_ENEMY,
	CHOOSING_ALLY,
	ACTION_OPTIONS,
	ALL_GONE
}
var current_state
var current_memory
var abi = false
var act = false
var bag = false
var camera_toggle = false

func _ready() -> void:
	current_state = Menu_State.MENU
	current_memory = current_state
	abilities.grab_focus()
	
func _process(_delta: float) -> void:
	match current_state:
		Menu_State.MENU:
			current_memory = current_state
			menu.show()
			print("MENU")
		
		Menu_State.ABILITES:
			current_memory = current_state
			#choosen_abilities.show()
			print("Abilites")
		
		Menu_State.ACTIONS:
			current_memory = current_state
			# enemy Choosing CODE
			enemy_group._start_choosing()
			print("Actions")
		
		Menu_State.BAG:
			current_memory = current_state
			#items.show()
			print("BAG and ITEMS")
		
		Menu_State.RUN:
			current_memory = current_state
			break_out_and_spare.show()
			print("Break out?")
		
		Menu_State.CHOOSING_ENEMY:
			current_memory = current_state
			enemy_group._start_choosing()
			print("ENEMY")
		
		Menu_State.CHOOSING_ALLY:
			current_memory = current_state
			# player Choosing CODE
			print("ALLY")
		
		Menu_State.ACTION_OPTIONS:
			current_memory = current_state
			action_options.show()
			print("HERE ARE THE OPTIONS")
		
		Menu_State.ALL_GONE:
			vanish()
			all_gone()
			print("VANISHED")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		match current_state:
			Menu_State.ABILITES:
				vanish()
				abi = false
				current_state = Menu_State.MENU
				abilities.grab_focus()
			Menu_State.BAG:
				vanish()
				bag = false
				current_state = Menu_State.MENU
				bagpack.grab_focus()
			Menu_State.RUN:
				vanish()
				current_state = Menu_State.MENU
				run.grab_focus()
			Menu_State.CHOOSING_ENEMY:
				if act == true:
					vanish()
					act = false
					
					current_state = Menu_State.MENU
					action.grab_focus()
				elif abi == true:
					vanish()
					current_state = Menu_State.ABILITES
				elif bag == true:
					vanish()
					current_state = Menu_State.BAG
				else:
					print("SOMETHING WRONG!")
			Menu_State.CHOOSING_ALLY:
				if abi == true:
					vanish()
					current_state = Menu_State.ABILITES
				elif bag == true:
					vanish()
					current_state = Menu_State.BAG
			Menu_State.ACTION_OPTIONS:
				vanish()
				current_state = Menu_State.CHOOSING_ENEMY
	if event.is_action_pressed("Cam_change"):
		camera_toggle = !camera_toggle
		
		if camera_toggle == true:
			current_state = Menu_State.ALL_GONE
		else:
			back_to_normal()
			current_state = current_memory

func vanish():
	menu.hide()
	#choosen_abilities.hide()
	#choosen_enemies.hide()
	#choosen_players.hide()
	action_options.hide()
	break_out_and_spare.hide()
	act_dialogue_box.hide()
	static_dialogue_box.hide()
	#items.hide()
	
func all_gone():
	abilities.process_mode = Node.PROCESS_MODE_DISABLED
	action.process_mode = Node.PROCESS_MODE_DISABLED
	bagpack.process_mode = Node.PROCESS_MODE_DISABLED
	run.process_mode = Node.PROCESS_MODE_DISABLED
	#choosen_abilities.process_mode = Node.PROCESS_MODE_DISABLED
	#choosen_enemies.process_mode = Node.PROCESS_MODE_DISABLED
	#choosen_players.process_mode = Node.PROCESS_MODE_DISABLED
	action_options.process_mode = Node.PROCESS_MODE_DISABLED
	break_out_and_spare.process_mode = Node.PROCESS_MODE_DISABLED
	#items.process_mode = Node.PROCESS_MODE_DISABLED

func back_to_normal():
	abilities.process_mode = Node.PROCESS_MODE_INHERIT
	action.process_mode = Node.PROCESS_MODE_INHERIT
	bagpack.process_mode = Node.PROCESS_MODE_INHERIT
	run.process_mode = Node.PROCESS_MODE_INHERIT
	#choosen_abilities.process_mode = Node.PROCESS_MODE_INHERIT
	#choosen_enemies.process_mode = Node.PROCESS_MODE_INHERIT
	#choosen_players.process_mode = Node.PROCESS_MODE_INHERIT
	action_options.process_mode = Node.PROCESS_MODE_INHERIT
	break_out_and_spare.process_mode = Node.PROCESS_MODE_INHERIT
	#items.process_mode = Node.PROCESS_MODE_INHERIT
	
func abilities_pressed() -> void:
	vanish()
	abi = true
	
	current_state = Menu_State.ABILITES
	
func action_pressed() -> void:
	vanish()
	act = true
	
	current_state = Menu_State.CHOOSING_ENEMY

func bagpack_pressed() -> void:
	bag = true
	vanish()
	current_state = Menu_State.BAG


func run_pressed() -> void:
	vanish()
	current_state = Menu_State.RUN
	
func Choosen_abi() -> void:
	vanish()
	current_state = Menu_State.CHOOSING_ENEMY
func Choosen_abi_2() -> void:
	vanish()
	current_state = Menu_State.CHOOSING_ALLY
func Item_to_enemy() -> void:
	vanish()
	current_state = Menu_State.CHOOSING_ENEMY
func Item_to_friend() -> void:
	vanish()
	current_state = Menu_State.CHOOSING_ALLY

func enemy() -> void:
	vanish()
	if act == true:
		print("ACTIONS")
		current_state = Menu_State.ACTION_OPTIONS
	elif abi == true:
		print("YOU TARGETED THE ENEMY, NOW TIME TO DIE!")
	elif bag == true:
		print("YOU THROUG A ROCK AT AN ENEMY")
	else:
		print("SOMETHING WENT WRONG!",abi,act,bag)
		
func player() -> void:
	vanish()
	if abi == true:
		print("You HEALED ONE OF YOUR ALLY!")
	elif bag == true:
		print("YOU GAVE A HEALTH ITEM TO ONE OF YOUR ALLY!")
	else:
		print("SOMETHING WENT WRONG!",abi,act,bag)
func action_stuff() -> void:
	vanish()
	print("You grabed your enemy by the nuts")
func breaking_out() -> void:
	vanish()
	print("you escaped from the battle")
	
			
 # this is only here so I don't have to reuse these few lines of code so I only use func and its just 1 line! NICE
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
