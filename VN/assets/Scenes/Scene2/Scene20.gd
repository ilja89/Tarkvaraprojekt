extends MarginContainer

var scene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/SaveButton.connect("pressed", self, "save_menu")
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/LoadButton.connect("pressed", self, "load_menu")
	$"/root/CharacterStats".connect("exit_menu", self, "_exit_menu")

func load_menu():
	scene = preload("res://assets/GUI/SaveMenu.tscn").instance()
	add_child(scene)
	scene.add_to_group("Temporary")

func _exit_menu():
	remove_child(scene)

func save_menu():
	$LineEdit.visible = true
	$LineEdit.grab_focus()


func _on_LineEdit_text_entered(new_text):
	SaveGame.save_game(new_text)
	$LineEdit.visible = false
	$LineEdit.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
