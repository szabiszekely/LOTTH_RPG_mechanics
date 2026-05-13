extends Resource
class_name Stat_Increases

var Defense: int 
var Magic_Defense: int 
var Base_Phisical_Attack: int 
var Base_Magical_Attack: int
var Speed: int


func _get_current_stats(Def,M_Def,BP_Attack,BM_Attack,Speed) -> void:
	self.Defense = Def
	self.Magic_Defense = M_Def
	self.Base_Phisical_Attack = BP_Attack
	self.Base_Magical_Attack = BM_Attack
	self.Speed = Speed
	
func _Stat_change(Limitation: String,Limitation_number: int, Stack:bool,What_Stats: Dictionary,Buff_or_Debuff: bool):
	match Limitation:
		"Turn":
			pass
		"Rest O Battle":
			pass
		"Until":
			pass
		
	if Stack:
		pass
	else:
		pass
	
	if Buff_or_Debuff:
		_Buff(What_Stats)
	else:
		_Debuff(What_Stats)
		
	
		
func _Buff(What_Stats):
	for i in What_Stats:
		match What_Stats:
			"Def":
				pass
			"M_Def":
				pass
			"BP_Attack":
				pass
			"BM_Attack":
				pass
			"Speed":
				pass

	
func _Debuff(What_Stats):
	for i in What_Stats:
		match What_Stats:
			"Def":
				pass
			"M_Def":
				pass
			"BP_Attack":
				pass
			"BM_Attack":
				pass
			"Speed":
				pass
