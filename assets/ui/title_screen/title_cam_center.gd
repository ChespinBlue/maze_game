@tool
extends Node3D

const m1speed = 0.06
const m2speed = 0.5

var speed = 0.06

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(speed * delta)

func load_maze(numb):
	match numb:
		1:
			speed = m1speed
			$Camera3D.rotation_degrees.x = -40.0
		2:
			speed = m2speed
			$Camera3D.rotation_degrees.x = -60.0
		3:
			speed = m1speed
			$Camera3D.rotation_degrees.x = -90.0
		4:
			speed = m2speed
			$Camera3D.rotation_degrees.x = -90.0
			
