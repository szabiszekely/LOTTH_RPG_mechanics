extends Node

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var player_group = RefrenceNode.PlayerGroup

func _Movement_Turn(list):
	var map = list[1]
	var p = NavigationServer2D.map_get_closest_point(map,list[2])
	player_group.player[list[4]].nav_agent.target_position = p
