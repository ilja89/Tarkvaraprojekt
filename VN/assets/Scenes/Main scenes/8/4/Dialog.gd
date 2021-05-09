extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	"Arriving, you and the knights find a necromancer during a terrible ritual of sacrifice, and kill him on the spot.The necromancer clearly did not expect this and did not have time to do anything. ",
	"His last words were: 'Idiots, I just want to ...' He does not have time to finish because his head is blown off with the sword, and the altar was sprinkled with his blood..."

	
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
		get_tree().change_scene("res://assets/Scenes/Main scenes/8/5/Scene.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

