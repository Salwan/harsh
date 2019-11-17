extends Node

export(float) var Title1_Time = 0.5
export(float) var Title2_Time = 0.5
export(float) var Stay_Time = 3.5
export(float) var FadeOut_Time = 1.0
export(String) var Title1 = "FIRST HUMAN"
export(String) var Title2 = "MARS 2024"

enum eState {
	title1_in,
	title2_in,
	stay,
	titles_out,
	fadeout,
	end
}
onready var state = eState.title1_in
onready var accumTimer = 0.0

func _ready():
	self.visible = true
	$rect.modulate = Color(1, 1, 1, 1)
	$title1.text = Title1
	$title1.modulate = Color(1, 1, 1, 0)
	$title2.text = Title2
	$title2.modulate = Color(1, 1, 1, 0)
	$title1.visible = true
	$title2.visible = true
	$rect.visible = true

func _process(delta:float):
	accumTimer += delta
	match state:
		eState.title1_in:
			$title1.modulate = Color(1, 1, 1, min(accumTimer/Title1_Time, 1))
			if accumTimer >= Title1_Time:
				accumTimer = 0.0
				state += 1
		eState.title2_in:
			$title2.modulate = Color(1, 1, 1, min(accumTimer/Title2_Time, 1))
			if accumTimer >= Title2_Time:
				accumTimer = 0.0
				state += 1
		eState.stay:
			if accumTimer >= Stay_Time:
				accumTimer = 0.0
				state += 1
		eState.titles_out:
			$title1.modulate = Color(1, 1, 1, 1.0 - min(accumTimer/Title1_Time, 1))
			$title2.modulate = Color(1, 1, 1, 1.0 - min(accumTimer/Title2_Time, 1))
			if accumTimer >= max(Title1_Time, Title2_Time):
				accumTimer = 0.0
				state += 1
				$title1.visible = false
				$title2.visible = false
		eState.fadeout:
			$rect.modulate = Color(1, 1, 1, 1.0 - min(accumTimer/FadeOut_Time, 1))
			if accumTimer >= FadeOut_Time:
				accumTimer = 0.0
				state += 1
				$rect.visible = false
		eState.end:
			onEnd()

func onEnd():
	queue_free()