extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var dialog = [

	"Your head is on the scaffold, covered in blood, but you are not dead. ",
	"You feel incredible strength in yourself ... How funny ... ",
	"You effortlessly break the shackles, freeing yourself. ",
	"The crowd around you is watching you in silent horror. ",
	"You are not a human and never used to be. But who are you and what will you do?",
	"",

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 5:
			rng.randomize()
			var chance = rng.randi_range(1, 100)
			if chance <= 5:
				get_tree().change_scene("res://assets/Scenes/Main scenes/10/1/Scene.tscn")
			elif chance <= 20:
				get_tree().change_scene("res://assets/Scenes/Main scenes/10/2/Scene.tscn")
			else: 
				dialog_index += 1
		elif dialog_index < 5:
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

