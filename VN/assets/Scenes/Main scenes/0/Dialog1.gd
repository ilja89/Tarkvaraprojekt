extends Control


var dialog_index = 0
var finished = false

var dialog = [
	'As a very ... child. ',
]

func _ready():
	load_dialog()
	


func load_dialog():
	finished = false
	var duration = float(dialog[dialog_index].length()) / float(CharacterStats.TextSpeed)
	$DialogBox/RichTextLabel.percent_visible = 0
	$DialogBox/RichTextLabel.bbcode_text = dialog[dialog_index]
	$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$DialogBox/Tween.start()
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

