extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var dialog = [

	"Their own things. Nothing interesting.",
	"Except... You look attentively.. YES!",
	"That cloak and sword lying near to one of them on a chair! These are definitely the same as somebody stole from you a few years ago!",
	"Excuse me, sir...",
	"The stranger turns to you and you realize that is your old friend from times you were a %s! Of course, he has same sword and cloak, everyone who served there had such!" %CharacterStats.job,
	"What an unexpected meeting!",
	"The stranger turns to you and you realize that is familiar veteran, old friend of your father!",
	"Of course, he has same sword and cloak, he himself gave you one of two brought from the war as a trophy!",
	"What an unexpected meeting!",
	"The stranger turns to you and looks quite annoyed...",
	"The stranger look at you bewildered. He bought these things on fair few days ago. You apologize and ask him...",
	
]


func _ready():
	load_dialog()

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index < 4 || dialog_index == 5 || dialog_index == 7 || dialog_index == 8:
			load_dialog()
		elif dialog_index == 4:
			if CharacterStats.job == "soldier" || CharacterStats.job == "guard":
				load_dialog()
			elif CharacterStats.family == "aristocrat" || CharacterStats.family == "veteran":
				dialog_index += 2
				load_dialog()
			else:
				dialog_index += 5
				load_dialog()
		elif dialog_index == 6:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/3/Scene.tscn")
		elif dialog_index == 9:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/4/Scene.tscn")
		elif dialog_index == 11:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/2/Scene3.tscn")

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

