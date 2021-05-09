extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var chance1
var chance2
var chance3

var dialog = [

	"They are starting to tell you a story about angry dragon...",
	"I KNOW THAT! TELL ME WHERE HE LIVE! HE BLOWN UP MY FUCKING HOUSE!!!",
	"They tell you about dragon location. Here you go...",

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
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
		get_tree().change_scene("res://assets/Scenes/Main scenes/6/1/Scene.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

