extends Node

func _get_act(data:Array):
	
	var result = str(randi_range(1,3)) + "/3"
	if result == "3/3":
		result = "Spareable"
	return [data[1], result, data[4]]
