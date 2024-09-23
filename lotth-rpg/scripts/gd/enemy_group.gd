extends Node2D

@onready var menu: PanelContainer = $"../UI_battle_menu/Menu"

@export var act_options: Action_control
@export var find_entity: Entity_finder

var enemies: Array = []
var index: int = 0
var options_are_on = false

func _ready() -> void:
	enemies = get_children()
	#print(enemies)
	show_choices()
	
func _process(delta: float) -> void:
	if not menu.visible and options_are_on == false:
		if Input.is_action_just_pressed("ui_up"):
			if index > 0:
				index -= 1
				switch_focus(index, index+1)
		if Input.is_action_just_pressed("ui_down"):
			if index < enemies.size() - 1:
				index += 1
				switch_focus(index, index-1)
		if Input.is_action_just_pressed("ui_accept"):
			
			print(find_entity._finding_entity(enemies[index].Fight_stats.name))
			act_options.act_add_actions(find_entity._finding_entity(enemies[index].Fight_stats.name))
			enemies[index]._unfocus_indicator()
			options_are_on = true
			act_options.act_appear()
		


			
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


func _on_action_pressed() -> void:
	menu.hide()
	_start_choosing()


func _check_pressed() -> void:
	print("----------------")
	print("Stat Block")
	print(enemies[index].Fight_stats.name)
	print("HP:",enemies[index].Fight_stats.HP," ","ENG:",enemies[index].Fight_stats.ENG)
	print("PHIS_ATK:",enemies[index].Fight_stats.Base_Phisical_Attack, " ","MAG_ATK:", enemies[index].Fight_stats.Base_Magical_Attack)
	print("ATK_Type:",enemies[index].Fight_stats.Attack_Type)
	print("EMP:", enemies[index].Fight_stats.EMP)
	print("----------------")
