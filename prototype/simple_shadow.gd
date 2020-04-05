extends Sprite

export(String) var followedSprite : String;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame.
func _process(delta):
	var fs = get_node("../" + followedSprite)
	if fs:
		flip_h = fs.flip_h
		frame = fs.frame
