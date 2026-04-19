extends Sprite3D

@export var achievment_name : String
@export var achievment_section : String = "achievments"

signal play_sound(path : String)
var sound_path = "res://assets/audio/sfx/snd_noiseQ.mp3"
 
func _on_area_body_entered(body: Node3D) -> void:
	if body.name == "player":
		if body.player_data[achievment_section] != null:
			
			play_sound.emit(sound_path)
			body.player_data[achievment_section][achievment_name] = true
			queue_free()
