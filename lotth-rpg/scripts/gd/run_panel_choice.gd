extends PanelContainer
class_name Run_control

@export var get_menu: Menu_system

var players: Array
var enemies: Array
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
	tweens.tween_property(self,"position",Vector2(self.position.x,333),0.3).set_trans(Tween.TRANS_QUAD)
	#print("Run Apear")
	
func run_disappear():
	for i in [break_out,spare]:
		i.disabled = true
		i.modulate = Color.TRANSPARENT
		i.focus_mode = Control.FOCUS_NONE
	break_out.release_focus()
	var tweens = get_tree().create_tween()
	tweens.tween_property(self,"position",Vector2(self.position.x,653),0.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished
	#self.hide()
	
	
func breaking_out_func() -> void:
	var percentage:float = 1
	var running_attempt_counter_enemy: float = 0
	var running_attempt_counter_player: float = 0
	var all_p: int = 0
	var all_e: int = 0
	
	for player in get_menu.player_group.player:
		all_p = all_p + player.Fight_stats.Speed
	for enemy in get_menu.player_group.player:
		all_e = all_e + enemy.Fight_stats.Speed
	
	running_attempt_counter_player = all_p * 5
	running_attempt_counter_enemy = all_e * 10
	
	running_attempt_counter_enemy = running_attempt_counter_enemy / 100
	running_attempt_counter_player = running_attempt_counter_player / 100
	
	percentage = percentage - running_attempt_counter_enemy
	percentage = percentage + running_attempt_counter_player
	print(percentage)
	# Run code and precentage check HERE
func spare_func() -> void:
	for enemy in get_menu.enemy_group.enemies:
		if enemy.Fight_stats.EMP >= enemy.Fight_stats.MAX_EMP:
			print("DONE")
			# EMP reached, fight end HERE
		else:
			print_debug("Can't let them go, they still not reached they Max EMP?")
