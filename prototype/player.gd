extends CEntity

const GRAVITY_VEC = Vector2(0.0, 342.0)
const WALK_SPEED = 100.0
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 0.25
const JUMP_SPEED = 100.0

var velocity:Vector2 = Vector2()
var controlX:float = 0
var controlY:float = 0
var interactableInRange:CInteractable = null
var dialogStack:Array = []

enum EControl { NOTHING, PLAYER, DIALOG }
var controlMode:int = EControl.PLAYER

func _ready():
	Global.connect("player_entered_interactable", self, "on_entered_interactable")
	Global.connect("player_exited_interactable", self, "on_exited_interactable")
	Global.connect("dialog_activated", self, "on_dialog_activated")
	Global.connect("dialog_deactivated", self, "on_dialog_deactivated")

func _process(delta:float):
	match controlMode:
		EControl.NOTHING:
			pass
		EControl.PLAYER:
			if Input.is_action_pressed("control_up"):
				player_run_up()
			if Input.is_action_pressed("control_down"):
				player_run_down()
			if Input.is_action_pressed("control_left"):
				player_run_left()
			if Input.is_action_pressed("control_right"):
				player_run_right()
			if Input.is_action_just_pressed("control_action"):
				player_action_use()
		EControl.DIALOG:
			if Input.is_action_just_pressed("control_up"):
				dialog_up()
			if Input.is_action_just_pressed("control_down"):
				dialog_down()
			if Input.is_action_just_pressed("control_left"):
				dialog_left()
			if Input.is_action_just_pressed("control_right"):
				dialog_right()
			if Input.is_action_just_pressed("control_action"):
				dialog_select()
			if Input.is_action_just_pressed("control_back"):
				dialog_exit()

func _physics_process(delta:float):
	if controlMode != EControl.PLAYER:
		controlX = 0
		controlY = 0
		return

	# Movement
	velocity = move_and_slide(velocity, FLOOR_NORMAL, true)
	
	# Process Controls
	var target_speed_x:float = controlX
	var target_speed_y:float = controlY
	## consume controls
	controlX = 0
	controlY = 0

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

################################################################################
# EVENTS
#
func on_entered_interactable(interactable):
	Global.pushTopMessage("Press `E` to interact")
	assert(interactable)
	interactableInRange = interactable

func on_exited_interactable(interactable):
	Global.popTopMessage()
	interactableInRange = null

func on_dialog_activated(dialog:CDialog):
	dialogStack.push_back(dialog)
	set_control(EControl.DIALOG)
	Global.pushTopMessage("Press `E` to select, `Q` to go back")

func on_dialog_deactivated(dialog:CDialog):
	dialogStack.pop_back()
	if len(dialogStack) == 0:
		set_control(EControl.PLAYER)
	Global.popTopMessage()


################################################################################
# SFX
#
func on_step():
	#$audStep.play()
	pass


################################################################################
# CONTROLS
#
func set_control(type):
	if controlMode != type:
		controlMode = type
		match controlMode:
			EControl.NOTHING:
				on_nonplayer_control()
			EControl.PLAYER:
				pass
			EControl.DIALOG:
				on_nonplayer_control()

func on_nonplayer_control():
	$anim.play("idle")
	velocity = Vector2(0, 0)

# PLAYER CONTROLS

func player_run_right():
	controlX = min(controlX + 1, 1)

func player_run_left():
	controlX = max(controlX - 1, -1)

func player_run_down():
	controlY = min(controlY + 1, 1)

func player_run_up():
	controlY = max(controlY - 1, -1)

func player_action_use():
	if interactableInRange:
		interactableInRange.interact()
	else:
		print("Nothing to interact with")

# DIALOG CONTROLS

func dialog_up():
	if dialogStack.back():
		dialogStack.back().on_up()

func dialog_down():
	if dialogStack.back():
		dialogStack.back().on_down()

func dialog_left():
	if dialogStack.back():
		dialogStack.back().on_left()

func dialog_right():
	if dialogStack.back():
		dialogStack.back().on_right()

func dialog_select():
	if dialogStack.back():
		dialogStack.back().on_select()

func dialog_exit():
	if dialogStack.back():
		dialogStack.back().on_exit()
