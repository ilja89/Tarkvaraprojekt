extends MarginContainer



func _on_ExitButton_pressed():
	get_tree().quit()

func _on_MenuButton_pressed():
	get_tree().change_scene("res://assets/main_menu/MainMenu.tscn")
