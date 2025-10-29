extends Node2D

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
