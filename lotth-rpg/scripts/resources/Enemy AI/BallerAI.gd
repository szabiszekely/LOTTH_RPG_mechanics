extends SetupEnemyAI
class_name BallerAI

var before_enemy_turn = []
var self_e

func _EnemyAI(self_enemy):
	self_e = self_enemy
	before_enemy_turn = []
	_sort_before_self()
	_same_type_enemy()
	_get_actions()
	print(before_enemy_turn)
	#if before_enemy_turn[0][0] == "atk":
	var choose_ability = ["Baller Attack","Ball Crawl"].pick_random()
	var choose_random_player = 0#andi_range(0,initiative.group_player.player.size() - 1)
	enemy_group.all_e_action.push_back(["atk",choose_ability,choose_random_player,3,initiative.group_enemies.e_index,player_group.player[choose_random_player],self_enemy])
	#else:
		#["act"  i.text  self  0  enemy.enemies[enemy.e_index]  player.player[player.p_index]]
		#enemy_group.all_e_action.push_back(["act","Grab",self_e,0,self_e,self_enemy])
		#pass
# gets everything before the enemy
func _sort_before_self():
	for i in initiative.all_rolls: 
		if i[-1] != self_e:
			before_enemy_turn.append(i)
		else:
			break
# this one removes all enemies and only leave Players if their are any
func _same_type_enemy():
	for i in before_enemy_turn:
		for j in initiative.sorted_enemies:
			if i[-1] == j:
				before_enemy_turn.erase(i)

# get the players switched out with their actions
func _get_actions():
	var temp = []
	for i in enemy_group.p_actions:
		for j in before_enemy_turn:
			if i[-1] == j[-1]:
				temp.append(i)
	before_enemy_turn.clear()
	for i in temp: 
		before_enemy_turn.append(i)
