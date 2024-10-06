extends Node2D

@export var player: Player
@export var enemy: Enemy
@export var menu: PanelContainer

@onready var baloon = preload("res://text_folder/choosen_action_option.dialogue")

var dialogue_box
func _ready() -> void:
	get_tree().current_scene
	dialogue_box = DialogueManager.show_dialogue_balloon(baloon,"Battle_begins")
	
	pass
	
func _process(_delta: float) -> void:
	if menu.enemy_group.act == true or menu.enemy_group.options_are_on == true:
		dialogue_box.hide()
	else:
		dialogue_box.show()
	
	if Input.is_action_just_pressed("ui_up"):
		player._take_damage(enemy.Fight_stats.Base_Phisical_Attack,4,enemy.Fight_stats.Attack_Type)
	
	if Input.is_action_just_pressed("ui_down"):
		enemy._take_damage(player.Fight_stats.Base_Phisical_Attack,4,player.Fight_stats.Attack_Type)
	pass
