extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()

var dialog = [

	"God, listen to me…",
	"Help me to kill my enemies…",
	"Help me to live longer…",
	"Help me to help others…",
	"Help me to get rid of evil creatures in this world…",
	"Prayer ends."

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
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
		rng.randomize()
		var chance = rng.randi_range(1, 6)
		if chance == 1:
			CharacterStats.Strength += 1
		elif chance == 2:
			CharacterStats.Stamina += 1
		elif chance == 3:
			CharacterStats.Agility += 1
		elif chance == 4:
			CharacterStats.Charisma += 1
		elif chance == 5:
			CharacterStats.Luck += 1
		elif chance == 6:
			CharacterStats.Intelligence += 1
		get_tree().change_scene("res://assets/Scenes/Main scenes/4/4/Scene.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

