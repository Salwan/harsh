extends Node2D

export (float) var speed = 100.0

func _ready():
	pass

func _process(delta):
	$path/follow.offset += delta * speed
	$ysort/spr.position = $path/follow.position
