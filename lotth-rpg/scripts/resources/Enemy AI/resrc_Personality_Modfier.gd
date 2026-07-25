extends Resource
class_name PersonalityModfier

var battle_scene
var enemy_group
var player_group
var initiative
var enemy_it_self





# THIS ONE IS THE OLD ONE DUMBY!!!!
# DON'T EDIT THIS BUT INSTEAD DELETE IT AS SOON AS POSSIBLE
# PLEASE DON'T FOOL YOURSELF PLEASE









#------Personality Modifiers-------
@export var angy_personality_bonus: int = 0
@export var dice_goal_number: int = 4
@export var personality_decrease_modifier: float = 1


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
	"strongest_enemy":[],
	"strongest_magic_enemy":[],
	"closest_player":[],
	"players_with_status_effect":[]
}

var PlayerAgro: Dictionary = {}
var PlayerKind: Dictionary = {}

func _setup_per_mod(enemies,players,Initiative_script,BattleScene):
	enemy_group = enemies
	player_group = players
	initiative = Initiative_script
	battle_scene = BattleScene


func _Player_Point_System():
	for i in player_group.player:
		PlayerAgro.set(i,0)
		PlayerKind.set(i,0)

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

func _player_actions():
	for i in enemy_group.p_actions:
		var current_player_agro = PlayerAgro.get(i[2])
		var current_player_kind = PlayerKind.get(i[2])
		match i[0]:
			"atk":
				# if DMG to this enemy
				# add DMG to ANGY points
				# add points based on personality
				# else add either PEAC points or add a flat ANGY point number
				if i[3] == enemy_it_self:
					var damage = Data.get_card_damage(i[4])
					if damage != 0:
						PlayerAgro.set(i[2],current_player_agro + 2 + damage + angy_personality_bonus) # + personality
					else:
						var dice_roll = randi_range(1,6)
						if dice_roll >= dice_goal_number: # +/- dependeds on personality
							PlayerKind.set(i[2],current_player_kind + 1)
						else:
							PlayerAgro.set(i[2],current_player_agro + 1)
			"act":
				# if trying to be kind
				# add a base number to PEAC points plus depending on personality add a bonus and reduce ANGY points by half (int)
				# else do nothing with points and just add a flat PEAC point to number
				if i[3] == enemy_it_self:
					if i[4] not in ["Check","Focus","Guard"]:
						PlayerKind.set(i[2],current_player_kind + 2)
						current_player_agro = int(current_player_agro / personality_decrease_modifier)#divided by personality modifier
						PlayerAgro.set(i[2],current_player_agro)
					else:
						PlayerKind.set(i[2],current_player_kind + 1)
			"bag":
				# depending on the ANGY or PEAC point stat 
				# if ANGY is higher than make that number bigger
				# if PEAC is higher than make ANGY get reduced by 2
				if i[3] == enemy_it_self:
					var damage = Data.get_item_damage(i[4])
					if damage != 0:
						PlayerAgro.set(i[2],current_player_agro + 2 + damage + angy_personality_bonus) # + personality
					
					elif current_player_agro > current_player_kind:
						PlayerAgro.set(i[2],current_player_agro + 2)
						current_player_kind = int(current_player_kind / personality_decrease_modifier)#divided by personality modifier
						PlayerKind.set(i[2],current_player_kind)
					
					elif current_player_kind > current_player_agro:
						PlayerKind.set(i[2],current_player_kind + 2)
						current_player_agro = int(current_player_agro / personality_decrease_modifier)#divided by personality modifier
						PlayerAgro.set(i[2],current_player_agro)
					
					elif current_player_agro == current_player_kind:
						var dice_roll = randi_range(1,6)
						if dice_roll >= dice_goal_number: # +/- dependeds on personality
							PlayerKind.set(i[2],current_player_kind + 3)
						else:
							PlayerAgro.set(i[2],current_player_agro + 3)
			"TEST":
				if i[3] == enemy_it_self:
					PlayerAgro.set(i[2],current_player_agro + 2)

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
	
#endregion

#region personalityTypes
func Natural():
	pass

func Angry():
	print(enemy_it_self,"-------\n",PlayerAgro,"-------\n",PlayerKind,"-------\n")

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
