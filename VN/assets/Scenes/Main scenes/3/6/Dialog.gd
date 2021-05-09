extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	'These strangers are still here. You decide to ask them about that.. necromancer.',
	"You are sitting near to a group of strangers talking about a necromancer..",
	"Interesting...You are asking them to tell you more about it."
]

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 2:
			load_dialog()
		else:
			get_tree().change_scene("res://assets/Scenes/Main scenes/3/11/Scene.tscn")


func _ready():
	if Items.choices.get("village_necromancer") == true:
		load_dialog()
	else:
		dialog_index += 1
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

