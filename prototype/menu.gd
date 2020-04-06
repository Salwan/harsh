extends Control

export(String) var strTitle = "Title"
export(Array, String) var strItems:Array = [ "item 1", "item 2", "item 3" ]

var iCursor:int = 0

func _ready():
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
	if Input.is_action_just_pressed("ui_up"):
		iCursor -= 1
	if Input.is_action_just_pressed("ui_down"):
		iCursor += 1
	if iCursor < 0:
		iCursor = items_count - 1
	elif iCursor > items_count - 1:
		iCursor = 0
	#iCursor = min(max(iCursor, 0), items_count - 1)

