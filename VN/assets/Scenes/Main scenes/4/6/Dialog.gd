extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()


var dialog = [

	"The head of order telling you a story about ancient lich..",
	"He comes in the night…",
	"When you don’t wait for it.",
	"And takes your life..",
	"Recently, the order has found out where he is hiding. But it will be very hard to overcome him, and only a true hero can to this.",
	"Are you a true hero?",
	"Okay. At least, you have more chances to stay alive.. Let me then tell you a story about…",
	"I am a true hero. I am a god! I will kill damn lich and nobody will stop me!"

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index < 6:
			load_dialog()
		if dialog_index == 7:
			get_tree().change_scene("res://assets/Scenes/Main scenes/4/5/Scene.tscn")
		if dialog_index == 8:
			get_tree().change_scene("res://assets/Scenes/Main scenes/7/1/Scene.tscn")

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$DialogBox/RichTextLabel.bbcode_text = dialog[dialog_index]
		$DialogBox/RichTextLabel.percent_visible = 0
		var duration = float(dialog[dialog_index].length()) / float(CharacterStats.TextSpeed)
		$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$DialogBox/Tween.start()
	else:
		get_tree().change_scene("res://assets/Scenes/Main scenes/4/7/Scene.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

