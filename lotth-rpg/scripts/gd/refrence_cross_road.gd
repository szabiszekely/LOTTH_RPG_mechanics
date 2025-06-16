extends Node
class_name CrossRoad

@export var MainNode: Main
@export var TurnHandler: Turn_Handler
@export var InitiativeHandler: Initiative_class
@export var ObjFolder: Node2D
@export var PlayerGroup: Player_group
@export var EnemyGroup: Enemy_group
@export var Menu: Menu_system
@onready var Players:
	get:
		return PlayerGroup.player
@onready var Enemeies:
	get:
		return EnemyGroup.enemies
@export var AbiHandler: Ability_Handler
@export var AbiCard: Ability_control
@export var ActHandler: Action_buttons_option_Handler
@export var ActButtonHandler: Action_control
@export var BagHandler: Bagpack_controls
@export var ItemHandler: Item_handler
@export var RunHandler: Run_control
