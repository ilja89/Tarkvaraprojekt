extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()

var dialog = [

	"You see people dancing in the street.",
	"You joined the group enthusiastically, but after a few moves you tripped and fell. Leaving you with a bloody nose and a fistful of embarrassment.", 
	"You managed to impress everyone with your dance moves. A local girl was blown away and gave you a trinket hoping to start a conversation, but you already left before she could muster the courage to ask anything."

]


func _ready():
	load_dialog()


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 2:
			CharacterStats.Charisma -= 3
			CharacterStats.Strength += 1
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/1/Scene.tscn")
		elif dialog_index == 3:
			CharacterStats.Luck += 2
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

