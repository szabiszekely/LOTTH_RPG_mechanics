extends Node2D

@onready var player_damage = preload("res://scripts/resources/Lil_Guy_Fighting_Stats.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_damage.HP == 0:
		get_child(0).queue_free()
		player_damage.HP = -1
		
		
	if Input.is_action_just_pressed("ui_accept"):
		var hit = player_damage._Damage_Taken(player_damage.HP,player_damage.ENG,2,4,player_damage.Defense,player_damage.Attack_Type,1)
		if player_damage.ENG > 0:
			player_damage.ENG -= hit
			if player_damage.ENG <= 0:
				player_damage.ENG = 0
		else:
			player_damage.HP -= hit
			if player_damage.HP <= 0:
				player_damage.HP = 0
		
		print("ENG: ",player_damage.ENG)
		print("HP: ",player_damage.HP)
