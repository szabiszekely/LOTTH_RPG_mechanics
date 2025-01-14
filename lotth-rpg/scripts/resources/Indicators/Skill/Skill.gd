extends Resource
class_name Skill
 # this is where the scripts will gonna be not much to say!
@export var title : String
@export var indicator : Indicator
@export var projectile_name : String
@export var projectile_node : PackedScene
var skill_base_damage
var skill_attack_type

var player_reference: Player

func activate(_scene_tree):
	pass
