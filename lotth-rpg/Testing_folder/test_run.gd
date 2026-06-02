extends Node
@export var _test_Stat_boost: Stat_Increases

@export var Defense: int ##Every Defense is -1 from a Phisical attack
@export var Magic_Defense: int ##Every Magic Defense is -1 from Magical attack
@export var Base_Phisical_Attack: int 
@export var Base_Magical_Attack: int
@export var Speed: int ##Every start of a round it will roll a D6 and adds it to the speed, the larger the better
var Temp_Def = 0
var Temp_M_Def = 0
var Temp_BP_A = 0
var Temp_BM_A = 0
var Temp_Sped = 0

var header = []
var database = []
func _ready() -> void:
	_test_Stat_boost._Get_Current_Stats(header)
	_Database_append(_test_Stat_boost._Stat_change("Turn",1,{1:["Def",1,false]}))
	_Database_append(_test_Stat_boost._Stat_change("Turn",2,{1:["Def",1,true]}))
	_Database_append(_test_Stat_boost._Stat_change("Turn",1,{1:["Def",1,true]}))
	_Database_append(_test_Stat_boost._Stat_change("Turn",3,{1:["Def",2,true],2:["BP_Attack",2,false]}))
	_Database_append(_test_Stat_boost._Stat_change("Turn",1,{1:["Speed",1,true],2:["M_Def",1,true],3:["BP_Attack",3,false]}))

	_Database_append(_test_Stat_boost._Stat_change("Turn",1,{1:["Def",1,true]}))
	_Database_append(_test_Stat_boost._Stat_change("ROB",1,{1:["BP_Attack",2,true]}))
	_Database_append(_test_Stat_boost._Stat_change("Turn",5,{1:["BM_Attack",1,true]}))
	_Database_append(_test_Stat_boost._Stat_change("Turn",3,{1:["M_Def",2,true],2:["Def",1,false]}))
	_Database_append(_test_Stat_boost._Stat_change("ROB",0,{1:["Speed",1,true],2:["M_Def",1,true],3:["BP_Attack",1,false]}))

	_Apply_Stats()
	#print(database, header)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_button"):
		var temp_remover = []
		for i in database:
			i[-1] = i[-1] - 1
			if i[-1] == 0:
				temp_remover.append(i)
		for i in temp_remover:
			database.erase(i)
		print(database)
		_Apply_Stats()

func _Database_append(What_to_add):
	database.append(What_to_add)
	header.append(What_to_add[0])


func _Apply_Stats():
	Temp_Def = 0
	Temp_M_Def = 0
	Temp_BP_A = 0
	Temp_BM_A = 0
	Temp_Sped = 0
	for i in database:
		Temp_Def += Defense + i[1][0]
		Temp_M_Def += Magic_Defense + i[1][1]
		Temp_BP_A += Base_Phisical_Attack + i[1][2]
		Temp_BM_A += Base_Magical_Attack + i[1][3]
		Temp_Sped += Speed + i[1][4]
	
	print("DEF ",Temp_Def)
	print("M_DEF ",Temp_M_Def)
	print("BASE_PHISICAL_ATTACK ",Temp_BP_A)
	print("BASE_MAGICAL_ATTACK ",Temp_BM_A)
	print("SPEED ",Temp_Sped)
