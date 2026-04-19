extends Node3D

@onready var maze1 = preload("res://assets/maze1/maze1.tscn")
@onready var maze2 = preload("res://assets/maze2/maze2.tscn")
@onready var maze3 = preload("res://assets/maze3/maze3.tscn")
@onready var void1 = preload("res://assets/void4/void4.tscn")

@onready var title = $title_screen
@onready var win = $win_screen

@onready var sound_manager = $sound_manager

var prev_maze = 1
var start_pos : Transform3D

func _ready() -> void:
	load_maze(1)

func load_maze(numb):
	var inst
	match numb:
		1:
			inst = maze1.instantiate()
			inst.won.connect(title._on_maze_1_won)
			inst.won.connect(win._on_maze_1_won)
		2:
			inst = maze2.instantiate()
			inst.won.connect(title._on_bonus_1_won)
			inst.won.connect(win._on_bonus_1_won)
		3:
			inst = maze3.instantiate()
			inst.won.connect(title._on_bonus_2_won)
		4:
			inst = void1.instantiate()
	
	inst.won.connect(title._on_maze_won)
	inst.won.connect(win._on_maze_won)
	inst.won.connect(sound_manager._on_maze_won)
	
	add_child(inst)
	start_pos = inst.get_node("start_pos").global_transform
	$player.spawn_transform = start_pos
	$player.reset_position()
	prev_maze = numb
	
	$title_screen/title_cam_center.load_maze(numb)
	sound_manager.load_maze(numb)
	win.load_maze(numb)

func unload_maze(numb):
	var nam = str("maze", numb)
	if get_node_or_null(nam) != null:
		remove_child(get_node(nam))
	nam = str("void", numb)
	if get_node_or_null(nam) != null:
		remove_child(get_node(nam))
	#for i in get_children():
		#if i.name.contains("maze"):
			#i.queue_free()


func _on_title_screen_start(maze: int) -> void:
	
	#var names = []
	#for i in get_children():
		#names.append(i.name)
	#print(names)
	
	await unload_maze(prev_maze)
	load_maze(maze)
