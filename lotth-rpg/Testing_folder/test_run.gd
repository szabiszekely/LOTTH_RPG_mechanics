extends Node

var Dict: Dictionary = {1:["alma",false],2:["bananna",true],3:["szölö",true]}

func _ready() -> void:
	for i in Dict:
		print(i," ",Dict[i][0]," ",Dict[i][1])
