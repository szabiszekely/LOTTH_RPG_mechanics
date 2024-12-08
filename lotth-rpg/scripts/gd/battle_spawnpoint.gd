@tool
extends Marker2D

@export_category("Main Controll room")
@export var fixed_Spot_player := false :
	set(value):
		fixed_Spot_player = value
		notify_property_list_changed()

@export var fixed_Spot_enemy := false :
	set(value):
		fixed_Spot_enemy = value
		notify_property_list_changed()
@export_category("Spawner")
@export_group("Player") 
@export var Player_name : String = "unchanged"
@export_group("Enemy")
@export var Enemy_name : String = "unchanged"

func _validate_property(property: Dictionary):
	if property.name in ["Player_name"] and fixed_Spot_player == false :
		property.usage = PROPERTY_USAGE_NO_EDITOR
	if property.name in ["Enemy_name"] and fixed_Spot_enemy == false :
		property.usage = PROPERTY_USAGE_NO_EDITOR
