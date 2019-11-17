extends Camera2D

const Screen_Size = Vector2(256, 128)
const Map_Width = 512

export(NodePath) var Target_Node = null

onready var track_body:Node2D = null
onready var start_track_at:float = 0


func _ready():
	$area.connect("body_entered", self, "body_entered")
	$area.connect("body_exited", self, "body_exited")

func _process(delta:float):
	if track_body:
		var d = track_body.global_position.x - start_track_at
		if d > 0:
			global_position.x = d
		#if track_body.global_position.x < 128:
		#	global_position.x = max(get_node("../player").global_position.x - start_track_at, 0)
		#else:
		#	global_position.x = min(get_node("../player").global_position.x - start_track_at, Map_Width - Screen_Size.x)

func body_entered(body):
	if not track_body and body.get("tag") == "player":
		track_body = body
		start_track_at = track_body.global_position.x

func body_exited(body):
	if track_body and body.get("tag") == "player":
		track_body = null
		global_position.x = 0
