extends Node
class_name test_enemy_handler

func _test_choice(enemy_name,enemy_index):
	randomize()

	var random_num = randi_range(1,4)
	match random_num:
		1:
			return [random_num,enemy_name,enemy_index,randi_range(1,6),"ATTACK"]
		2:
			return [random_num,enemy_name,enemy_index,["TALK","FLIRT","PLAY AROUND","GROWL"].pick_random(),"ACT"]
		3:
			return [random_num,enemy_name,enemy_index,["HEAL","HURT"].pick_random(),"BAG"]
		4:
			return [random_num,enemy_name,enemy_index,"YOU RAN","RUN"]
			
