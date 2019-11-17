extends Node2D

export(float) var MOVEMENT_SPEED:float = 5.0

func _ready():
	$particles.visible = true

func _process(delta:float):
	var i:float = ((randi() % 3) - 1) * MOVEMENT_SPEED
	translate(Vector2(i * delta, 0))