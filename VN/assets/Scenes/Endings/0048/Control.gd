extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var dialog = [

	"Now this is another chance for people to buld their own future. What will it be? Who knows...",

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
		Items.endings["48"] = true
		get_tree().change_scene("res://assets/main_menu/MainMenu.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

