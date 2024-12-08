class_name Fighting_Stats
extends Resource

# This hat handles the players and enemies stats! and taking damage and the dice roll at the start!
@export var name: String
@export var Id: int = -1
@export_enum("Friend","Enemy") var Friend_or_Foe
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
@export var range_in_cm: float

func _Damage_Taken(Attacker_Base_Damage:int,Attacker_Strengh:int,Self_Defense:int,Self_ATK_type:int,Attacker_ATK_type:int):
	#the bonus damage value
	var Damage_Type = 0
	# if they have the same number than nothing happens 0 bonus!
	if Self_ATK_type == Attacker_ATK_type:
		Damage_Type = 0
	# if the damage dealer has a bigger number OR the own type is 2 and the dealer is 0 than the attack dealer gets +1 damage!
	elif Self_ATK_type < Attacker_ATK_type or Self_ATK_type == 2 and Attacker_ATK_type == 0:
		Damage_Type = 1
	# however if this the self type is higher than the dealers attack will be down by 1
	elif Self_ATK_type > Attacker_ATK_type or Self_ATK_type == 0 and Attacker_ATK_type == 2: 
		Damage_Type = -1
	
	# the formula for the Total_damage!
	var Total_damage =  Attacker_Base_Damage + (Attacker_Strengh - Self_Defense + (Damage_Type))
	# and if the total_damage is smaller than 0 than we round it up to 1 so you don't deal negative or 0 damage! 
	if Total_damage <= 0:
		Total_damage = 1
		
	return Total_damage

func _True_Damage_Taken(Attacker_Base_Damage: int):
	
	
	var Total_damage = Attacker_Base_Damage 
	return Total_damage

# you throw a 1-6 dice and this will be you starting position!
func _Initiative():
	randomize()
	var dice = randi_range(1,6)
	return dice
