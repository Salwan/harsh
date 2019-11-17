extends Node2D

func _ready():
	print("Game: Intro")
	$anim.play("intro_1")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		self.onStart()

func onStart():
	$audIntro.stop()
	get_tree().change_scene("res://Game.tscn")

func _onStart_mouse_entered():
	$start.scale.x = 1.05
	$start.scale.y = 1.05


func _onStart_mouse_exited():
	$start.scale.x = 1.0
	$start.scale.y = 1.0

func _onStart_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		self.onStart()
