extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()

var dialog = [

	"But your accomplice wants more money!",
	"Well, you are not so rich as ten minutes before, but at least, you are free, have money left...",
	"You convinced them.",
	"You failed.",
	"Seems like we won’t be able to agree..."

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 2:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/15/Scene.tscn")
		elif dialog_index == 3:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/15/Scene.tscn")
		elif dialog_index == 4:
			load_dialog()
		elif dialog_index == 5:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/16/Scene.tscn")

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

