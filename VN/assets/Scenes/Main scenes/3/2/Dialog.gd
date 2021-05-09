extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var dialog = [

	"You are standing on the market square, looking for someone to steal wallet from. And looks like you found him...",
	"You successfully stole the wallet!",
	"People saw you stealing the wallet!"

]


func _ready():
	load_dialog()

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1:
			rng.randomize()
			var chance = rng.randi_range(1, 100)
			if chance <= CharacterStats.Agility * 7 + CharacterStats.Luck * 3:
				load_dialog()
			else:
				dialog_index +=1
				load_dialog()
		elif dialog_index == 2:
			get_tree().change_scene("res://assets/Scenes/Main scenes/3/1/Scene.tscn")
		elif dialog_index == 3:
			get_tree().change_scene("res://assets/Scenes/Main scenes/3/7/Scene.tscn")


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

