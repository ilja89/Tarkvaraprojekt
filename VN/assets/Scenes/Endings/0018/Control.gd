extends Control


var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var dialog = [

	"You have laughed enough at the cunning of the necromancer that even after death tried to deceive you. After burning all the records and breaking the incomprehensible device, the souls are freed from captivity. ",
	"The people greet you as their saviors, and even the king is amazed by your feat! He rewards you all with the title of baron. You are heroes forever!"

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 2:
			rng.randomize()
			var chance = rng.randi_range(1, 100)
			if chance <= 30:
				get_tree().change_scene("res://assets/Scenes/Endings/0019/Scene.tscn")
			else:
				load_dialog()
		else:
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
		Items.endings["18"] = true
		get_tree().change_scene("res://assets/main_menu/MainMenu.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

