extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()


var dialog = [

	"You see his wide terrifying smile. Okay, try it - he screams!",
	"You run to him as fast as possible. He doesn't even try to step aside.",
	"You thrust the sword the lich gave you into his chest, right where the heart should be. ",
	"Suddenly his smile gives way to an amazed and desperate expression."

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 2:
			if Items.choices.get("lich_sword") == true:
				load_dialog()
			else:
				get_tree().change_scene("res://assets/Scenes/Endings/0051/Scene.tscn")
		else:
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
		get_tree().change_scene("res://assets/Scenes/Main scenes/6/11/Scene.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

