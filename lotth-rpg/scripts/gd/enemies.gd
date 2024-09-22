extends CharacterBody2D
@onready var focus = $Indicator

#@export var speed:int = 400
@export var Fight_stats: Fighting_Stats
@export var Turn_portriat: CompressedTexture2D
@export var Initiative: Initiative_class

var health: int :
	set(value_hp):
		#print("hey I was startled! I'm HP")
		health = value_hp
var energy: int:
	set(value_eng):
		#print("hey I was startled! I'm ENG")
		energy = value_eng
		

func _ready() -> void:
	
	var roll = Fight_stats.Speed + Fight_stats._Initiative()
	print(roll)
	var initiative_peronality = [Fight_stats.Friend_or_Foe,roll,Fight_stats.Speed,Turn_portriat,Fight_stats.name]
	Initiative.all_rolls.append(initiative_peronality)
	
	health = Fight_stats.HP
	energy = Fight_stats.ENG
	
	print("----------------")
	print("Stat Blog")
	print(Fight_stats.name)
	print("HP:",health," ","ENG:",energy)
	print("PHIS_ATK:",Fight_stats.Base_Phisical_Attack, " ","MAG_ATK:", Fight_stats.Base_Magical_Attack)
	print("ATK_Type:",Fight_stats.Attack_Type)
	print("EMP:", Fight_stats.EMP)
	print("----------------")
	
	$character_animator.play("idle")

		
	

func _play_animator_health_hit():
	$animator.play("hit")

func _play_animator_energy_hit():
	$animator.play("eng_hit")

func _focus_indicator():
	focus.show()

func _unfocus_indicator():
	focus.hide()

func _take_damage(base_damage,strengh,index):
	health = Fight_stats.HP
	energy = Fight_stats.ENG
	
	var hit = Fight_stats._Damage_Taken(base_damage,strengh,Fight_stats.Defense,Fight_stats.Attack_Type,1)
	
	if Fight_stats.HP == 0:
		get_child(index).queue_free()
	
	
	if Fight_stats.ENG > 0:
		_play_animator_energy_hit() 
		Fight_stats.ENG -= hit
		if Fight_stats.ENG <= 0:
			Fight_stats.ENG = 0
	else:
		_play_animator_health_hit()
		Fight_stats.HP -= hit
		if Fight_stats.HP <= 0:
			Fight_stats.HP = 0
			
	print("----------------")
	print("Stat Block")
	print(Fight_stats.name)
	print("HP:",health," ","ENG:",energy)
	print("PHIS_ATK:",Fight_stats.Base_Phisical_Attack, " ","MAG_ATK:", Fight_stats.Base_Magical_Attack)
	print("ATK_Type:",Fight_stats.Attack_Type)
	print("EMP:", Fight_stats.EMP)
	print("----------------")
