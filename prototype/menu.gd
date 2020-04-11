extends Control

export(String) var strTitle = "Title"
export(Array, String) var strItems:Array = [ "item 1", "item 2", "item 3" ]

var iCursor:int = 0

func _ready():
	PlayerController.connect("dialog_up", self, "on_up")
	PlayerController.connect("dialog_down", self, "on_down")
	PlayerController.connect("dialog_left", self, "on_left")
	PlayerController.connect("dialog_right", self, "on_right")
	PlayerController.connect("dialog_select", self, "on_select")
	PlayerController.connect("dialog_exit", self, "on_exit")
	for i in len(strItems):
		var item:Label = get_node("item" + str(i + 1))
		item.text = strItems[i]

func _process(delta):
	# items
	var items_count = 0
	for i in len(strItems):
		var item:Label = get_node("item" + str(i + 1))
		if iCursor == i:
			item.text = ">> " + strItems[i] + " <<"
		else:
			item.text = strItems[i]
		if len(strItems[i]) > 0:
			items_count += 1
	# controls
	if iCursor < 0:
		iCursor = items_count - 1
	elif iCursor > items_count - 1:
		iCursor = 0
	iCursor = 0

func on_up():
	iCursor -= 1

func on_down():
	iCursor += 1

func on_left():
	pass

func on_right():
	pass

func on_select():
	pass

func on_exit():
	pass
