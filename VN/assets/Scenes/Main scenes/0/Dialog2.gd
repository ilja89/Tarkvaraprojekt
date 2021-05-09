extends Control


var dialog_index = 0
var finished = false

var dialog = [
	'When you were 16 you decided to become a ...',
	""
]

func _ready():
	load_dialog()
	


func load_dialog():
	finished = false
	$DialogBox/RichTextLabel.bbcode_text = dialog[dialog_index]
	$DialogBox/RichTextLabel.percent_visible = 0
	var duration = float(dialog[dialog_index].length()) / float(CharacterStats.TextSpeed)
	$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$DialogBox/Tween.start()
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

