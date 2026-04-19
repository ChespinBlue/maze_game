extends StaticBody3D

@onready var audio_player = $AudioStreamPlayer

@export var final_key_name = "none"
signal won(data: Dictionary)


func _on_key_1_play_sound(path: String) -> void:
	play_s(path)
func _on_key_2_play_sound(path: String) -> void:
	play_s(path)
func _on_key_3_play_sound(path: String) -> void:
	play_s(path)

func _on_door_1_play_sound(path: String) -> void:
	play_s(path)
func _on_door_2_play_sound(path: String) -> void:
	play_s(path)
func _on_door_3_play_sound(_path: String) -> void:
	play_s("res://assets/audio/sfx/door_final_open.mp3")

func _on_dime_play_sound(path: String) -> void:
	play_s(path)
func _on_box_play_sound(path: String) -> void:
	play_s(path)
func _on_circle_play_sound(path: String) -> void:
	play_s(path)
func _on_apple_play_sound(path: String) -> void:
	play_s(path)

func play_s(path):
	var sound = load(path)
	audio_player.stream = sound
	audio_player.play()



func _on_end_area_body_entered(body: Node3D) -> void:
	if body.name == "player":
		if body.player_data["inventory"].has(final_key_name):
			
			won.emit(body.player_data)
