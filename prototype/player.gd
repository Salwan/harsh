extends CEntity

const GRAVITY_VEC = Vector2(0.0, 342.0)
const WALK_SPEED = 100.0
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 0.25
const JUMP_SPEED = 100.0

var velocity:Vector2 = Vector2()
var prev_on_floor:bool = false

func _physics_process(delta:float):
	### MOVEMENT ###
	velocity = move_and_slide(velocity, FLOOR_NORMAL, true)
	
	### CONTROL ###
	var target_speed_x:float = 0
	var target_speed_y:float = 0
	if Input.is_action_pressed("ui_left"):
		target_speed_x -= 1
	elif Input.is_action_pressed("ui_right"):
		target_speed_x += 1
	if Input.is_action_pressed("ui_up"):
		target_speed_y -= 1
	elif Input.is_action_pressed("ui_down"):
		target_speed_y += 1
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
	pass
	#if prev_on_floor:
		#$audStep.play()
