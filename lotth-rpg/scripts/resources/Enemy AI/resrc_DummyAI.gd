extends SetupEnemyAI
class_name DummyAI

func _EnemyAI(deck):
	randomize()
	# I gather data on a varity stuff (like lowest player, strongest player, weakest enemy, closest player, ect)
	_data_analysis()
	# I set up everything else to default position 
	before_enemy_turn = []
	before_enemy_turn_player = []
	player_actions = []
	# this 3 is for to sort out the player and the enemeies from eachother
	_sort_before_self(enemy_it_self)
	_same_type_enemy(enemy_it_self)
	_get_actions_player(enemy_it_self)
	# I give every card a score which help the AI decide which card to use
	_attack_card_scoring()

	enemy_group.all_e_action.push_back(["atk",0,enemy_it_self,target,deck[0]])
