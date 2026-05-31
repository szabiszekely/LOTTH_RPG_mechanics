extends Resource
class_name Stat_Increases

var Defense: int 
var Magic_Defense: int 
var Base_Phisical_Attack: int 
var Base_Magical_Attack: int
var Speed: int
var header_ids: Array = []
# header for id stuff?
# return [header,{stat1:value,stat2:value}, remaining]
# store them inside a list [].

func _Get_Current_Stats(Def,M_Def,BP_Attack,BM_Attack,Speed_turn,Headers) -> void:
	self.Defense = Def
	self.Magic_Defense = M_Def
	self.Base_Phisical_Attack = BP_Attack
	self.Base_Magical_Attack = BM_Attack
	self.Speed = Speed_turn
	self.header_ids = Headers

func _Create_Header_Id():
	var random_header_id = randi()
	for i in header_ids:
		if random_header_id == i:
			_Create_Header_Id()
		else: return random_header_id

func _Stat_change(Limitation: String,Limitation_number: int,What_Stats: Dictionary) -> Array:
	var random_header_id = _Create_Header_Id()
	var is_turn: int = -1
	var All_stats = [Defense,Magic_Defense,Base_Phisical_Attack,Base_Magical_Attack,Speed]
	match Limitation:
		"Turn":
			is_turn = Limitation_number
		"Until": # later for event handler?
			pass

	for i in What_Stats:
		if What_Stats[i][2]:
			_Buff(What_Stats[i][0])
		else:
			_Debuff(What_Stats[i][0])
	
	if not is_turn <= 0:
		return [random_header_id,All_stats,is_turn]
	return [random_header_id,All_stats]
	
# key 			value
# index	[Stat,much,buff_debuff]

func _Buff(What_Stats):
	match What_Stats[0]:
		"Def":
			Defense += What_Stats[1]
		"M_Def":
			Magic_Defense += What_Stats[1]
		"BP_Attack":
			Base_Phisical_Attack += What_Stats[1]
		"BM_Attack":
			Base_Magical_Attack += What_Stats[1]
		"Speed":
			Speed += What_Stats[1]

	
func _Debuff(What_Stats):
	match What_Stats:
		"Def":
			Defense -= What_Stats[1]
		"M_Def":
			Magic_Defense -= What_Stats[1]
		"BP_Attack":
			Base_Phisical_Attack -= What_Stats[1]
		"BM_Attack":
			Base_Magical_Attack -= What_Stats[1]
		"Speed":
			Speed -= What_Stats[1]
