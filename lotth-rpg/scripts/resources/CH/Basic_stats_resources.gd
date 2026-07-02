class_name Fighting_Stats
extends Resource

# This hat handles the players and enemies stats, also take cares of dice rolls and damage taken
@export var name: String ##Name of the Character
@export var Id: int = -1 ##ID of the Enemy
@export_enum("Friend","Enemy") var Friend_or_Foe ##Determines that which side of the character is on
@export var MAX_HP: int ##Adjustable Max HP
@export var MAX_ENG: int ##Adjustable Max ENG
@export var HP: int ##Determines how much HP does the character currently has
@export var ENG: int ##Determines how much ENG does the character currently has
@export_enum("Normal","Player","Feeling","Dream","Memory","Justice") var Soul_Type: int ##Categorized Soul types!
@export_enum("Melee","Range","Magic") var Attack_Type: int ##Categorized First Attack types
@export_enum("Natural","Angry","Scared","Primal","Loyal","Random","Parasitic","Determined","Athletic","Strategic","Advanced","HigherBeing") var Enemy_AI_type: String = "Normal" ##Tells the enemy how to handle data from the players and helps to determen the best move
@export var PlayerDeck: Deck_builder ##Custmozieable deck
@export var Defense: int ##Every Defense is -1 from a Phisical attack
@export var Magic_Defense: int ##Every Magic Defense is -1 from Magical attack
@export var MAX_EMP: int ##Determines how much Emphaty an enemy needs before spareable
@export var EMP: int ##Current adjusting Emphaty
#@export var Skadoodle: int = 0 ##The ability to steal items
@export var Focus: int = 0 ##The ability to focus on an someone
#@export var Persuade: int = 0 #The ablitiy to talk down someone from fighting
@export var Base_Phisical_Attack: int 
@export var Base_Magical_Attack: int
@export var Speed: int ##Every start of a round it will roll a D6 and adds it to the speed, the larger the better
@export var range_in_cm: float ##The distance a character can move

@export var STAT_Resource: Stat_Increases = load("res://scripts/resources/CH/Basic_Stat_Handler.tres")

var Stat_Boosts: Array = []
var Header_Array: Array = []
var Temp_Def = Defense
var Temp_M_Def = Magic_Defense
var Temp_BP_A = Base_Phisical_Attack
var Temp_BM_A = Base_Magical_Attack
var Temp_Sped = Speed
var In_Defense: bool = false

func _Damage_Taken(Source:Fighting_Stats,Target:Fighting_Stats,Attacker_Card_Strengh:int, Card_Type:int)->int:
	if Stat_Boosts == []:
		Target.Temp_Def = Target.Defense
		Target.Temp_M_Def = Target.Magic_Defense
		Source.Temp_BP_A = Source.Base_Phisical_Attack
		Source.Temp_BM_A = Source.Base_Magical_Attack
		

	var Attacker_Base_Phisical_Strengh:int = Source.Temp_BP_A
	var Attacker_Base_Magic_Strengh:int = Source.Temp_BM_A
	var Attacker_ATK_type:int = Source.Attack_Type
	var Reciver_Defense:int = Target.Temp_Def
	var Reciver_Magic_Defense:int = Target.Temp_M_Def
	var Reciver_ATK_type:int = Target.Attack_Type
	
	#the damage type and the bonus damage values
	var Damage_Type = 0
	var Damage_bonus = 0
	# if they have the same number than nothing happens 0 type bonus!
	if Reciver_ATK_type == Card_Type:
		Damage_Type = 0
		#print("no advan")
	# if the attacker has a type advantage than get an attack buff
	# aka if the damage dealer has a bigger number OR the own type is 2 and the dealer is 0 than the attack dealer gets +1 damage!
	elif Reciver_ATK_type == 0 and Card_Type == 1 or Reciver_ATK_type == 1 and Card_Type == 2 or Reciver_ATK_type == 2 and Card_Type == 0:
		Damage_Type = 1
		#print("advantage")
	
	# however if this the self type is higher than the dealers attack will be down by 1
	elif Reciver_ATK_type == 1 and Card_Type == 0 or Reciver_ATK_type == 2 and Card_Type == 1 or Reciver_ATK_type == 0 and Card_Type == 2: 
		Damage_Type = -1
		#print("bad advantage")
	
	if Card_Type == Attacker_ATK_type:
		Damage_bonus = 1
	else:
		Damage_bonus = -1
	
	# Card: 6 dmg + (Player Dmg: 3 - Enemy Def: 2 + (Attacker Damage Type Bonuse: 0) + (Attacker Stab Bonus: 0))
	# 6 + (1(0) = 7
	# the formula for the Total_damage!
	var Total_damage
	if Card_Type == 2: # Magic
		Total_damage =  Attacker_Base_Magic_Strengh + (Attacker_Card_Strengh - Reciver_Magic_Defense + (Damage_Type)+(Damage_bonus))
	else:
		Total_damage =  Attacker_Base_Phisical_Strengh + (Attacker_Card_Strengh - Reciver_Defense + (Damage_Type)+(Damage_bonus))
	# and if the total_damage is smaller than 0 than we round it up to 1 so you don't deal negative or 0 damage! 
	if Total_damage <= 0 and !In_Defense:
		Total_damage = 1
	elif Total_damage <= 0 and In_Defense:
		Total_damage = 0
	return Total_damage

## This attack only does flat damage
func _True_Damage_Taken(Attacker_Base_Phisical_Strengh: int)->int:
	var Total_damage = Attacker_Base_Phisical_Strengh 
	return Total_damage

## you throw a 1-6 dice and this will be you starting position!
func _Initiative()->int:
	randomize()
	var dice = randi_range(1,6)
	return dice

func _Get_Header_IDs()->Array:
	var stored_ids = []
	for i in Stat_Boosts:
		stored_ids.append(i[0]) 
	return stored_ids

func _Database_append(What_to_add):
	Stat_Boosts.append(What_to_add)
	Header_Array.append(What_to_add[0])


func _Apply_Stats(): ## Hello
	Temp_Def = 0
	Temp_M_Def = 0
	Temp_BP_A = 0
	Temp_BM_A = 0
	Temp_Sped = 0
	var Sum_Def = 0
	var Sum_M_Def = 0
	var Sum_BPA = 0
	var Sum_BMA = 0
	var Sum_SP = 0
	
	for i in Stat_Boosts:
		Sum_Def += i[1][0]
		Sum_M_Def += i[1][1]
		Sum_BPA += i[1][2]
		Sum_BMA += i[1][3]
		Sum_SP += i[1][4]
		
	Temp_Def += Defense + Sum_Def
	Temp_M_Def += Magic_Defense + Sum_M_Def
	Temp_BP_A += Base_Phisical_Attack + Sum_BPA
	Temp_BM_A += Base_Magical_Attack + Sum_BMA
	Temp_Sped += Speed + Sum_SP
	
