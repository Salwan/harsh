extends Node2D

class_name CInteractable

export (PackedScene) var dialog = null
export(Array, String) var dialogChoices = []

func _ready():
	pass

func _physics_process(delta:float):
	pass

func on_interaction_body_entered(body:PhysicsBody2D):
	if body.is_in_group("player"):
		Global.proxyPlayerEnteredInteractable(self as CInteractable)

func on_interaction_body_exited(body:PhysicsBody2D):
	if body.is_in_group("player"):
		Global.proxyPlayerExitedInteractable(self as CInteractable)

func interact():
	if dialog:
		if len(dialogChoices) > 0:
			var d = dialog.instance()
			d.rect_position = position
			d.strItems = dialogChoices
			Global.pushDialog(d)
		else:
			print("Interact: no dialog choices defined")
	else:
		print("Interact: no action")
