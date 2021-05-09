extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	"You are sitting in a tavern with a mug of beer near to group of strangers.",
	"They are talking about something, but you not sure about what exactly.",
	"You ask them more about it. They told you a terrifying story...",
	"I have to kill him and become a hero!",
	"You ask them more about it. They told you a terrifying story about ancient lich living in a castle... ",
	"I have to kill him and become a hero!",


]


func _ready():
	load_dialog()
	

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1:
			load_dialog()
		if dialog_index == 4:
			get_tree().change_scene("res://assets/Scenes/Main scenes/3/16/Scene.tscn")
		if dialog_index == 6:
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
		queue_free()
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

