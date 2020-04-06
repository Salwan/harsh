extends CEntity

const GRAVITY_VEC = Vector2(0.0, 342.0)
const WALK_SPEED = 100.0
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 0.25
const JUMP_SPEED = 100.0

var velocity:Vector2 = Vector2()
var bControl:bool = true
var control_x:float = 0
var control_y:float = 0

func _ready():
	var pc = get_node("/root/PlayerController")
	pc.connect("player_run_up", self, "on_up")
	pc.connect("player_run_down", self, "on_down")
	pc.connect("player_run_left", self, "on_left")
	pc.connect("player_run_right", self, "on_right")

func _physics_process(delta:float):
	if not bControl:
		control_x = 0
		control_y = 0
		return

	# Movement
	velocity = move_and_slide(velocity, FLOOR_NORMAL, true)
	
	# Process Controls
	var target_speed_x:float = control_x
	var target_speed_y:float = control_y
	## consume controls
	control_x = 0
	control_y = 0

	if target_speed_x == 0 and target_speed_y == 0:
		if $anim.current_animation != "idle":
			$anim.play("idle")
	else:
		if $anim.current_animation != "run":
			$anim.play("run")

	target_speed_x *= WALK_SPEED
	target_speed_y *= WALK_SPEED
	velocity.x = lerp(velocity.x, target_speed_x, 0.2)
	velocity.y = lerp(velocity.y, target_speed_y, 0.2)
	
	if velocity.x < 0.0:
		$chris.flip_h = true
	elif velocity.x > 0.0:
		$chris.flip_h = false


func on_step():
	#$audStep.play()
	pass

func on_disable_controls():
	$anim.play("idle")
	velocity = Vector2(0, 0)
	bControl = false

func on_enable_controls():
	bControl = true

func on_right():
	control_x = min(control_x + 1, 1)

func on_left():
	control_x = max(control_x - 1, -1)

func on_down():
	control_y = min(control_y + 1, 1)

func on_up():
	control_y = max(control_y - 1, -1)
