extends Control


var dialog_index = 0
var finished = false

var dialog = [
	'Test suite 123',
	'xddd Lorem ipsum compile this you filthy animal',
	'last sentence lets goo!!!'
]

func _ready():
	load_dialog()
	

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()


func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$DialogBox/RichTextLabel.bbcode_text = dialog[dialog_index]
		$DialogBox/RichTextLabel.percent_visible = 0
		$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$DialogBox/Tween.start()
	else:
		queue_free()
	dialog_index += 1




func _on_Tween_tween_completed(object, key):
	finished = true
