extends SetupEnemyAI
class_name BallerAI


func _EnemyAI(self_enemy):
	var choose_ability = ["Baller Attack","Ball Crawl"].pick_random()
	var choose_random_player = randi_range(0,initiative.group_player.player.size() - 1)
	before_enemy_turn = []
	before_enemy_turn_player = []
	player_actions = []
	_sort_before_self(self_enemy)
	_same_type_enemy(self_enemy)
	_get_actions_player(self_enemy)
	print("player: ",before_enemy_turn)
	if before_enemy_turn_player != []:
		if before_enemy_turn_player[0][0] == "atk":
			choose_ability = "Baller Attack"
			choose_random_player = before_enemy_turn_player[0][2]
			enemy_group.all_e_action.push_back(["atk",0,self_enemy,choose_random_player,choose_ability])
			print("ATTACK GOT ATTACK BY: ", self_enemy)
		else:
			enemy_group.all_e_action.push_back(["act",0,self_enemy,self_enemy,"Grab",act_panel_choice])
	else:
		enemy_group.all_e_action.push_back(["atk",0,self_enemy,initiative.sorted_player[choose_random_player],choose_ability])
		
