extends Sprite3D

@export var keyname : String

signal play_sound(path : String)
var sound_path = "res://assets/audio/sfx/snd_noiseQ.mp3"
 
func _on_area_body_entered(body: Node3D) -> void:
	if body.name == "player":
		if body.player_data["inventory"] != null:
			
			play_sound.emit(sound_path)
			body.player_data["inventory"].append(keyname)
			queue_free()
