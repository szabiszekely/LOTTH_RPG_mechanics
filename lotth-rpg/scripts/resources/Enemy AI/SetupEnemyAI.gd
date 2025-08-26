extends Resource
class_name SetupEnemyAI_old









# THIS ONE IS THE OLD ONE DUMBY!!!!
# DON'T EDIT THIS BUT INSTEAD DELETE IT AS SOON AS POSSIBLE
# PLEASE DON'T FOOL YOURSELF PLEASE















#------Base Node Paths-------
var battle_scene
var enemy_group
var player_group
var initiative
var act_panel_choice
@export var personality_modifier: PersonalityModfier

#------Character Placements and Actions-------
var before_enemy_turn_player = []
var before_enemy_turn_enemy = []
var before_enemy_turn = []
var player_actions = []
var enemy_actions = []
var enemy_it_self



#------Funcions-------
func _setup(enemies,players,Initiative_script,BattleScene,act_button_handler):
	enemy_group = enemies
	player_group = players
	initiative = Initiative_script
	battle_scene = BattleScene
	act_panel_choice = act_button_handler
	personality_modifier._setup_per_mod(enemies,players,Initiative_script,BattleScene)

func _EnemyAI(deck):
	pass

func _SetupEnemyItSelf(self_enemy):
	enemy_it_self = self_enemy
	personality_modifier.enemy_it_self = self_enemy

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

	
