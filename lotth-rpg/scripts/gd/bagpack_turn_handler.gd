extends Node

@onready var RefrenceNode = get_tree().get_root().get_child(-1).get_node("RefrenceCrossRoad")

@onready var turn_handler = RefrenceNode.TurnHandler
@onready var Menu = RefrenceNode.Menu
@onready var enemy_group = RefrenceNode.EnemyGroup
@onready var player_group = RefrenceNode.PlayerGroup

# in the turn handler this helps point to the correct variable, and if it turns out
# that the player does want to heal, then it helps to pick a different player,
# instead the dead guy in the battlefield 
var is_this_heal = [0]

func _Bagpack_Turn(list):
	# this checks for if the current guy, who we are letting through the turn, is alive
	# or dead/KOd
	turn_handler._Does_opponent_exist(list,is_this_heal)
	match list[1]:
		0: ## this is for the healing items
			if Data.get_item_health_type(list[4]):
				list[3].Bar.bar_health_restored(Data.get_item_hp(list[4]),2)
			else:
				list[3].Bar.bar_health_restored(Data.get_item_eng(list[4]),1)
		1: ## this is for the attacking items
			if Data.get_item_damage_type(list[4]) == true:
				list[3]._take_true_damage(Data.get_item_t_dmg(list[4]))
			else:
				print(list[2].Fight_stats.Base_Phisical_Attack)
				list[3]._take_damage(list[2].Fight_stats.Base_Phisical_Attack,Data.get_item_dmg(list[4]),list[2].Fight_stats.Attack_Type,Data.get_item_atk_type(list[4]),list[2].Fight_stats.Base_Magical_Attack)
