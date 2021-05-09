extends Control


export var dialog_index = 0
var finished = false
var rng = RandomNumberGenerator.new()


var dialog = [

	"According to what is written, the puddle on the floor is only a weak symptom of impending disaster - the breakthrough of primordial evil into your world through the thinned dimensional layer.",
	"The mechanism is needed in order to patch it up, otherwise, literally a few years later, this world is doomed.",
	"A mouse thrown into a puddle turns into a terrible monster, which all of you together barely managed to defeat.",
	"You realize that by all appearances, you will have to continue the terrible deed of the one whom you so carelessly killed…",

]


func _ready():
	load_dialog()


func _process(_delta):

	if Input.is_action_just_pressed("ui_accept"):
		if dialog_index < 4:
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
		queue_free()
	dialog_index += 1



func _on_Tween_tween_completed(_object, _key):
	finished = true

