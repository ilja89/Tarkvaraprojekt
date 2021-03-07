extends Control


export var dialog_index = 0
var finished = false

var dialog = [

	'You come up to a crossroads',
	"You walk for hours, but the scenery around you doesn't change",
	"Suddenly, you find yourself back at the crossroads"
	
]


func _ready():
	load_dialog()
	

func _process(_delta):
#	$DialogBox/VBoxContainer/NextIcon.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index > 1:
			load_dialog()


func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$DialogBox/RichTextLabel.bbcode_text = dialog[dialog_index]
		$DialogBox/RichTextLabel.percent_visible = 0
		$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$DialogBox/Tween.start()
	else:
		queue_free()
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

