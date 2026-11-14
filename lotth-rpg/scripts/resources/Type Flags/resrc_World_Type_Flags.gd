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

## Who is Alive?
"""
"Name": [Alive?]

Alive? 0: Yes; 1: No
"""
var Beastiery: Dictionary = {}


func saveWorldTypeFlags(saveWorldDict: Dictionary): ## Save the Flags
	for i in _get_script_property(): ## Check for all the values
		var propertyName: String = i.name ## Name of the value
		var propertyValue = get(propertyName) ## The actual Value
		if propertyName not in ["TypeFlagRoot.gd","resrc_World_Type_Flags.gd"]:
			saveWorldDict[propertyName] = propertyValue
	var file = FileAccess.open(WORLD_FLAG_SAVE_FILE,FileAccess.WRITE)
	file.store_var(saveWorldDict)
	file = null

func loadWorldTypeFlags(saveWorldDict: Dictionary): ## Load the flags
	if not FileAccess.file_exists(WORLD_FLAG_SAVE_FILE):
		saveWorldTypeFlags(saveWorldDict)
	var file = FileAccess.open(WORLD_FLAG_SAVE_FILE,FileAccess.READ)
	saveWorldDict = file.get_var()
	for i in saveWorldDict:
		if i not in ["TypeFlagRoot.gd","resrc_World_Type_Flags.gd"]:
			for j in _get_script_property():
				#print(j)
				if j.name == i:
					set(j.name,saveWorldDict[i])
	#print(getTypeFlags())
	return saveWorldDict

## THIS ONE IS UNFINISHED! IN THE FUTURE FINISH IT
"""
This is confusing even to my now self
I want to get rid of the Restore bit and store the other values inside
the Dict, to the memory RestoreHim and RestorePlayer
for the Temp dict, I have no clue you might as well delete it.
"""
func loadTypeFlagsToMemory(RestoredPlayer:Dictionary,RestoredHim:Dictionary)->void:
	var temp: Dictionary = {}
	RestoredPlayer.erase("RestoreHim")
	RestoredHim.erase("RestoreWorld")
	RestoredHim.erase("RestorePlayer")
	RestoreHim = RestoredHim
	RestorePlayer = RestoredPlayer

func getTypeFlagsFromMemory(indx: int)->Dictionary:
	match indx:
		0:
			return RestorePlayer
		1:
			return RestoreHim
	return RestorePlayer
	
func updateBeastiery(withWhat, isItAlive: int):
	Beastiery[withWhat] = isItAlive

func isInBeastiery(withWhat):
	return Beastiery.has(withWhat)

func getValueBeastiery(withWhat):
	return Beastiery[withWhat]

# when focused there is a chance you get an item
# enemies strength + speed vs the players focus stat
func event_focus():
	pass
