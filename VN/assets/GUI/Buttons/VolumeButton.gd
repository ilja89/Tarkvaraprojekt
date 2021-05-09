extends Control


func _ready():
	$HBoxContainer/HSlider.value = MusicController.volume

func _process(_delta):
	if MusicController.volume == -70:
		$HBoxContainer/MarginContainer/Button/Muted.visible = true
		$HBoxContainer/MarginContainer/Button/Speaker.visible = false
	else:
		$HBoxContainer/MarginContainer/Button/Muted.visible = false
		$HBoxContainer/MarginContainer/Button/Speaker.visible = true


func _on_Button_toggled(_button_pressed):
	$HBoxContainer/HSlider.visible = !$HBoxContainer/HSlider.visible


func _on_HSlider_value_changed(value):
	if value == -40:
		MusicController.volume = -70
	else:
		MusicController.volume = value
