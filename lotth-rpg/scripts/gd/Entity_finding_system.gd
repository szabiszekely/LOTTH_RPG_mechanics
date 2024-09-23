extends Resource
class_name Entity_finder

@export var The_entire_list_of_all_that_is_alive: Array = []
@export var dictionary_of_all_that_is_alive: Array = []


func _finding_entity(name_of_entity):
	var find = The_entire_list_of_all_that_is_alive.find(name_of_entity)
	var result = dictionary_of_all_that_is_alive[find]
	return result.values()
