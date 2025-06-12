extends Node

# [1,"Player1",0,1-6,"ATTACK"]
# [3,"Enemy2",3,"HEAL","BAG"]
# [1,"Enemy1",2,1-6,"ATTACK"]
# [2,"Player2",1,"TALK","ACT"]


func _get_attack(data:Array):
	
	var final_attack = data[3]+(2-data[2])
	
	return [data[1], str(final_attack), data[4]]
	
