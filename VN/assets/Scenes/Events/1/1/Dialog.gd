extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()


var dialog = [

	"The beggar asks you for a coin for food.",
	"The beggar thanks you for your help, blessing you and glorifying your name", 
	"The beggar thanks you for your help, blessing you and glorifying your name"

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 2:
			rng.randomize()
			var chance = rng.randi_range(1, 100)
			if chance <= 50:
				get_tree().change_scene("res://assets/Scenes/Events/1/4/Scene.tscn")
			else:
				CharacterStats.Luck += 1
				get_tree().change_scene("res://assets/Scenes/Main scenes/2/1/Scene.tscn")
		if dialog_index == 3:
			CharacterStats.Intelligence += 1
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

