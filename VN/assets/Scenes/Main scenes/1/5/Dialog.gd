extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var chance1
var chance2
var chance3

var dialog = [

	"Suddenly you see something between the trees. That is hunter! Finally, maybe someone will tell you where to go.",
	"He doesn't speak very clearly, you have trouble understanding him.",
	"After careful listening you finally understood him. He told you about a village and a castle if the local order.",
	"You didn't completely understand him, but you're sure he told you about a village and a castle of the local order.",
	"You thank him and decide to go to..."

]


func _ready():
	load_dialog()
	chance1 = CharacterStats.Luck + CharacterStats.Intelligence
	chance2 = (CharacterStats.Luck / 2) + 5 - CharacterStats.Intelligence
	chance3 = 5 - CharacterStats.Luck + 5 - CharacterStats.Intelligence

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1 || dialog_index == 4:
			load_dialog()
		if dialog_index == 2:
			if chance3 < 0:
				if chance2 < 0:
					load_dialog()
					dialog_index += 1
				else:
					rng.randomize()
					var chance = rng.randi_range(0, chance1 + chance2)
					if chance <= chance1:
						load_dialog()
						dialog_index += 1
					else:
						dialog_index += 1
						load_dialog()
			elif chance3 >= 0:
				if chance2 < 0:
					rng.randomize()
					var chance = rng.randi_range(0, chance1 + chance3)
					if chance <= chance1:
						load_dialog()
						dialog_index += 1
					else:
						get_tree().change_scene("res://assets/Scenes/Main scenes/1/8/Scene.tscn")
				else:
					rng.randomize()
					var chance = rng.randi_range(0, chance1 + chance2 + chance3)
					if chance <= chance3:
						get_tree().change_scene("res://assets/Scenes/Main scenes/1/8/Scene.tscn")
					elif chance <= chance2 + chance3:
						dialog_index += 1
						load_dialog()
					else:
						load_dialog()
						dialog_index += 1 

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

