extends Resource
class_name SetupEnemyAI


#------Base Node Paths-------
var battle_scene
var enemy_group
var player_group
var initiative
var act_panel_choice
var enemy_it_self

#------Character Placements and Actions-------
var before_enemy_turn_player = []
var before_enemy_turn_enemy = []
var before_enemy_turn = []
var player_actions = []
var enemy_actions = []

#------Personality Modifiers-------
@export var angy_personality_bonus: int = 0 ## Adds a flat number to angro behaviour  
@export var dice_goal_number: int = 4 ## Initiative roll that determineds if a behaviour is good or bad
@export var personality_decrease_modifier_agression: float = 2 ## decreases the agression by X beening the number diveded by the current
@export var personality_decrease_modifier_kindness: float = 2 ## decreases the agression by X beening the number diveded by the current
@export var personality_aggresion: int = 1 ## Gives more chance to use a stronger attack
@export var personality_energy_precent: float = 0.5 ## if the energy below this number than the enemy will start to roll for energy heal
@export var energy_restore_check: float = 0.3  ## this is the minimum barrier, if the energy is below this, than it will heal
@export_enum("Stronger","Weaker") var stronger_or_weaker: String = "Stronger" ## Should the enemy attack Stronger or Weaker players
@export var team_player: bool = false ## Can it now about its teammates before hand?

#------Board State and Player Justice Stands-------
var BoardState: Dictionary = {
	"lowest_HP_player":[],
	"lowest_ENG_player":[],
	"lowest_ENG_enemy":[],
	"lowest_HP_enemy":[],
	"highest_ENG_player":[],
	"highest_HP_player":[],
	"strongest_player":[],
	"strongest_magic_player":[],
	"weakest_player": [],
	"weakest_magic_player": [],
	"strongest_enemy":[],
	"strongest_magic_enemy":[],
	"closest_player":[],
	"players_with_status_effect":[]
}
var enemy_current_ENG
var enemy_current_HP

var PlayerAgro: Dictionary = {}
var PlayerKind: Dictionary = {}

var ObjectivlyStrongesPlayer: Dictionary = {}
var ObjectivlyWeakestPlayer: Dictionary= {}

func _setup(enemies,players,Initiative_script,BattleScene,act_button_handler,enemy_self):
	enemy_group = enemies
	player_group = players
	initiative = Initiative_script
	battle_scene = BattleScene
	act_panel_choice = act_button_handler
	enemy_it_self = enemy_self
	_Player_Point_System()

func _Player_Point_System():
	for i in player_group.player:
		PlayerAgro.set(i,0)
		PlayerKind.set(i,0)


func _EnemyAI(deck):
	pass


func _TurnIsOver():
	pass


func _EnemyCurrentBarStatus():
	enemy_current_ENG = enemy_it_self.Bar.ENG_bar.material.get_shader_parameter("value")
	enemy_current_HP = enemy_it_self.Bar.ENG_bar.HP_bar.material.get_shader_parameter("value")
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

# (["atk",1,initiative.sorted_player[p_index],player[sub_index],                            card_againts_players          ])
#["act",0,initiative.sorted_player[player.p_index],enemy.enemies[current_choosen_enemy] ,   i.text,                  self]
#["bag",1,initiative.sorted_player[player.p_index],enemies[sub_e_index],                    item_againts_enemies,   menu.bagpack_choice]
# atk, index, from, to, data, data, data
func _player_actions():
	for i in enemy_group.p_actions:
		if i[3] == enemy_it_self or Data.get_card_range(i[4]) == "Self":
			match i[0]:
				"atk":
					# if DMG to this enemy
					# add DMG to ANGY points
					# add points based on personality
					# else add either PEAC points or add a flat ANGY point number
					var damage = Data.get_card_damage(i[4])
					if damage != 0:
						var combined =  20 + damage + angy_personality_bonus
						PlayerAgro[i[2]] += combined # + personality
					else:
						var dice_roll = randi_range(1,6)
						if dice_roll >= dice_goal_number: # +/- dependeds on personality
							PlayerKind[i[2]] += 10
						else:
							PlayerAgro[i[2]] += 10
				"act":
					# if trying to be kind
					# add a base number to PEAC points plus depending on personality add a bonus and reduce ANGY points by half (int)
					# else do nothing with points and just add a flat PEAC point to number
					if i[4] not in ["Check","Focus","Guard"]:
						PlayerKind[i[2]] += 20
						var dived = int(PlayerAgro.get(i[2]) / personality_decrease_modifier_agression)#divided by personality modifier
						PlayerAgro[i[2]] -= dived
					else:
						PlayerKind[i[2]] += 10
				"bag":
					# depending on the ANGY or PEAC point stat 
					# if ANGY is higher than make that number bigger
					# if PEAC is higher than make ANGY get reduced by 2
					var damage = Data.get_item_damage(i[4])
					if damage != 0:
						var combined =  20 + damage + angy_personality_bonus
						PlayerAgro[i[2]] += combined # + personality
					
					elif PlayerAgro.get(i[2]) > PlayerKind.get(i[2]):
						PlayerAgro[i[2]] += 20
						var dived = int(PlayerKind.get(i[2]) / personality_decrease_modifier_kindness)#divided by personality modifier
						PlayerKind[i[2]] -= dived
					
					elif PlayerKind.get(i[2]) > PlayerAgro.get(i[2]):
						PlayerKind[i[2]] += 20
						var dived = int(PlayerAgro.get(i[2]) / personality_decrease_modifier_agression)#divided by personality modifier
						PlayerAgro[i[2]] -= dived
					
					elif PlayerAgro.get(i[2]) == PlayerKind.get(i[2]):
						var dice_roll = randi_range(1,6)
						if dice_roll >= dice_goal_number: # +/- dependeds on personality
							PlayerKind[i[2]] += 30
						else:
							PlayerAgro[i[2]] += 30
func _data_analysis():
	var all_array = []
	var player_array:Array = player_group.player
	var enemy_array = enemy_group.enemies
	all_array.append_array(player_array)
	all_array.append_array(enemy_array)
	
	for i in BoardState.keys():
		BoardState.set(i,[])
		lowest_HP_player(player_array)
		lowest_ENG_player(player_array)
		lowest_ENG_enemy(enemy_array)
		lowest_HP_enemy(enemy_array)
		highest_ENG_player(player_array)
		highest_HP_player(player_array)
		strongest_player(player_array)
		strongest_magic_player(player_array)
		strongest_enemy(enemy_array)
		strongest_magic_enemy(enemy_array)
		closest_player(player_array)
		players_with_status_effect(player_array)
		weakest_player(player_array)
		weakest_magic_player(player_array)
	
	for i in BoardState.values():
		ObjectivlyWeakestPlayer[i[0]] = 0
		ObjectivlyStrongesPlayer[i[0]] = 0
	
	ObjectivlyWeakestPlayer[BoardState["lowest_HP_player"][0]] += 1 
	ObjectivlyWeakestPlayer[BoardState["lowest_ENG_player"][0]] += 1 
	ObjectivlyWeakestPlayer[BoardState["weakest_player"][0]] += 1 
	ObjectivlyWeakestPlayer[BoardState["weakest_magic_player"][0]] += 1 
	
	ObjectivlyStrongesPlayer[BoardState["strongest_player"][0]] += 1 
	ObjectivlyStrongesPlayer[BoardState["strongest_magic_player"][0]] += 1 
	ObjectivlyStrongesPlayer[BoardState["highest_ENG_player"][0]] += 1 
	ObjectivlyStrongesPlayer[BoardState["highest_HP_player"][0]] += 1 

#region dataAnalitics
var temp: Array = []
func lowest_HP_player(player):
	temp.clear()
	for i in player:
		temp.append([i,i.Fight_stats.HP])
	BoardState.set("lowest_HP_player",temp.min())

func lowest_ENG_player(player):
	temp.clear()
	for i in player:
		temp.append([i,i.Fight_stats.ENG])
		BoardState.set("lowest_ENG_player",temp.min())

func lowest_ENG_enemy(enemy):
	temp.clear()
	for i in enemy:
		temp.append([i,i.Fight_stats.ENG])
		BoardState.set("lowest_ENG_enemy",temp.min())

func lowest_HP_enemy(enemy):
	temp.clear()
	for i in enemy:
		temp.append([i,i.Fight_stats.HP])
		BoardState.set("lowest_HP_enemy",temp.min())

func highest_ENG_player(player):
	temp.clear()
	for i in player:
		temp.append([i,i.Fight_stats.ENG])
		BoardState.set("highest_ENG_player",temp.max())

func highest_HP_player(player):
	temp.clear()
	for i in player:
		temp.append([i,i.Fight_stats.HP])
		BoardState.set("highest_HP_player",temp.max())


func strongest_player(player):
	temp.clear()
	for i in player:
		temp.append([i,i.Fight_stats.Base_Phisical_Attack])
		BoardState.set("strongest_player",temp.max())

func strongest_magic_player(player):
	temp.clear()
	for i in player:
		temp.append([i,i.Fight_stats.Base_Magical_Attack])
		BoardState.set("strongest_magic_player",temp.max())

func strongest_enemy(enemy):
	temp.clear()
	for i in enemy:
		temp.append([i,i.Fight_stats.Base_Phisical_Attack])
		BoardState.set("strongest_enemy",temp.max())

func strongest_magic_enemy(enemy):
	temp.clear()
	for i in enemy:
		temp.append([i,i.Fight_stats.Base_Magical_Attack])
		BoardState.set("strongest_magic_enemy",temp.max())

func closest_player(player):
	temp.clear()
	
func players_with_status_effect(player):
	temp.clear()

func weakest_player(player):
	temp.clear()
	for i in player:
		temp.append([i,i.Fight_stats.Base_Phisical_Attack])
		BoardState.set("weakest_player",temp.min())

func weakest_magic_player(player):
	temp.clear()
	for i in player:
		temp.append([i,i.Fight_stats.Base_Magical_Attack])
		BoardState.set("weakest_magic_player",temp.min())

#endregion

#region personalityTypes
func Natural():
	pass
func Angry():
	pass
func Scared():
	pass
func Primal():
	pass
func Loyal():
	pass
func Random():
	pass
func Parasitic():
	pass
func Determined():
	pass
func Athletic():
	pass
func Strategic():
	pass
func Advanced():
	pass
func HigherBeing():
	pass
#endregion
