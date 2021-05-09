extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var chance1
var chance2
var chance3

var dialog = [

	"The leader of bandits looks very... satisfied...",
	"Look, we don't even need to look for victims anywhere ... He himself came to us so that we could take everything he has from him!",
	"You tell them the story of your life and how you got here. Hearin all that they decide to take you in their gang.",
	"They are not satisfied with that you said. Their leader comes closer to you...",
	"You will fight!",
	"",

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 3:
			get_tree().change_scene("res://assets/Scenes/Main scenes/9/1/Scene.tscn")
		elif dialog_index != 2:
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

