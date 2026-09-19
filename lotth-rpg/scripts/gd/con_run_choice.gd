extends PanelContainer
class_name Run_control

@onready var RefrenceNode:CrossRoad = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var get_menu = RefrenceNode.Menu

@onready var break_out: Button = $MarginContainer/VBoxContainer/Break_out
@onready var spare: Button = $MarginContainer/VBoxContainer/Spare

@onready var menu = RefrenceNode.Menu
@onready var player = RefrenceNode.PlayerGroup
@onready var enemy = RefrenceNode.EnemyGroup
@onready var initiative = RefrenceNode.InitiativeHandler


func _ready() -> void:
	# hide it when scene starts!
	self.hide()
	# also disable all buttons!
	for i in [break_out,spare]:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	#run_appear()

func run_appear():
	for i in [break_out,spare]:
		i.modulate = Color.WHITE
		i.focus_mode = Control.FOCUS_ALL
		i.disabled = false
	break_out.grab_focus()
	self.show()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,630.0),0.3).set_trans(Tween.TRANS_QUAD)
	#print("Run Apear")
	
func run_disappear():
	for i in [break_out,spare]:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	break_out.release_focus()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,845.0),0.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished
	#self.hide()
	
	

#the escape sequance is:
# break_out_value = character 1: (1 + speed) + character 2: (1 + speed) + ect...
# Total: (break_out_value / 100)
# mash to increase the break out sequence up to a 100
	
func breaking_out_func() -> void:
	player.all_p_actions.push_back(["run",0,initiative.sorted_player[player.p_index]])
	menu.vanish()
	initiative.sorted_player[player.p_index]._play_out_tick_down()
	if initiative.sorted_player[player.p_index].PlayOutOptions != 0:
		player.call_menu_appear()
	# Run code and precentage check HERE


func spare_func() -> void:
	var spared = 0
	for i in enemy.enemies:
		if i.Fight_stats.EMP >= i.Fight_stats.MAX_EMP:
			print("Done")
			spared += 1
		else:
			print_debug("Can't let them go, they still not reached they Max EMP?")
	# EMP reached, fight end HERE
	if spared == len(enemy.enemies):
		menu.current_state = menu.Menu_state.ALL_GONE
		menu.vanish()
		RefrenceNode.DialogicControl._vanish_dialog()
		break_out.disabled = true
		spare.disabled = true
		spare.release_focus()
		var instance:Victory_Screen = preload("res://scenes/con_victory_screen.tscn").instantiate()
		RefrenceNode.UI.add_child(instance)
		instance.gold_gained = 100 ## Automatic money gain
		instance._write()
		instance._victory_screen_fade_in()
