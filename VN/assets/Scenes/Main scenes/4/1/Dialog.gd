extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	'Finally, you arrived to the order. There are lots of monks, priests and knights around you. Walking, talking, preying. ',
	"What are your plans? What are you going to do?",
	"There is no arena.",
	"The holy order doesn’t have time for useless battles, they fight monsters!",
	"There is no tavern.",
	"The holy order doesn’t have time for useless wine drinking, they fight monsters instead.",
	"I hear something..."
	
]


func _ready():
	load_dialog()
	

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 4 || dialog_index == 6:
			dialog_index = 1
			load_dialog()
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
		get_tree().change_scene("res://assets/Scenes/Main scenes/4/2/Scene.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

