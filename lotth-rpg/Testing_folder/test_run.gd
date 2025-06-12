extends Node

@onready var node_branch: test_Node_Branch = $"../../Node_Branch"


func _get_run(data:Array):
	
	var ran
	if randi_range(1,6) <= 2:
		ran = "FAILED"
	else:
		ran = "YOU RAN"
		
	print(node_branch.current_players)
	return [data[1], ran, data[4]]
