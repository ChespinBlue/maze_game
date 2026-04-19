extends CanvasLayer

@onready var control_menu = $controls_menu
@onready var achiev_menu = $achievments

@onready var cam = $title_cam_center/Camera3D

signal start(maze:int)

var data_lcl = {}

func _on_start_pressed() -> void:
	start_maze(1)
func _on_start_2_pressed() -> void:
	start_maze(2)
func _on_start_3_pressed() -> void:
	start_maze(3)
func _on_start_4_pressed() -> void:
	start_maze(4)
	
func _on_tutorial_pressed() -> void:
	control_menu.show()
func _on_return_pressed() -> void:
	control_menu.hide()

func _on_achievs_pressed() -> void:
	achiev_menu.show()

func _on_exit_pressed() -> void:
	get_tree().quit()



func _on_maze_won(data: Dictionary) -> void:
	data_lcl = data
func _on_maze_1_won(_data: Dictionary) -> void:
	$VBoxContainer/achievs.show()
func _on_bonus_1_won(_data: Dictionary) -> void:
	achiev_menu.show_b_achievs = true
	achiev_menu.update()
func _on_bonus_2_won(data: Dictionary) -> void:
	if data["misc_data"]["b2_secret_exit"] == true:
		$start4.show()

func show_title():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	achiev_menu.update()
	cam.current = true
	$"../restart_menu".in_game = false
	$"../sound_manager".show_title()
	show()


func start_maze(numb):
	cam.current = false
	$"../restart_menu".in_game = true
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	start.emit(numb)




func _on_allacheivbutton_pressed() -> void:
	$"../player".player_data["achievments"]["Finish the maze in 40 seconds"] = true
	$"../player".player_data["achievments"]["Fall into the void"] = true
	$"../player".player_data["achievments"]["Find the apple"] = true
	$"../player".player_data["achievments"]["Find the box"] = true
	$"../player".player_data["achievments"]["Find the circle"] = true
	$"../player".player_data["achievments"]["Find the dime"] = true
	$"../player".player_data["achievments"]["Finish the maze"] = true
