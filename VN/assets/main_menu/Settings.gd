extends Panel

var dialog = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In risus sem, sollicitudin at semper ac, iaculis fringilla elit. Sed tincidunt orci imperdiet libero aliquam, et efficitur purus sagittis. "

func _ready():
	$VBoxContainer/HBoxContainer/VBoxContainer2/CheckBox.pressed = MusicController.is_manual_music
	$VBoxContainer/HBoxContainer/VBoxContainer2/VBoxContainer.visible = MusicController.is_manual_music
	$VBoxContainer/HBoxContainer/VBoxContainer2/HSlider.value = MusicController.volume
	$VBoxContainer/HBoxContainer/VBoxContainer/HSlider2.value = CharacterStats.TextSpeed
	$VBoxContainer/HBoxContainer/VBoxContainer/Title2.text = "Text speed: %d"%CharacterStats.TextSpeed
	$VBoxContainer/HBoxContainer/VBoxContainer/Title3.text = "Endings found: %d / 52"%Items.numofendings()
	$VBoxContainer/HBoxContainer/VBoxContainer/RichTextLabel.bbcode_text = dialog

func _on_CheckBox_toggled(button_pressed):
	MusicController.is_manual_music = button_pressed
	$VBoxContainer/HBoxContainer/VBoxContainer2/VBoxContainer.visible = button_pressed

func _on_HSlider_value_changed(value):
	if value == -40:
		MusicController.volume = -70
	else:
		MusicController.volume = value


func _on_Button_pressed():
	MusicController.start("res://assets/Music/Calm/", true)


func _on_Button2_pressed():
	MusicController.start("res://assets/Music/Agressive/", true)


func _on_Button3_pressed():
	MusicController.start("res://assets/Music/Medium/", true)


func _on_HSlider2_value_changed(value):
	CharacterStats.TextSpeed = value
	$VBoxContainer/HBoxContainer/VBoxContainer/Title2.text = "Text speed: %d"%CharacterStats.TextSpeed
	$VBoxContainer/HBoxContainer/VBoxContainer/Tween.stop_all()
	$VBoxContainer/HBoxContainer/VBoxContainer/RichTextLabel.percent_visible = 0
	var duration = float(dialog.length()) / float(CharacterStats.TextSpeed)
	$VBoxContainer/HBoxContainer/VBoxContainer/Tween.interpolate_property($VBoxContainer/HBoxContainer/VBoxContainer/RichTextLabel, "percent_visible", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$VBoxContainer/HBoxContainer/VBoxContainer/Tween.start()



func _on_ClearStats_pressed():
	Items.clear()
	$VBoxContainer/HBoxContainer/VBoxContainer/Title3.text = "Endings found: %d / 52"%Items.numofendings()
