extends Node
class_name test_play_out

@export var test_order: Test_order

func _play_out(all_actions):
	var play_out_action = []
	for i in test_order.all_people:
		for j in all_actions:
			if i == j[2]:
				play_out_action.append(j)
	
	for i in play_out_action:
		print(i)
		await get_tree().create_timer(1).timeout

	test_order.not_started = false
	test_order._reset()
