extends Control


var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var dialog = [

	"The revolution has failed! You don't know how it happened exactly, but you are now standing on a scaffold, and the executioner raises an axe!",
	"The last thing you remember - is dull shine of steel and drops of blood on the boards.",
	"YOUR REVOLUTION FAILED AND YOU WERE EXECUTED"

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1:
			rng.randomize()
			var chance = rng.randi_range(1, 100)
			if chance <= 5:
				get_tree().change_scene("res://assets/Scenes/Endings/0039/Scene.tscn")
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
		Items.endings["7"] = true
		get_tree().change_scene("res://assets/main_menu/MainMenu.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

