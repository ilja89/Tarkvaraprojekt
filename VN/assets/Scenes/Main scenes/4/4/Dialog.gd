extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	"You see a figure in the cloak. This is the head of the order.",
	"He asks you if you would like to join them in their crusade against evil.",
	"He is waiting for your answer.",
	"I feel strange here.. Not sure I want to stay there anymore. Sorry!",
	"You are ready for war! You are brave and have a sword.",
	"He smiles cause of your enthusiasm... My son, let me tell you about..."

]


func _ready():
	load_dialog()
	

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 4:
			get_tree().change_scene("res://assets/Scenes/Main scenes/1/1/Scene01.tscn")
		elif dialog_index != 3 && dialog_index != 6:
			load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$DialogBox/RichTextLabel.bbcode_text = dialog[dialog_index]
		$DialogBox/RichTextLabel.percent_visible = 0
		var duration = float(dialog[dialog_index].length()) / float(CharacterStats.TextSpeed)
		$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$DialogBox/Tween.start()
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

