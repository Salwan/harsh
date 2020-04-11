extends Node

signal set_top_message(text)
signal set_bottom_message(text)
signal player_entered_interactable(interactable)
signal player_exited_interactable(interactable)
signal dialog_activated(dialog)
signal dialog_deactivated(dialog)

var DialogsContainer:Control = null

func _ready():
	pass

func setTopMessage(text:String):
	emit_signal("set_top_message", text)

func clearTopMessage():
	setTopMessage("")

func setBottomMessage(text:String):
	emit_signal("set_bottom_message", text)

func clearBottomMessage():
	setBottomMessage("")

func proxyPlayerEnteredInteractable(interactable:CInteractable):
	emit_signal("player_entered_interactable", interactable)

func proxyPlayerExitedInteractable(interactable:CInteractable):
	emit_signal("player_exited_interactable", interactable)

func proxyDialogActivated(dialog:CDialog):
	emit_signal("dialog_activated", dialog)

func proxyDialogDeactivated(dialog:CDialog):
	emit_signal("dialog_deactivated", dialog)

func pushDialog(dialog:CDialog):
	assert(DialogsContainer and dialog)
	DialogsContainer.add_child(dialog)
