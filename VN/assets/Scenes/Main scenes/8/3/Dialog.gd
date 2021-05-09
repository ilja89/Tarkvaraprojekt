extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()

var dialog = [

	"While traveling in one of the crevices, you accidentally discover a strange stone with runes on it. ",
	"You feel the power coming from it. Probably, despite the obvious antiquity, the magic stone can still do something. ",
	"But do you want to touch it?",
	"I'm not sure it is safe.",
	"You are touching the stone...",
	"It was a runical stone with a necromantic  skeleton revitalization spell! ",
	"The skeleton inside you is now alive! ",
	"It was a runical stone with a communication module!",
	"You are absolutely sure that you can convince anyone of anything ... ",
	"If you're dealing with a lame dwarf between the ages of 59 and 60! ",
	"It was a runical stone with a brain enhancement module! ",
	"You feel unlimited possibilities ... In the field of tongue twisters! ",
	"It was a runical stone with a physical enhancement module!",
	"You feel incredible strength ... In the little toe on your left foot! "

]


func _ready():
	load_dialog()
	

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 4 || dialog_index == 7 || dialog_index == 10 || dialog_index == 12 || dialog_index == 14:
			get_tree().change_scene("res://assets/Scenes/Main scenes/8/2/Scene.tscn")
		elif dialog_index == 5:
			rng.randomize()
			var chance = rng.randi_range(1, 100)
			if chance <= 25:
				CharacterStats.Strength += 1
				CharacterStats.Agility += 1
				CharacterStats.Intelligence += 1
				load_dialog()
			elif chance <= 50:
				CharacterStats.Charisma += 1
				dialog_index += 2
				load_dialog()
			elif chance <= 75:
				CharacterStats.Intelligence += 1
				dialog_index += 5
				load_dialog()
			else:
				CharacterStats.Strength += 1
				dialog_index += 7
				load_dialog()
		elif dialog_index != 3:
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

