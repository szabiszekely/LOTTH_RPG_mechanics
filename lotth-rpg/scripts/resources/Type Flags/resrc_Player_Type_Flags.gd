extends TypeFlagRoot
class_name Player_Type_Flags

"""
Contains both flags and event functions for every Player Type resource.
These include but not limited to:
	- How much soul does the player have currently
	- Contains items, Player Specific endings, inventory data, Known abilities and everything else that is important TO THE PLAYER
	- It contains Him Type Flags for restoration
"""

const  PLAYER_FLAG_SAVE_FILE = "user://player_flag.dat"

## Player Type Flags
var flag1001: int = 0
 
## Him Restorations
var RestoreHim: Dictionary

func savePlayerTypeFlags(savePlayerDict: Dictionary): ## Save the Flags
	for i in _get_script_property():
		var propertyName: String = i.name
		var propertyValue = get(propertyName)
		if propertyName not in ["TypeFlagRoot.gd","resrc_Player_Type_Flags.gd"]:
			savePlayerDict[propertyName] = propertyValue
	var file = FileAccess.open(PLAYER_FLAG_SAVE_FILE,FileAccess.WRITE)
	file.store_var(savePlayerDict)
	file = null

func loadPlayerTypeFlags(savePlayerDict: Dictionary): ## Load the flags
	if not FileAccess.file_exists(PLAYER_FLAG_SAVE_FILE):
		savePlayerTypeFlags(savePlayerDict)
	var file = FileAccess.open(PLAYER_FLAG_SAVE_FILE,FileAccess.READ)
	savePlayerDict = file.get_var()
	return savePlayerDict

func loadTypeFlagsToMemory(RestoredHim:Dictionary,_NeverUsed: String = "Babeta :D")->void:
	RestoredHim = RestoredHim

func getTypeFlagsFromMemory(_indx: int)->Dictionary:
	return RestoreHim
