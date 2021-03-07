extends Panel


func _ready():
	$VBoxContainer/HBoxContainer/VBoxContainer2/CheckBox.pressed = MusicController.is_manual_music
	$VBoxContainer/HBoxContainer/VBoxContainer2/HSlider.value = MusicController.volume

func _on_CheckBox_toggled(button_pressed):
	MusicController.is_manual_music = button_pressed
	$VBoxContainer/HBoxContainer/VBoxContainer2/VBoxContainer.visible = button_pressed

func _on_HSlider_value_changed(value):
	MusicController.volume = value


func _on_Button_pressed():
	MusicController.start("res://assets/Music/1/", true)


func _on_Button2_pressed():
	MusicController.start("res://assets/Music/2/", true)


func _on_Button3_pressed():
	MusicController.start("res://assets/Music/3/", true)
