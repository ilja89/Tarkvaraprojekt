extends Control


var finished = false
var dialog = 'You were born to a...'
var dialog_index = 0


func _ready():
	load_dialog()

func load_dialog():
	finished = false
	$DialogBox/RichTextLabel.bbcode_text = dialog
	$DialogBox/RichTextLabel.percent_visible = 0
	var duration = float(dialog.length()) / float(CharacterStats.TextSpeed)
	$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$DialogBox/Tween.start()



func _on_Tween_tween_completed(_object, _key):
	finished = true

