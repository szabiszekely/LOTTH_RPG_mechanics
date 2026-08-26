extends Node

@onready var RefrenceNode: CrossRoad = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")
@onready var preloaded_Break_out = preload("res://scenes/mod_break_out.tscn")

var player_break_out_total: int = 0
var enemy_break_out_total: int = 0

func _Run_Turn(list):
	RefrenceNode.InitiativeHandler.doTrapForLoop = true
	var instance = preloaded_Break_out.instantiate()
	instance.position = RefrenceNode.ProCamera.position
	instance.hide()
	RefrenceNode.MainNode.add_child(instance)
	await get_tree().create_timer(0.2).timeout
	instance._break_out_meter_setup(player_break_out_total,enemy_break_out_total,RefrenceNode.break_out_meter,RefrenceNode)
	instance.show()
	
	
func _get_all_character_break_out_total():
	player_break_out_total = 0
	enemy_break_out_total = 0
	for i in RefrenceNode.Players:
		player_break_out_total += 1 + i.Fight_stats.Speed
	for i in RefrenceNode.Enemeies:
		enemy_break_out_total += 1 + i.Fight_stats.Speed
