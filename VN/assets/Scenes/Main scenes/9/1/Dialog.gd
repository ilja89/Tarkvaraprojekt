extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	'You spent some time with the bandit gang, robbing caravans. Wine, tasty food, and adrenaline! But...',
	"Is that life you always were dreaming about?",
	"You call chieftain for a duel to become a new leader!",
	"You decide to go away. You never really wanted to see yourself as bandit.",
	
]


func _ready():
	load_dialog()

func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index == 1:
			load_dialog()
		if dialog_index == 3:
			get_tree().change_scene("res://assets/Scenes/Battles/3/BattleTemplate.tscn")
		if dialog_index == 4:
			get_tree().change_scene("res://assets/Scenes/Main scenes/9/3/Scene.tscn")



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

