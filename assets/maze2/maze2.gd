extends StaticBody3D

@onready var audio_player = $AudioStreamPlayer

signal won(data: Dictionary)

func _on_end_area_body_entered(body: Node3D) -> void:
	if body.name == "player":
		won.emit(body.player_data)

func play_s(path):
	var sound = load(path)
	audio_player.stream = sound
	audio_player.play()
func _on_egg_play_sound(path: String) -> void:
	play_s(path)
