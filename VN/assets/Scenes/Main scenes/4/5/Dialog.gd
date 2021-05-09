extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()


var dialog = [

	"The head of order telling you a story about… ",
	"A necromancer, who lives in the mountains and comes down to abduct people and collect their souls.",
	"Well…", 
	"You've already heard that… So boring…"

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1:
			if Items.choices.get("village_necromancer") == true:
				dialog_index += 1
			load_dialog()
		elif dialog_index == 2:
			get_tree().change_scene("res://assets/Scenes/Main scenes/4/7/Scene.tscn")
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
		get_tree().change_scene("res://assets/Scenes/Main scenes/4/7/Scene.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

