extends Node

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var player_group = RefrenceNode.PlayerGroup

func _Movement_Turn(list):
	match list[1]:
		0:
			pass
