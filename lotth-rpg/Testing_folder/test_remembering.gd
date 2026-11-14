extends Node2D

@export var var_Reset_Remembering: Reset_Remembering

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button"):
		var_Reset_Remembering.shadowLoadFlagsAll()
		
		
		## Modify the flags
		var_Reset_Remembering.modifyWorldTypeFlagAt("flag2001",1)
		assert(var_Reset_Remembering.checkWorldTypeFlagAt("flag2001",1),"FAILED MODIFICATION")
		
		var_Reset_Remembering.modifyHimTypeFlagAt("flag0",1)
		assert(var_Reset_Remembering.checkHimTypeFlagAt("flag0",1),"FAILED MODIFICATION")

		var_Reset_Remembering.modifyPlayerTypeFlagAt("flag1001",1)
		assert(var_Reset_Remembering.checkPlayerTypeFlagAt("flag1001",1),"FAILED MODIFICATION")
		## Read the flags
		var_Reset_Remembering.readAllTypeFlags()

	if event.is_action_pressed("debug_button_2"):
		pass
	if event.is_action_pressed("debug_button_3"):
		var_Reset_Remembering.shadowLoadFlagsWorld()
		#print(var_Reset_Remembering.saveHimDict)
#		print(var_Reset_Remembering.savePlayerDict)
#		print(var_Reset_Remembering.saveWorldDict)
		#var_Reset_Remembering.writeAllTypesToMemory(var_Reset_Remembering.saveWorldDict,var_Reset_Remembering.savePlayerDict,var_Reset_Remembering.saveHimDict)
		#var_Reset_Remembering.readAllTypeFlags()
