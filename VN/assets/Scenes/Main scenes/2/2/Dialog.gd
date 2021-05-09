extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var dialog = [

	"You are sitting in a tavern with a mug of beer, when you hear what strangers near to you are talking about...",
	"",
	"They tell you, that they are group of scientists - magicians, who invented a device, that brings luck to everyone it is used on.",
	"They offer you to be a test subject. You agree.",
	"They tell you, what they are completely satisfied with king's govenment. But why you aren't? Are you a revolutionary?!",
	"They are bank workers. They complain to you about stupid and non-working safety systems of bank they work in.",
	"INTERESTING!"

]


func _ready():
	load_dialog()

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1:
			rng.randomize()
			var chance = rng.randi_range(1, 100)
			if chance <= 40:
				get_tree().change_scene("res://assets/Scenes/Main scenes/2/2/Scene2.tscn")
			else:
				dialog_index +=1
		elif dialog_index == 3 || dialog_index == 6:
			load_dialog()
		elif dialog_index == 4:
			get_tree().change_scene("res://assets/Scenes/Main scenes/5/1/Scene.tscn")
		elif dialog_index == 5:
			get_tree().change_scene("res://assets/Scenes/Endings/0006/Scene.tscn")
		elif dialog_index == 7:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/6/Scene.tscn")

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

