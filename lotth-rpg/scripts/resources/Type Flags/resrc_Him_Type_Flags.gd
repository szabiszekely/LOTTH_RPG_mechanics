extends TypeFlagRoot
class_name Him_Type_Flags

"""
Contains both flags and event functions for every Him Type resource.
These include but not limited to:
	- Remembering your past actions
	- Can restore any World or Player missing data
	- If changes happen outside of the game, it remembers the manipulation
	- Will be restored from both World and Players data.
"""

const  HIM_FLAG_SAVE_FILE = "user://him_flag.dat"

## Him Type Flags
var flag0: int = 0 ## How many times you opened the game

## Player Restorations
var RestorePlayer: Dictionary

## World Restorations
var RestoreWorld: Dictionary


func saveHimTypeFlags(saveHimDict: Dictionary): ## Save the Flags
	for i in _get_script_property():
		var propertyName: String = i.name
		var propertyValue = get(propertyName)
		if propertyName not in ["TypeFlagRoot.gd","resrc_Him_Type_Flags.gd"]:
			saveHimDict[propertyName] = propertyValue
	var file = FileAccess.open(HIM_FLAG_SAVE_FILE,FileAccess.WRITE)
	file.store_var(saveHimDict)
	file = null

func loadHimTypeFlags(saveHimDict: Dictionary): ## Load the flags
	if not FileAccess.file_exists(HIM_FLAG_SAVE_FILE):
		saveHimTypeFlags(saveHimDict)
	var file = FileAccess.open(HIM_FLAG_SAVE_FILE,FileAccess.READ)
	saveHimDict = file.get_var()
	return saveHimDict
	
func loadTypeFlagsToMemory(RestoredPlayer:Dictionary,RestoredWorld:Dictionary)->void:
	RestoreWorld = RestoredWorld
	RestoredPlayer = RestoredPlayer

func getTypeFlagsFromMemory(indx: int)->Dictionary:
	match indx:
		0:
			return RestorePlayer
		1:
			return RestoreWorld
	return RestorePlayer
