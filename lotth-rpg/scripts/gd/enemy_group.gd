extends Node2D
class_name Enemy_group

@onready var menu: PanelContainer = $"../../UI_battle_menu/Menu"

@export var act_options: Action_control
@export var find_entity: Entity_finder

var enemies: Array = []
var index: int = 0
var options_are_on = false

var abi = false
var act = false



func _ready() -> void:
	enemies = get_children()
	#print(enemies)
	show_choices()
	
func _process(delta: float) -> void:
	if not menu.visible and options_are_on == false:
		
		if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left"):
			if index > 0:
				index -= 1
				switch_focus(index, index+1)
			else:
				index = enemies.size() -1
				switch_focus(index,0)
		
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right"):
			if index < enemies.size() - 1:
				index += 1
				switch_focus(index, index-1)
			else:
				index = 0
				switch_focus(index,enemies.size() - 1)
		
		
		if Input.is_action_just_pressed("ui_accept"):
			if act == true:
				act = false
				print(find_entity._finding_entity(enemies[index].Fight_stats.name))
				act_options.act_add_actions(find_entity._finding_entity(enemies[index].Fight_stats.name))
				enemies[index]._unfocus_indicator()
				options_are_on = true
				menu.show()
				act_options.act_appear()
				var tweens = get_tree().create_tween()
				tweens.tween_property(menu,"position",Vector2(menu.position.x,533),0.5).set_trans(Tween.TRANS_QUAD)
				await tweens.finished
			


			
func switch_focus(x, y):
	enemies[x]._focus_indicator()
	enemies[y]._unfocus_indicator()

func show_choices():
	menu.show()
	menu.find_child("Abilities").grab_focus()

func _reset_focus():
	index = 0
	for enemy in enemies:
		enemy._unfocus_indicator()

func _start_choosing():
	_reset_focus()
	enemies[0]._focus_indicator()
