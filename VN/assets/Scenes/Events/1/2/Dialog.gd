extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()

var dialog = [

	"You see children playing in the street. Suddenly one of them falls and hits the pavement painfully.",
	"You reassure your child by telling them that anything can happen in life and that everything will be fine.", 
	"You stand next to him for a long time and tell him how bad it is to run and in general you have to sit at home and obey your elders, and he would have gone to work in general, the empire needs soldiers and farmers and not juvenile morons."

]


func _ready():
	load_dialog()


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 2:
			CharacterStats.Luck += 1
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/1/Scene.tscn")
		elif dialog_index == 3:
			CharacterStats.Intelligence += 3
			CharacterStats.Luck -= 2
			CharacterStats.Charisma += 1
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/1/Scene.tscn")

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

