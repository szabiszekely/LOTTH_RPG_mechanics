extends TypeFlagRoot
class_name World_Type_Flags

"""
Contains both flags and event functions for every World Type resource.
These include but not limited to:
	- Enemies (Gone or Alive)
	- Cutscene flags
	- Dialouge check flags
	- Special case Evennt's
"""

const  WORLD_FLAG_SAVE_FILE = "user://world_flag.dat"

## World Type Flags
var flag2001: int = 0 ## UNUSED

## Player Restorations
var RestorePlayer: Dictionary

## Him Restorations
var RestoreHim: Dictionary

## Enemies Alive?
"""
"Name": [Alive?]
"""
var EnemyBeastiery: Dictionary = {
	"Poshanko": 0, ## Baller 1
	"Bertece": 0, ## Baller 2
	"Neo Bombi": 0, ## Baler 3
	"Hurutka": 0, ## Baller 4
}

## Player Alive?
"""
"Name": [Alive?]

Alive? 0: Yes; 1: No
"""
var PlayerBeastiery: Dictionary = {
	"Alex":0,
	"Myna":0,
	"Huba":0,
	"Levi":0
}


func saveWorldTypeFlags(saveWorldDict: Dictionary): ## Save the Flags
	for i in _get_script_property(): ## Check for all the values
		var propertyName: String = i.name ## Name of the value
		var propertyValue = get(propertyName) ## The actual Value
		if propertyName != "resrc_World_Type_Flags.gd":
			saveWorldDict[propertyName] = propertyValue
	var file = FileAccess.open(WORLD_FLAG_SAVE_FILE,FileAccess.WRITE)
	file.store_var(saveWorldDict)
	file = null

func loadWorldTypeFlags(saveWorldDict: Dictionary): ## Load the flags
	if not FileAccess.file_exists(WORLD_FLAG_SAVE_FILE):
		saveWorldTypeFlags(saveWorldDict)
	var file = FileAccess.open(WORLD_FLAG_SAVE_FILE,FileAccess.READ)
	saveWorldDict = file.get_var()
	return saveWorldDict
	


# when focused there is a chance you get an item
# enemies strength + speed vs the players focus stat
func event_focus():
	pass
