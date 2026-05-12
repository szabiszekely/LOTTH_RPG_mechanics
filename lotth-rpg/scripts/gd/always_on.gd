extends Node
class_name Awaiter

signal command

func finish_on_command():
	await command
	
