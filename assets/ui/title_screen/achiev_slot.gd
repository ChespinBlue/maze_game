extends HBoxContainer

@onready var label = $label
@onready var check = $PanelContainer/check

var green = Color(0.0, 1.0, 0.0, 1.0)
var yellow = Color(0.471, 1.0, 0.0, 1.0)
var gray = Color(0.5, 0.5, 0.5, 1.0)

var is_bonus_achiev = false

func update(text:String, state:bool):
	label.text = text
	if state:
		label.add_theme_color_override("font_color", green)
		if is_bonus_achiev:
			#label.add_theme_color_override("font_color", yellow)
			pass
		check.show()
	else:
		#label.remove_theme_color_override("font_color")
		label.add_theme_color_override("font_color", gray)
		label.remove_theme_constant_override("outline_size")
		check.hide()
	
	if is_bonus_achiev:
		label.add_theme_constant_override("outline_size", 2)
