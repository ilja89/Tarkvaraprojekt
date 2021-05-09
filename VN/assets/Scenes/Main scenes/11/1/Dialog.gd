extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	"Now you are leader of group of prowlers, thugs and villains.",
	"You feel yourself kinda satisfied. What an amazing career!",
	"But do you want to be a chieftain forever?",
	"I want something better.. I want to be.. A king! An emperor!",
	"You heard something about elder artifact.. A thing, what gives infinite power to it’s owner!",
	"You want it!"

]


func _ready():
	load_dialog()
	
func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index != 3:
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
		get_tree().change_scene("res://assets/Scenes/Main scenes/11/2/Scene.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

