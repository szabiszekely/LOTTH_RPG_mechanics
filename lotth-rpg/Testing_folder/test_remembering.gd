extends Node2D

@export var Reset_Remembering: Reset_Rembering

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button"):
		Reset_Remembering.shadowLoadFlagsAll()
		
		
		## Modify the flags
		Reset_Remembering.modifyWorldTypeFlagAt("flag2001",1)
		assert(Reset_Remembering.checkWorldTypeFlagAt("flag2001",1),"FAILED MODIFICATION")
		
		Reset_Remembering.modifyHimTypeFlagAt("flag0",1)
		assert(Reset_Remembering.checkHimTypeFlagAt("flag0",1),"FAILED MODIFICATION")

		Reset_Remembering.modifyPlayerTypeFlagAt("flag1001",1)
		assert(Reset_Remembering.checkPlayerTypeFlagAt("flag1001",1),"FAILED MODIFICATION")
		## Read the flags
		Reset_Remembering.readAllTypeFlags()

	if event.is_action_pressed("debug_button_2"):
		DirAccess.remove_absolute(Reset_Remembering.World_type_flags.WORLD_FLAG_SAVE_FILE)
		DirAccess.remove_absolute(Reset_Remembering.Him_type_flags.HIM_FLAG_SAVE_FILE)
		DirAccess.remove_absolute(Reset_Remembering.Player_type_flags.PLAYER_FLAG_SAVE_FILE)
	if event.is_action_pressed("debug_button_3"):
		print(Reset_Remembering.saveHimDict)
		print(Reset_Remembering.savePlayerDict)
		print(Reset_Remembering.saveWorldDict)
		Reset_Remembering.writeAllTypesToMemory(Reset_Remembering.saveWorldDict,Reset_Remembering.savePlayerDict,Reset_Remembering.saveHimDict)
		Reset_Remembering.readAllTypeFlags()
