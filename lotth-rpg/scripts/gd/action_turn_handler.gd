extends Node

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var turn_handler = RefrenceNode.TurnHandler
@onready var Menu = RefrenceNode.Menu
@onready var Action_button_handler = RefrenceNode.ActHandler


func _Action_Turn(list):
	Action_button_handler._get_button_text_action(list[1],list[4],Menu.act_dialogue_box,list[2],Menu)
	turn_handler.initiative.timeSpentBetweenTurns = 4
