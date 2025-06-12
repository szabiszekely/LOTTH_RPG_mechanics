extends Node

func _get_bag(data:Array):
	
	var item = data[3]
	if item == "HURT":
		item = randi_range(1,4)+(2-data[2])
	else:
		item = "+" + str(randi_range(1,3)) + " HP" 

	return [data[1], str(item), data[4]]
