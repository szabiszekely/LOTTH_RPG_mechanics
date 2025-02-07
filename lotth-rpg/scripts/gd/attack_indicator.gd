extends Node2D

@onready var attack_indicator: Sprite2D = $Attack_indicator
@onready var damage_number: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_indicator.scale = Vector2(1.2,1.2)
	damage_number.visible_characters = 4
	damage_number.modulate = Color.TRANSPARENT
	attack_indicator.frame = 0
	
func taken_damage(hit):
	var spawn_random_x = randi_range(-30,30)
	var spawn_random_y = randi_range(-30,30)
	
	self.position = Vector2(spawn_random_x,spawn_random_y)
	
	var tweens = get_tree().create_tween()
	
	tweens.tween_property(attack_indicator,"scale",Vector2(0.725,0.725),0.675).set_trans(Tween.TRANS_BOUNCE)
	damage_number.text = str(hit)
	tweens.tween_property(damage_number,"modulate",Color.WHITE,0.2).set_trans(Tween.TRANS_QUINT)
	if hit >= 10 and hit <= 99:
		await get_tree().create_timer(0.25).timeout
		attack_indicator.frame += 1
	if hit >= 100:
		await get_tree().create_timer(0.2).timeout
		attack_indicator.frame += 1
		await get_tree().create_timer(0.4).timeout
		attack_indicator.frame += 1
	
	
	await tweens.finished
	tweens = get_tree().create_tween()
	tweens.set_parallel()
	tweens.tween_property(self,"position",Vector2(self.position.x,self.position.y - 50),1.68).set_trans(Tween.TRANS_LINEAR)
	tweens.tween_property(self,"modulate",Color.TRANSPARENT,1.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished
	self.queue_free()
	
func true_taken_damage(hit):
	var spawn_random_x = randi_range(-30,30)
	var spawn_random_y = randi_range(-30,30)
	
	self.position = Vector2(spawn_random_x,spawn_random_y)
	
	var tweens = get_tree().create_tween()
	
	tweens.tween_property(attack_indicator,"scale",Vector2(0.85,0.85),0.675).set_trans(Tween.TRANS_BACK)
	damage_number.text = str(hit)
	tweens.tween_property(damage_number,"modulate",Color.WHITE,0.14).set_trans(Tween.TRANS_QUINT)
	
	await get_tree().create_timer(0.45).timeout
	attack_indicator.frame = 3
	await tweens.finished
	await get_tree().create_timer(0.2).timeout
	
	
	tweens = get_tree().create_tween()
	tweens.set_parallel()
	tweens.tween_property(self,"position",Vector2(self.position.x,self.position.y - 50),1.68).set_trans(Tween.TRANS_LINEAR)
	tweens.tween_property(attack_indicator,"scale",Vector2(1.05,1.05),0.297).set_trans(Tween.TRANS_QUINT)
	tweens.tween_property(self,"modulate",Color.TRANSPARENT,1.3).set_trans(Tween.TRANS_QUAD)
	await tweens.finished
	self.queue_free()
