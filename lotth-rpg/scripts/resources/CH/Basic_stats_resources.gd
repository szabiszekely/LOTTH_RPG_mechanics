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
@export var PlayerDeck: Deck_builder
@export var Defense: int
@export var Magic_Defense: int
@export var MAX_EMP: int
@export var EMP: int

@export var Base_Phisical_Attack: int
@export var Base_Magical_Attack: int
@export var Speed: int
@export var range_in_cm: float

func _Damage_Taken(Attacker_Base_Phisical_Strengh:int,Attacker_Card_Strengh:int,Reciver_Defense:int,Reciver_ATK_type:int,Attacker_ATK_type:int,Card_Type:int,Attacker_Base_Magic_Strengh:int,Reciver_Magic_Defense:int):
	#the bonus damage value
	var Damage_Type = 0
	var Damage_bonus = 0
	# if they have the same number than nothing happens 0 bonus!
	if Reciver_ATK_type == Card_Type:
		Damage_Type = 0
		print("no advan")
	# if the damage dealer has a bigger number OR the own type is 2 and the dealer is 0 than the attack dealer gets +1 damage!
	elif Reciver_ATK_type < Card_Type or Reciver_ATK_type == 2 and Card_Type == 0:
		Damage_Type = 1
		print("advantage")
	# however if this the self type is higher than the dealers attack will be down by 1
	elif Reciver_ATK_type > Card_Type or Reciver_ATK_type == 0 and Card_Type == 2: 
		Damage_Type = -1
		print("bad advantage")
	
	if Card_Type == Attacker_ATK_type:
		Damage_bonus = 1
	else:
		Damage_bonus = -1
	
	# Card: 6 dmg + (Player Dmg: 3 - Enemy Def: 2 + (Attacker Damage Bonuse: 0))
	# 6 + (1(0) = 7
	# the formula for the Total_damage!
	var Total_damage
	if Card_Type == 2:
		print("hello World")
		Total_damage =  Attacker_Base_Magic_Strengh + (Attacker_Card_Strengh - Reciver_Magic_Defense + (Damage_Type)+(Damage_bonus))
	else:
		Total_damage =  Attacker_Base_Phisical_Strengh + (Attacker_Card_Strengh - Reciver_Defense + (Damage_Type)+(Damage_bonus))
	# and if the total_damage is smaller than 0 than we round it up to 1 so you don't deal negative or 0 damage! 
	if Total_damage <= 0:
		Total_damage = 1
		
	return Total_damage

func _True_Damage_Taken(Attacker_Base_Phisical_Strengh: int):
	
	
	var Total_damage = Attacker_Base_Phisical_Strengh 
	return Total_damage

# you throw a 1-6 dice and this will be you starting position!
func _Initiative():
	randomize()
	var dice = randi_range(1,6)
	return dice
