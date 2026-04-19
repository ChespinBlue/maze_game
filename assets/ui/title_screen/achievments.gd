extends Panel

var show_b_achievs = false

func _on_return_pressed() -> void:
	hide()

func update():
	if !get_parent().data_lcl.is_empty():
		var achievs = get_parent().data_lcl["achievments"]
		var b_achievs = get_parent().data_lcl["bonus_achievs"]
		
		var ind = 0
		var keys = achievs.keys()
		var b_keys = b_achievs.keys()
		
		for a in $ScrollContainer/VBoxContainer2.get_children():
			#if achievs[keys[ind]] != null:
			if ind+1 <= keys.size():
				a.update(keys[ind], achievs[keys[ind]])
				a.show()
			else:
				if !show_b_achievs:
					a.hide()
				else:
					var b_ind = ind - keys.size()
					if b_ind+1 <= b_keys.size():
						a.is_bonus_achiev = true
						a.update(b_keys[b_ind], b_achievs[b_keys[b_ind]])
						a.show()
					else:
						pass
						a.hide()
					
			ind += 1
			
		
		var achs = 0
		var total_ach = 0
		for i in keys:
			total_ach += 1
			if achievs[i] == true:
				achs += 1
		if show_b_achievs:
			for i in b_keys:
				total_ach += 1
				if b_achievs[i] == true:
					achs += 1
		$number.text = str(achs, "/", total_ach)
		##### if have all achievments, show bonus level button
		if achs == total_ach:
			$"../VBoxContainer/HBoxContainer/start2".show()
			if show_b_achievs: #if have all achievments, inlcuding b1 a, show b2 level button
				$"../VBoxContainer/HBoxContainer/start2".text = "B. 1"
				$"../VBoxContainer/HBoxContainer/start3".show()
