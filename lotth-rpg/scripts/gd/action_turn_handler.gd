extends Node

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var turn_handler = RefrenceNode.TurnHandler
@onready var Menu = RefrenceNode.Menu
@onready var Action_button_handler = RefrenceNode.ActHandler

var is_this_heal = [9] #random number nobody cares about

#["act"  i.text  self  0  enemy.enemies[enemy.e_index]  player.player[player.p_index]]
func _Action_Turn(list):
	turn_handler._Does_opponent_exist(list,is_this_heal)
	Action_button_handler._get_button_text_action(list[4],list[3],Menu.act_dialogue_box,list[5],Menu)
	turn_handler.initiative.timeSpentBetweenTurns = 4
