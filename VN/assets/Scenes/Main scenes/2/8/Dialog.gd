extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()

var dialog = [

	'You spend days in the city, looking for someone to work with. Finally, you find accomplice, one of them is...',
	"Cat. Magical cat.",
	"A criminal you found in the tavern.",
	"Your old friend!"

]


func _ready():
	load_dialog()
	

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1:
			rng.randomize()
			var chance = rng.randi_range(1, 100)
			if chance <= 10:
				load_dialog()
			chance = rng.randi_range(1, 100)
			if chance <= (40 - CharacterStats.Luck) * (3 - CharacterStats.Charisma):
				dialog_index += 1
				load_dialog()
			else: 
				dialog_index += 2
				Items.choices["tavern_accomplice_friend"] = true
				load_dialog()
		elif dialog_index == 2:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/12/Scene2.tscn")
		elif dialog_index > 2:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/12/Scene.tscn")


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

