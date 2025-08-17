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

var BoardState: Dictionary = {
	"lowest_HP_player":[],
	"lowest_ENG_player":[],
	"lowest_ENG_enemy":[],
	"lowest_HP_enemy":[],
	"highest_ENG_player":[],
	"highest_HP_player":[],
	"strongest_player":[],
	"strongest_enemy":[],
	"closest_player":[],
	"kindest_player":[],
	"worst_player":[],
}

var PlayerAgro: Dictionary = {}
var PlayerKind: Dictionary = {}

func _setup(enemies,players,Initiative_script,BattleScene,act_button_handler):
	enemy_group = enemies
	player_group = players
	initiative = Initiative_script
	battle_scene = BattleScene
	act_panel_choice = act_button_handler
	
	PlayerAgro.clear()
	for i in players.player:
		PlayerAgro.set(i,0)
		PlayerKind.set(i,0)

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

#["lowest_HP_player","lowest_ENG_player","lowest_ENG_enemy","lowest_HP_enemy","highest_ENG_player","highest_HP_player","strongest_player","strongest_enemy","closest_player","kindest_player","worst_player"]:
func _data_analysis():
	
	var player_array:Array = player_group.player
	var enemy_array = enemy_group.enemies
	player_array.append_array(enemy_array)
	
	BoardState.clear()
	for i in BoardState.keys():
		BoardState.set(i,[])
	

func _player_actions():
	for i in enemy_group.p_actions:
		match i:
			"atk":
				pass
			"act":
				pass
			"bag":
				pass
