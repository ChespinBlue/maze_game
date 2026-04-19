extends AnimatableBody3D

@export var keyname = "key"

const SPEED = 5.0
const height = 3.0

@onready var start_pos = global_position
@onready var end_pos = Vector3(start_pos.x, start_pos.y - height, start_pos.z)

var in_area = false
var open = false

signal play_sound(path : String)
var sound_path = "res://assets/audio/sfx/door_open.mp3"

func open_func():
	open = true
	play_sound.emit(sound_path)
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property($".", "global_position", end_pos, 2.0)
	await tween.finished
	hide()

func _on_area_body_entered(body: Node3D) -> void:
	if body.name == "player":
		in_area = true
		if !open:
			if body.player_data["inventory"] != null:
				if body.player_data["inventory"].has(keyname):
					open_func()

func _on_area_body_exited(body: Node3D) -> void:
	if body.name == "player":
		in_area = false
