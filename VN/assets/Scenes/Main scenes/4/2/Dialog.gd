extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var dialog = [

	"There is a prayer in the church.",
	"You are just standing near to church and waiting until prayer will finish.",
	"Why are you here?",
	"What is the reason?",
	"What is the reason of life?",
	"What is reason of universe existence?",
	"Something is taking me away ... Probably, I need to move away from the herb braziers."

]


func _ready():
	load_dialog()

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index > 1:
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
		get_tree().change_scene("res://assets/Scenes/Main scenes/4/4/Scene.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

