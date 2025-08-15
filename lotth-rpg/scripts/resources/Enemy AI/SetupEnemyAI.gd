extends Resource
class_name SetupEnemyAI

var battle_scene
var enemy_group
var player_group
var initiative
var act_panel_choice

var before_enemy_turn_player = []
var before_enemy_turn_enemy = []
var before_enemy_turn = []
var player_actions = []
var enemy_actions = []

enum Enemy_Personality_Types{
	Angry,
	Scared,
	Primal,
	Loyal,
	Random,
	Parasitic
}

func _setup(enemies,players,Initiative_script,BattleScene,act_button_handler):
	enemy_group = enemies
	player_group = players
	initiative = Initiative_script
	battle_scene = BattleScene
	act_panel_choice = act_button_handler

func _EnemyAI(self_enemy,deck):
	pass



# gets everything before the enemy
func _sort_before_self(self_e):
	for i in initiative.all_rolls: 
		if i[-1] != self_e:
			before_enemy_turn.append(i)
		else:
			break
# this one removes all enemies and only leave Players if their are any
func _same_type_enemy(self_e):
	for i in before_enemy_turn:
		for j in initiative.sorted_enemies:
			if i[-1] == j:
				before_enemy_turn_enemy.append(i)
			else:
				before_enemy_turn_player.append(i)
				
# get the players switched out with their actions
func _get_actions_player(self_e):
	var temp = []
	for i in enemy_group.p_actions:
		for j in before_enemy_turn_player:
			if i[2] == j[-1]:
				temp.append(i)
	player_actions.clear()
	for i in temp: 
		player_actions.append(i)

func _get_actions_enemy(self_e):
	var temp = []
	for i in enemy_group.p_actions:
		for j in before_enemy_turn_enemy:
			if i[2] == j[-1]:
				temp.append(i)
	enemy_actions.clear()
	for i in temp: 
		enemy_actions.append(i)
