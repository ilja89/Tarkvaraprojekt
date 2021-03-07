extends Control


var finished = false


#func _process(_delta):
#	$DialogBox/VBoxContainer/NextIcon.visible = finished
#	if Input.is_action_just_pressed("ui_accept"):
#		load_dialog()


func load_dialog(dialog, dialog_index):
	if dialog_index < dialog.size():
		finished = false
		$DialogBox/RichTextLabel.bbcode_text = dialog[dialog_index]
		$DialogBox/RichTextLabel.percent_visible = 0
		$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$DialogBox/Tween.start()



func _on_Tween_tween_completed(_object, _key):
	finished = true

