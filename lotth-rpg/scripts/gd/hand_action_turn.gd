extends Node

@onready var RefrenceNode: CrossRoad = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var turn_handler = RefrenceNode.TurnHandler
@onready var Menu = RefrenceNode.Menu
@onready var Action_button_handler = RefrenceNode.ActHandler

var is_this_heal = [9] #random number nobody cares about

# this takes care of the action options
func _Action_Turn(list):
	match list[1]:
		0: ## player to enemy
			turn_handler._Does_opponent_exist(list,is_this_heal)
			#"act",0,initiative.sorted_player[player.p_index],enemy.enemies[current_choosen_enemy],i.text,self
			Action_button_handler._get_button_text_action(list[4],list[5],RefrenceNode,list[3],list[2])
		1: ## enemy to itself
			turn_handler._Does_opponent_exist(list,is_this_heal)
			#"act",0,initiative.sorted_player[player.p_index],enemy.enemies[current_choosen_enemy],i.text,self
			Action_button_handler._get_button_text_action(list[4],list[5],RefrenceNode,list[3],list[2])
