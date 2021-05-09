extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	"You enter the temple.", 
	"That is really… Impressive place.",
	"Suddenly you see a high figure of artifact guard. You will have to fight!"

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
		get_tree().change_scene("res://assets/Scenes/Battles/4/BattleTemplate.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

