extends Node
class_name test_Node_Branch

@export var turnMain: test_main
@export var turnHandler : test_turn_handler_tester 
@export var enemyHandler: test_enemy_handler

@export var optionAbi: Node 
@export var optionAct: Node
@export var optionBag: Node
@export var optionRun: Node

@onready var current_players:
	get:
		return turnMain.current_player
