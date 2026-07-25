extends StaticBody2D

@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@export var health: int = 10:
	set(value):
		health = value
		if value <= 0:
			await get_tree().create_timer(2).timeout
			queue_free()
@export var resistance: int = 0
@export_enum("Weak to magic","Not weak to magic","Resistence againts magic") var magicWeakness = 0

const ATTACK_INDICATOR = preload("res://scenes/attack_indicator.tscn")

#this is a script for the obj_s not much for now 
func _ready() -> void:
	$AnimatedSprite2D.play("default")
		
func _take_damage(base_damage_phisical,strengh,attacker_type,card_type,base_damage_magical):
	var hit
	
	if card_type == 2 and magicWeakness == 0:
		hit = base_damage_magical + (strengh)
	elif card_type == 2 and magicWeakness == 1:
		hit = base_damage_magical + (strengh-resistance)
	elif card_type == 2 and magicWeakness == 2:
		hit = 0
	else:
		hit = base_damage_phisical + (strengh-resistance)
	
	if hit <= 0:
		hit = 0
	
	health -= hit
	
	var got_damage = ATTACK_INDICATOR.instantiate()
	self.add_child(got_damage)
	got_damage.taken_damage(hit)
	
	
