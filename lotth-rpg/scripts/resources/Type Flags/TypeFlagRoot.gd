extends Resource
class_name TypeFlagRoot


"""
Root Script
"""


func _get_script_property(): ## Get all variables
	return get_script().get_script_property_list()

func getTypeFlags():
	for i in _get_script_property():
		var propertyName: String = i.name
		var propertyValue = get(propertyName)
		if propertyName not in ["resrc_World_Type_Flags.gd","TypeFlagRoot.gd","resrc_Player_Type_Flags.gd","resrc_Him_Type_Flags.gd"]:
			print(propertyName," ",propertyValue)

func loadOtherTypeFlagsToMemory():
	pass
