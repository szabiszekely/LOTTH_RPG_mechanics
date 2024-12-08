extends PanelContainer
class_name Action_control
@onready var check: Button = $MarginContainer/VBoxContainer/Check
@onready var focus: Button = $MarginContainer/VBoxContainer/Focus
@onready var guard: Button = $MarginContainer/VBoxContainer/Guard

@onready var top_left: Button = $MarginContainer/VBoxContainer/top_left
@onready var top_right: Button = $MarginContainer/VBoxContainer/top_right
@onready var middle_left: Button = $MarginContainer/VBoxContainer/middle_left
@onready var middle_right: Button = $MarginContainer/VBoxContainer/middle_right
@onready var bottom_left: Button = $MarginContainer/VBoxContainer/bottom_left
@onready var bottom_right: Button = $MarginContainer/VBoxContainer/bottom_right

#Getting a basic order down and I will use it later!
@onready var list_of_buttons = [check,focus,guard,top_left,top_right,middle_left,middle_right,bottom_left,bottom_right]


func _ready() -> void:
	# hide it when scene starts!
	self.hide()
	# also disable all buttons!
	for i in list_of_buttons:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	#act_appear()
	
# When the ACT option is pressed and the enemy is determend I add all the buttons from the left side
# to the right going top to bottom! I also set the first 3 to the basic's, than I change the text to 
# the proper one until I don't have anymore names, THIS entire thing is stored in dict's called Entity_finder.tres
func act_add_actions(list_of_added):
	#["Talk","Grab","Ball"]
	var amount_of_options = [check,focus,guard]
	list_of_buttons = [top_left,middle_left,bottom_left,top_right,middle_right,bottom_right]
	for i in list_of_added:
	
		var index_of_string = list_of_added.find(i)
		var change = list_of_buttons[index_of_string]
		change.text = i
		amount_of_options.append(change)
	list_of_buttons = amount_of_options

#Simple tween that brings up the ACT options!
func act_appear():
	#list_of_buttons
	#print("HI WORLD")
	for i in list_of_buttons:
		i.modulate = Color.WHITE
		i.focus_mode = Control.FOCUS_ALL
		i.disabled = false
	check.grab_focus()
	self.show()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,526),0.3).set_trans(Tween.TRANS_QUAD)
	#await tweens.finished

#AND this does the opposite IF YOU HAVE NO IDEA HOW IT WORKS JUST SIMPLY pulling it up and hiding all the posibilits to see it!
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
	
