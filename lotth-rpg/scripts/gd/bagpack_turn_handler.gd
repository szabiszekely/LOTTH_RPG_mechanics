extends Node

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var turn_handler = RefrenceNode.TurnHandler
@onready var Menu = RefrenceNode.Menu
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var player_group = RefrenceNode.PlayerGroup


func _Bagpack_Turn(list):
	match list[3]:
		0:
			if Data.get_item_health_type(list[1]) == true:
				player_group.player[list[2]].Bar.bar_health_restored(Data.get_item_hp(list[1]),2)
			else:
				player_group.player[list[2]].Bar.bar_health_restored(Data.get_item_eng(list[1]),1)
			#list[4]._remove_item_from_inventory(list[4].deleting_item_index)
		1:
			if Data.get_item_damage_type(list[1]) == true:
				enemy_group.enemies[list[2]]._take_true_damage(Data.get_item_t_dmg(list[1]))
			else:
				enemy_group.enemies[list[2]]._take_damage(player_group.player[list[4]].Fight_stats.Base_Phisical_Attack,Data.get_item_dmg(list[1]),player_group.player[list[4]].Fight_stats.Attack_Type,Data.get_item_atk_type(list[1]),player_group.player[list[4]].Fight_stats.Base_Magical_Attack)
			#list[5]._remove_item_from_inventory(list[5].deleting_item_index)
