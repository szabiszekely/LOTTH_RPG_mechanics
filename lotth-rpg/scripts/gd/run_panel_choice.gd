extends PanelContainer
class_name Run_control

@export var get_players = Player_group
@export var get_enemies = Enemy_group
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
	pass


func spare_func() -> void:
	for enemy in get_enemies.enemy_group.enemies:
		if enemy.Fight_stats.EMP >= enemy.Fight_stats.MAX_EMP:
			print("DONE")
		else:
			print_debug("Can't let them go, they still not reached they Max EMP?")
