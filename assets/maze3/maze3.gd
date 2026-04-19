extends StaticBody3D

@onready var audio_player = $AudioStreamPlayer

signal won

func _on_end_area_body_entered(body: Node3D) -> void:
	if body.name == "player":
		won.emit(body.player_data)

func _on_bonus_exit_body_entered(body: Node3D) -> void:
	if body.name == "player":
		body.player_data["misc_data"]["b2_secret_exit"] = true
		won.emit(body.player_data)


func play_s(path):
	var sound = load(path)
	audio_player.stream = sound
	audio_player.play()
func _on_key_play_sound(path: String) -> void:
	play_s(path)
func _on_door_play_sound(path: String) -> void:
	play_s(path)
