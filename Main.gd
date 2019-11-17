extends Node

# Just a bootstrap for the game, can do pre-game stuff

func _ready():
	pass

func _process(delta):
	get_tree().change_scene("res://Intro.tscn")

