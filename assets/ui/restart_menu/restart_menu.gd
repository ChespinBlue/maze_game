extends CanvasLayer

var in_game = false

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		if in_game:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			show()

func _on_no_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hide()

func _on_yes_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$"../player".reset_position()
	$"../win_screen".time = 0.0
	hide()

func _on_return_pressed() -> void:
	$"../title_screen".show_title()
	hide()
