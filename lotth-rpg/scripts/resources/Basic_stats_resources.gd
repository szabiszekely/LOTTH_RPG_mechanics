class_name Fighting_Stats
extends Resource

@export var name: String
@export var MAX_HP: int
@export var MAX_ENG: int
@export var HP: int
@export var ENG: int
@export_enum("Normal","Player","Feeling","Dream","Memory","Justice") var Soul_Type: int
@export_enum("Melee","Range","Magic") var Attack_Type: int

@export var Defense: int
@export var Magic_Defense: int
@export var MAX_EMP: int
@export var EMP: int

@export var Base_Phisical_Attack: int
@export var Base_Magical_Attack: int
@export var Speed: int
@export var range_in_cm: int

func _Damage_Taken(Self_HP:int,Self_ENG:int,Attacker_Base_Damage:int,Attacker_Strengh:int,Self_Defense:int,Self_ATK_type:int,Attacker_ATK_type:int):
	var Damage_Type = 0
	if Self_ATK_type == Attacker_ATK_type:
		Damage_Type = 0
	elif Self_ATK_type < Attacker_ATK_type or Self_ATK_type == 2 and Attacker_ATK_type == 0:
		Damage_Type = 1
	elif Self_ATK_type > Attacker_ATK_type or Self_ATK_type == 0 and Attacker_ATK_type == 2: 
		Damage_Type = -1
		
	var Total_damage =  Attacker_Base_Damage + (Attacker_Strengh - Self_Defense + (Damage_Type))
	
	if Total_damage <= 0:
		Total_damage = 1
		
	return Total_damage
