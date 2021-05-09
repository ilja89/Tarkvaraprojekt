extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()

var dialog = [

	'This old lady is definitely a witch! Bunches of herbs hanging around the house, strange flasks and a sly look that did not tarnish despite the age of the eyes... ',
	"She offers you a potion, saying that it will make you feel better. Will you take it?",
	"You decided it'd be better to avoid it.",
	"You drank the potion, but you feel no change.",
	"You drank the potion and you feel stronger.",
	"You drank the potion and you feel smarter.",
	"You drank the potion and you feel confidence",
	"She explained to you how to get to the..."

]


func _ready():
	load_dialog()
	

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1:
			load_dialog()
		elif dialog_index > 2 && dialog_index < 8:
			dialog_index = 7
			load_dialog()
		


func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$DialogBox/RichTextLabel.bbcode_text = dialog[dialog_index]
		$DialogBox/RichTextLabel.percent_visible = 0
		var duration = float(dialog[dialog_index].length()) / float(CharacterStats.TextSpeed)
		$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$DialogBox/Tween.start()
	else:
		queue_free()
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

