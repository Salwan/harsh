extends Label

var accum = 0.0
var frame_count = 0

func _ready():
	pass

func _process(delta):
	accum += delta
	frame_count += 1
	if accum >= 1:
		accum -= 1
		text = "FPS: " + str(frame_count)
		frame_count = 0
