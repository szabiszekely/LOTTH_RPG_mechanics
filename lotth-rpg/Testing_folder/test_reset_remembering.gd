extends Resource
class_name Reset_Rembering

"""
SO this is important, how this will work will make or break the game.
- Creatures Data, who got killed, who has what and not
- Players death, if someone dead, make it remember
- Save often, If a Character is on low, save! if a player is about to die, SAVE! 
If regreted your life choices, SAVE THE GOD DAMN GAME
- The game should have flags, event flags, these flags determine what dialouge, stage or place you are at, 
it determine if you ever killed or got an item, Saving and loading, should be easy and something that is easy to remove.
- There are 3 flag structures:
	- World Type Flags
	- Player Type Flags
	- Him Type Flags
World Type Flags:
	- Everything from Enemeies to the dialouge that player already, to cutscenes
	- It contains both Him Type flags and Player Type Flags for restoration
Player Type Flags:
	- This contains how big or small a soul is
	- Contains items, Player Specific endings, inventory data, Known abilities and everything else that is important TO THE PLAYER
	- It contains Him Type Flags for restoration
Him Type Flags:
	- Checks if the flag changes happens inside or outside of the game
	- If things change Him will reflect on it, calls out the player if changing any variable outside of the game
	- It contains both Player Type Flags and World Type Flags for restoration
- if at any point the player deletes an important file, then other files can restore those before the game launches

Basic Functions:
	- Shadow Saving and Loading
	- Flag modification
	- Other Flag Resource communication
"""


@export var World_type_flags: World_Type_Flags
@export var Him_type_flags: Him_Type_Flags
@export var Player_type_flags: Player_Type_Flags


var saveWorldDict: Dictionary = {}
var saveHimDict: Dictionary = {}
var savePlayerDict: Dictionary = {}

#region All
## ---ALL---

func shadowSaveFlagsAll()->void:
	shadowSaveFlagsWorld()
	shadowSaveFlagsHim()
	shadowSaveFlagsPlayer()

func shadowLoadFlagsAll()->void:
	shadowLoadFlagsWorld()
	shadowLoadFlagsHim()
	shadowLoadFlagsPlayer()

func readAllTypeFlags():
	print("Him: ")
	Him_type_flags.getTypeFlags()
	print("\nPlayer: ")
	Player_type_flags.getTypeFlags()
	print("\nWorld: ")	
	World_type_flags.getTypeFlags()
	print("\n")

func writeAllTypesToMemory(World:Dictionary,player:Dictionary,Him:Dictionary):
	Him_type_flags.loadTypeFlagsToMemory(player,World)
	Player_type_flags.loadTypeFlagsToMemory(Him)
	World_type_flags.loadTypeFlagsToMemory(player,Him)


#endregion
#region World
## ---World---
func shadowSaveFlagsWorld()->void:
	World_type_flags.saveWorldTypeFlags(saveWorldDict)

func shadowLoadFlagsWorld()->void:
	saveWorldDict = World_type_flags.loadWorldTypeFlags(saveWorldDict)

func modifyWorldTypeFlagAt(nameOfTheFlag: String, modification: int) -> void:
	World_type_flags.set(nameOfTheFlag,modification)
	shadowSaveFlagsAll()

func checkWorldTypeFlagAt(nameOfTheFlag: String, result: int) -> bool:
	return saveWorldDict[nameOfTheFlag] == result



func readWorldTypeFlags():
	World_type_flags.getTypeFlags()
#endregion
#region Him
## ---Him---
func shadowSaveFlagsHim()->void:
	Him_type_flags.saveHimTypeFlags(saveHimDict)

func shadowLoadFlagsHim()->void:
	Him_type_flags.loadHimTypeFlags(saveHimDict)

func modifyHimTypeFlagAt(nameOfTheFlag: String, modification: int) -> void:
	Him_type_flags.set(nameOfTheFlag,modification)
	shadowSaveFlagsAll()

func checkHimTypeFlagAt(nameOfTheFlag: String, result: int) -> bool:
	return saveHimDict[nameOfTheFlag] == result


func readHimTypeFlags():
	Him_type_flags.getTypeFlags()
#endregion
#region Player
## ---Player---
func shadowSaveFlagsPlayer()->void:
	Player_type_flags.savePlayerTypeFlags(savePlayerDict)

func shadowLoadFlagsPlayer()->void:
	Player_type_flags.loadPlayerTypeFlags(savePlayerDict)

func modifyPlayerTypeFlagAt(nameOfTheFlag: String, modification: int) -> void:
	Player_type_flags.set(nameOfTheFlag,modification)
	shadowSaveFlagsAll()

func checkPlayerTypeFlagAt(nameOfTheFlag: String, result: int) -> bool:
	return savePlayerDict[nameOfTheFlag] == result


func readPlayerTypeFlags():
	Player_type_flags.getTypeFlags()
#endregion
