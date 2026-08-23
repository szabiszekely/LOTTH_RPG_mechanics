extends PanelContainer
class_name Run_control

@onready var RefrenceNode:CrossRoad = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var get_menu = RefrenceNode.Menu

@onready var break_out: Button = $MarginContainer/VBoxContainer/Break_out
@onready var spare: Button = $MarginContainer/VBoxContainer/Spare

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
	RefrenceNode.all_p_actions.push_back(["atk",2,initiative.sorted_player[player.p_index],0,used_card_name])
	pass
	# Run code and precentage check HERE


func spare_func() -> void:
	for enemy in get_menu.enemy_group.enemies:
		if enemy.Fight_stats.EMP >= enemy.Fight_stats.MAX_EMP:
			print("DONE")
			# EMP reached, fight end HERE
		else:
			print_debug("Can't let them go, they still not reached they Max EMP?")
