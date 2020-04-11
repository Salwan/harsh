extends Node

signal set_top_message(text)
signal set_bottom_message(text)

func _ready():
	pass

func setTopMessage(text:String):
	emit_signal("set_top_message", text)

func setBottomMessage(text:String):
	emit_signal("set_bottom_message", text)
