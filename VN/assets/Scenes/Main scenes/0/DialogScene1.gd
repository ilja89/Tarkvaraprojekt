extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	"You hear a loud roar and see a huge beast running towards you.",
	"You have woken up the bear. OMG THE BEAR!!!!!",
	"You ran away from the bear."
]


func _ready():
	load_dialog()
	

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1:
			load_dialog()
		elif dialog_index == 2:
			if CharacterStats.Agility > 6:
				load_dialog()
			elif CharacterStats.Strength > 7:
				get_tree().change_scene("res://assets/Scenes/Main scenes/1/10/Scene.tscn")
			else:
				get_tree().change_scene("res://assets/Scenes/Endings/0004/Scene.tscn")
		elif dialog_index == 3:
			get_tree().change_scene("res://assets/Scenes/Main scenes/1/5/Scene.tscn")

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

