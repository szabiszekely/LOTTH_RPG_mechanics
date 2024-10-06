extends PanelContainer

@export var enemy_group: Enemy_group
@export var player_group: Player_group
@export var Action_button_handler: Action_buttons_option_Handler
@onready var GUI = owner
var should_be_able_to_hide_menu = true
var dialogue_bo

@onready var check = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("Check")
@onready var focus = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("Focus")
@onready var guard = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("Guard")
@onready var top_left = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("top_left")
@onready var top_right = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("top_right")
@onready var middle_left = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("middle_left")
@onready var middle_right = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("middle_right")
@onready var bottom_left = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("bottom_left")
@onready var bottom_right = owner.find_child("Action_Panel_choice").find_child("MarginContainer").find_child("VBoxContainer").find_child("bottom_right")

func _ready() -> void:
	
	pass
	

func abilities_pressed() -> void:
	pass # Replace with function body.


func action_pressed() -> void:
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,753),0.2).set_trans(Tween.TRANS_QUAD)
	await tweens.finished
	
	self.hide()
	enemy_group._start_choosing()
	enemy_group.act = true

func bagpack_pressed() -> void:
	pass # Replace with function body.


func run_pressed() -> void:
	pass # Replace with function body.
	
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_cancel"):
#region Action Code Section
		if enemy_group.act == true: # Getting out of choosing and backup to the menu
			enemy_group._reset_focus()
			self.show()
			var tweens = get_tree().create_tween()
			tweens.tween_property(self,"position",Vector2(self.position.x,533),0.2).set_trans(Tween.TRANS_QUAD)
			await tweens.finished
			self.find_child("Action").grab_focus()
			enemy_group.act = false
		
		if enemy_group.act == false and enemy_group.options_are_on == true: # Getting out of the Action Menu and starting choosing
			enemy_group._start_choosing()
			enemy_group.act_options.act_disappear()
			var tweens = get_tree().create_tween()
			tweens.tween_property(self,"position",Vector2(self.position.x,753),0.2).set_trans(Tween.TRANS_QUAD)
			await tweens.finished
			self.hide()
			enemy_group.options_are_on = false
			enemy_group.act = true
#endregion
	if Input.is_action_just_pressed("Cam_change"):
		if should_be_able_to_hide_menu == true:
			should_be_able_to_hide_menu = !should_be_able_to_hide_menu
			enemy_group.should_be_able_to_interact_with_menu = false
			var tweens = get_tree().create_tween()
			tweens.tween_property(self,"modulate",Color.TRANSPARENT,0.05).set_trans(Tween.TRANS_QUAD)
			tweens.tween_property(GUI.find_child("Order_counter"),"modulate",Color.TRANSPARENT,0.05).set_trans(Tween.TRANS_QUAD)
			tweens.tween_property(GUI.find_child("Bar_System"),"modulate",Color.TRANSPARENT,0.05).set_trans(Tween.TRANS_QUAD)
			tweens.tween_property(GUI.find_child("Action_Panel_choice"),"modulate",Color.TRANSPARENT,0.05).set_trans(Tween.TRANS_QUAD)
			var buttons_bc_I_m_lazy = [$MarginContainer/HBoxContainer/Abilities, $MarginContainer/HBoxContainer/Action, $MarginContainer/HBoxContainer/Bagpack, $MarginContainer/HBoxContainer/Run]
			for i in buttons_bc_I_m_lazy:
				i.process_mode = Node.PROCESS_MODE_DISABLED
			GUI.find_child("Action_Panel_choice").process_mode = Node.PROCESS_MODE_DISABLED
			await tweens.finished
		else:
			should_be_able_to_hide_menu = !should_be_able_to_hide_menu
			enemy_group.should_be_able_to_interact_with_menu = true
			var tweens = get_tree().create_tween()
			tweens.tween_property(self,"modulate",Color.WHITE,0.05).set_trans(Tween.TRANS_QUAD)
			tweens.tween_property(GUI.find_child("Order_counter"),"modulate",Color.WHITE,0.05).set_trans(Tween.TRANS_QUAD)
			tweens.tween_property(GUI.find_child("Bar_System"),"modulate",Color.WHITE,0.05).set_trans(Tween.TRANS_QUAD)
			tweens.tween_property(GUI.find_child("Action_Panel_choice"),"modulate",Color.WHITE,0.05).set_trans(Tween.TRANS_QUAD)
			var buttons_bc_I_m_lazy = [$MarginContainer/HBoxContainer/Abilities, $MarginContainer/HBoxContainer/Action, $MarginContainer/HBoxContainer/Bagpack, $MarginContainer/HBoxContainer/Run]
			for i in buttons_bc_I_m_lazy:
				i.process_mode = Node.PROCESS_MODE_INHERIT
			GUI.find_child("Action_Panel_choice").process_mode = Node.PROCESS_MODE_INHERIT
			await tweens.finished
	
func hide_after_act_pressed_for_Text():
	enemy_group.act_options.act_disappear()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,753),0.2).set_trans(Tween.TRANS_QUAD)
	self.hide()
	await tweens.finished

func action_button_pressed() -> void:
	

	if check.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(check.text,enemy_group.enemies[enemy_group.index])
	if focus.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(focus.text,enemy_group.enemies[enemy_group.index])
	if guard.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(guard.text,enemy_group.enemies[enemy_group.index])
	if top_left.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(top_left.text,enemy_group.enemies[enemy_group.index])
	if top_right.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(top_right.text,enemy_group.enemies[enemy_group.index])
	if middle_left.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(middle_left.text,enemy_group.enemies[enemy_group.index])
	if middle_right.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(middle_right.text,enemy_group.enemies[enemy_group.index])
	if bottom_left.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(bottom_left.text,enemy_group.enemies[enemy_group.index])
	if bottom_right.is_pressed():
		hide_after_act_pressed_for_Text()
		Action_button_handler._get_button_text_action(bottom_right.text,enemy_group.enemies[enemy_group.index])
