extends PanelContainer
class_name Action_control

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var check: Button = $MarginContainer/VBoxContainer/check
@onready var focus: Button = $MarginContainer/VBoxContainer/focus
@onready var guard: Button = $MarginContainer/VBoxContainer/guard

@onready var top_left: Button = $MarginContainer/VBoxContainer/top_left
@onready var top_right: Button = $MarginContainer/VBoxContainer/top_right
@onready var middle_left: Button = $MarginContainer/VBoxContainer/middle_left
@onready var middle_right: Button = $MarginContainer/VBoxContainer/middle_right
@onready var bottom_left: Button = $MarginContainer/VBoxContainer/bottom_left
@onready var bottom_right: Button = $MarginContainer/VBoxContainer/bottom_right

#Getting a basic order down and I will use it later!
@onready var list_of_buttons = [check,focus,guard,top_left,top_right,middle_left,middle_right,bottom_left,bottom_right]

@onready var menu = RefrenceNode.Menu
@onready var Action_button_handler = RefrenceNode.ActHandler
@onready var player = RefrenceNode.PlayerGroup
@onready var enemy = RefrenceNode.EnemyGroup

var current_choosen_enemy

func _ready() -> void:
	# hide it when scene starts!
	self.hide()
	# also disable all buttons!
	for i in list_of_buttons:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	
# When the ACT option is pressed and the enemy is determend (i.e by choosing them) 
# I add all the buttons from the left side to the right going top to bottom! 
# I also set the first 3 to the basic's, than I change the text to 
# the proper one until I don't have anymore names, THIS entire thing is stored in dict's that is inside 
# the Data global variable, and I can access them via Data.get_actions_of_enemy(ID number):
# and this gives me all the possible options
func act_add_actions(list_of_added):
	current_choosen_enemy = enemy.sub_e_index
	#["Talk","Grab","Ball"]
	var amount_of_options = [check,focus,guard]
	list_of_buttons = [top_left,middle_left,bottom_left,top_right,middle_right,bottom_right]
	for i in list_of_added:
		var index_of_string = list_of_added.find(i)
		var change = list_of_buttons[index_of_string]
		change.text = str(i)
		amount_of_options.append(change)
	list_of_buttons = amount_of_options

#Simple tween that brings up the ACT options by using all the added actions via list!
func act_appear():
	for i in list_of_buttons:
		i.modulate = Color.WHITE
		i.focus_mode = Control.FOCUS_ALL
		i.disabled = false
	check.grab_focus()
	self.show()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,526),0.3).set_trans(Tween.TRANS_QUAD)
	#await tweens.finished

#AND this does the opposite IF YOU HAVE NO IDEA HOW IT WORKS JUST SIMPLY pulling it up and hiding 
#all the posibilits to see it!
func act_disappear():
	#print("BYE WORLD")
	list_of_buttons = [check,focus,guard,top_left,top_right,middle_left,middle_right,bottom_left,bottom_right]
	for i in list_of_buttons:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	var tweens = get_tree().create_tween()
	check.release_focus()
	tweens.tween_property(self,"position",Vector2(self.position.x,843),0.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished
	#self.hide()
	
# when option pressed then we just add it to an Array of all the options that will run in the end, and deduct
# 1 of the maximum of options a player can choose!
func action_button_pressed(extra_arg_0: StringName) -> void:
	for i in list_of_buttons:
		if i.name == extra_arg_0:
			player.all_p_actions.push_back(["act",i.text,self,0,enemy.enemies[current_choosen_enemy],player.player[player.p_index]])
			menu.vanish()
			
		# WARNING THIS MIGHT BE A PLACE WHERE A BUG COULD APPEAR! PLEASE IN THE NEAR FUTURE YOU ACT ON THIS
		# AND FIND A BETTER SOLUTION (IF THE SUSOECTED BUG IS SQUISHED PLS DELETE THIS MASSAGE)
		# THANK YOU!
			player.player[player.p_index].PlayOutOptions -= 1
			if player.player[player.p_index].PlayOutOptions != 0:
					enemy.call_menu_appear()
