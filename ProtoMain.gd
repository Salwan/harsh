extends Node

func _ready():
	on_set_top_message("")
	Global.connect("set_top_message", self, "on_set_top_message")
	Global.connect("set_bottom_message", self, "on_set_bottom_message")

func on_set_top_message(text:String):
	$topMessage.text = text

func on_set_bottom_message(text:String):
	$bottomMessage.text = text
