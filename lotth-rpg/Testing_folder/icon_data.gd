extends Control

@export var CharacterName: String
@export var Action: String
@export var Outcome: String

@onready var label_2: Label = $Sprite2D/Label2
@onready var label_3: Label = $Sprite2D/Label3
@onready var label: Label = $Sprite2D/Label

func _ready() -> void:
	label_2.text = CharacterName
	label_3.text = Action
	label.text = Outcome
