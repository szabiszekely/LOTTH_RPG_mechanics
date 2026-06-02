extends Resource
class_name Stat_Increases

var header_ids: Array = []
# Defense,Magic_Defense,Base_Phisical_Attack,Base_Magical_Attack,Speed
var All_stats: Array

# header for id stuff?
# return [header,{stat1:value,stat2:value}, remaining]
# store them inside a list [].

func _Get_Current_Stats(Headers) -> void:
	self.header_ids = Headers

func _Create_Header_Id():
	var random_header_id = randi()
	
	if random_header_id in header_ids:
		_Create_Header_Id()
	else: return random_header_id

func _Stat_change(Limitation: String,Limitation_number: int,What_Stats: Dictionary) -> Array:
	var random_header_id = _Create_Header_Id()
	var is_turn: int = -1
	All_stats = [0,0,0,0,0]
	match Limitation:
		"Turn":
			is_turn = Limitation_number
		"Until": # later for event handler?
			pass
		"ROB": # Rest Of Battle
			is_turn = -1
	for i in What_Stats:
		if What_Stats[i][2]:
			_Buff(What_Stats[i])

		else:
			_Debuff(What_Stats[i])
	
	if not is_turn <= 0:
		return [random_header_id,All_stats,is_turn]
	return [random_header_id,All_stats,is_turn]
	
# key 			value
# index	[Stat,much,buff_debuff]

func _Buff(What_Stats):
	match What_Stats[0]:
		"Def":
			All_stats[0] += What_Stats[1]
		"M_Def":
			All_stats[1] += What_Stats[1]
		"BP_Attack":
			All_stats[2] += What_Stats[1]
		"BM_Attack":
			All_stats[3] += What_Stats[1]
		"Speed":
			All_stats[4] += What_Stats[1]

	
func _Debuff(What_Stats):
	match What_Stats[0]:
		"Def":
			All_stats[0] -= What_Stats[1]
		"M_Def":
			All_stats[1] -= What_Stats[1]
		"BP_Attack":
			All_stats[2] -= What_Stats[1]
		"BM_Attack":
			All_stats[3] -= What_Stats[1]
		"Speed":
			All_stats[4] -= What_Stats[1]
