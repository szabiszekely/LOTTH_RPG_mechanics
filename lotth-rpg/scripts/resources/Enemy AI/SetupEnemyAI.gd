extends Resource
class_name SetupEnemyAI

var battle_scene
var enemy_group
var player_group
var initiative


func _setup(enemies,players,Initiative_script,BattleScene):
	enemy_group = enemies
	player_group = players
	initiative = Initiative_script
	battle_scene = BattleScene

func _EnemyAI(self_enemy):
	pass
