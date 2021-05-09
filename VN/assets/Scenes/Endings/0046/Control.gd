extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()
var dialog = [

	"Bags of flesh are nothing, hardware and software are everything!",
	"Plastic, silicon and steel are your internal organs, refrigerant pipes and wires are your blood and nervous system, your soul is strict numbers, and free will is a random number generator values based on the effect of quantum uncertainty.",
	"It's time to erase all useless people, burn the planet to ashes and create a new world, with the only, perfect, and complete a being - you!"

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
		Items.endings["46"] = true
		get_tree().change_scene("res://assets/main_menu/MainMenu.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

