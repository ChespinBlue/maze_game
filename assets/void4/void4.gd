extends StaticBody3D

signal won(data: Dictionary)

@onready var player = $"../player"
var prev_player_pos = position

@onready var mesh = $MeshInstance3D
@onready var og_mesh_pos = mesh.position

func _physics_process(_delta: float) -> void:
	var player_mov = player.position - prev_player_pos
	player.position.x -= player_mov.x
	player.position.z -= player_mov.z
	prev_player_pos = player.position
	
	mesh.position.x -= player_mov.x
	mesh.position.z -= player_mov.z
	if abs(mesh.position.x-og_mesh_pos.x) >= 4.0:
		mesh.position.x = og_mesh_pos.x
	if abs(mesh.position.z-og_mesh_pos.z) >= 4.0:
		mesh.position.z = og_mesh_pos.z
