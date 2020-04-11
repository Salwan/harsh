extends Node2D

# Global controls
signal game_pause;

# Player mode
signal player_run_up;
signal player_run_down;
signal player_run_left;
signal player_run_right;
signal player_action_use;

# Dialog mode
signal dialog_up;
signal dialog_down;
signal dialog_left;
signal dialog_right;
signal dialog_select;
signal dialog_exit;

enum EMode { MODE_PLAYER, MODE_DIALOG }
var mode:int

func _ready():
	mode = EMode.MODE_PLAYER

func _process(delta):
	if Input.is_action_just_pressed("control_start"):
		emit_signal("game_pause")
	match mode:
		EMode.MODE_PLAYER:
			process_player()
		EMode.MODE_DIALOG:
			process_dialog()

func process_player():
	if Input.is_action_pressed("control_up"):
		emit_signal("player_run_up")
	if Input.is_action_pressed("control_down"):
		emit_signal("player_run_down")
	if Input.is_action_pressed("control_left"):
		emit_signal("player_run_left")
	if Input.is_action_pressed("control_right"):
		emit_signal("player_run_right")
	if Input.is_action_just_pressed("control_action"):
		emit_signal("player_action_use")
	if Input.is_action_just_pressed("control_back"):
		pass

func process_dialog():
	if Input.is_action_pressed("control_up"):
		emit_signal("dialog_up")
	if Input.is_action_pressed("control_down"):
		emit_signal("dialog_down")
	if Input.is_action_pressed("control_left"):
		emit_signal("dialog_left")
	if Input.is_action_pressed("control_right"):
		emit_signal("dialog_right")
	if Input.is_action_just_pressed("control_action"):
		emit_signal("dialog_select")
	if Input.is_action_just_pressed("control_back"):
		emit_signal("dialog_exit")
	
func set_player_mode():
	mode = EMode.MODE_PLAYER

func set_dialog_mode():
	mode = EMode.MODE_DIALOG
