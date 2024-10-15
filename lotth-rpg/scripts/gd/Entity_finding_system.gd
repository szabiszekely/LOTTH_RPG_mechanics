extends Resource
class_name Entity_finder

@export var The_entire_list_of_all_that_is_alive: Array = []
@export var dictionary_of_all_that_is_alive: Array = []

# A very simple class that is just here so it basicaly makes a dictionary to an enemy name and when that name is the same...
# it get all in a list and than it will be applied to action options!
func _finding_entity(name_of_entity):
	var find = The_entire_list_of_all_that_is_alive.find(name_of_entity)
	var result = dictionary_of_all_that_is_alive[find]
	return result.values()
