#special thanks to
# https://www.flamingtext.com/net-fu/jobs/29783528795275314.html
# for text effect
extends CanvasLayer

@onready var lab = $"../Label"

@onready var time_lbl = $VBoxContainer/time
@onready var achiev_lbl = $VBoxContainer/achiev
var green = Color(0.0, 1.0, 0.0, 1.0)
var first_time_showing_bonus = true
var show_b_achievs = false

var time = 0.0
var end_time = 1.0
#var time_ach2 = 130.0 ##???
var m1_time_ach = 40.0
var b1_time_ach = 40.0
var b2_time_ach = 20.0

var total_achievments = 8

func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	lab.text = str(snapped(time, 0.01))

func load_maze(numb):
	time = 0.0

func _on_maze_won(data : Dictionary) -> void:
	$"../restart_menu".in_game = false
	
	$"../player".player_data["achievments"]["Finish the maze"] = true
	end_time = time
	time = 0.0
	time_lbl.text = str("Time: ", snapped(end_time, 0.01), "s")
	
	#### get achievment numbers
	var achs = 0
	var total_ach = 0
	var achievs = data["achievments"]
	var keys = achievs.keys()
	var b_achievs = data["bonus_achievs"]
	var b_keys = b_achievs.keys()
	for i in keys:
		total_ach += 1
		if achievs[i] == true:
			achs += 1
	if show_b_achievs:
		for i in b_keys:
			total_ach += 1
			if b_achievs[i] == true:
				achs += 1
		
	achiev_lbl.text = str("Achievments: ", achs, "/", total_ach)
	
	#### see if completed all achievs
	if !first_time_showing_bonus:
		achiev_lbl.remove_theme_color_override("font_color")
		$VBoxContainer/achiev2.hide()
	
	if achs == total_ach:
		achiev_lbl.add_theme_color_override("font_color", green)
		if first_time_showing_bonus:
			first_time_showing_bonus = false
			$VBoxContainer/achiev2.show()
	
	
	show()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_maze_1_won(_data : Dictionary):
	end_time = time
	if end_time <= m1_time_ach:
		$"../player".player_data["achievments"]["Finish the maze in 40 seconds"] = true

func _on_bonus_1_won(_data : Dictionary):
	end_time = time
	if end_time <= b1_time_ach:
		$"../player".player_data["bonus_achievs"]["Finish the bonus maze in 40 seconds"] = true
	
	show_b_achievs = true

func _on_return_pressed() -> void:
	$"../title_screen".show_title()
	$"../player".reset_position()
	hide()
