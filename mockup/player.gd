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
	# Apply gravity
	velocity += delta * GRAVITY_VEC
	# Move and slide
	velocity = move_and_slide(velocity, FLOOR_NORMAL, true)
	# Detect if we are on floor - only works if called *after* move_and_slide
	var on_floor:bool = is_on_floor()
	if on_floor and not prev_on_floor:
		$audLand.play()
	prev_on_floor = on_floor
	
	### CONTROL ###
	# Horizontal movement
	var target_speed:float = 0
	if Input.is_action_pressed("ui_left"):
		target_speed -= 1
		if on_floor:
			if $anim.current_animation != "run":
				$anim.play("run")
	elif Input.is_action_pressed("ui_right"):
		target_speed += 1
		if on_floor:
			if $anim.current_animation != "run":
				$anim.play("run")
	else:
		if $anim.current_animation != "idle":
			$anim.play("idle")

	target_speed *= WALK_SPEED
	velocity.x = lerp(velocity.x, target_speed, 0.2)
	
	if velocity.x < 0.0:
		$sprite.flip_h = true
	elif velocity.x > 0.0:
		$sprite.flip_h = false
	
	# Jumping
	if on_floor and Input.is_action_just_pressed("ui_up"):
		velocity.y = -JUMP_SPEED
		$audJump.play()

func on_step():
	if prev_on_floor:
		$audStep.play()
