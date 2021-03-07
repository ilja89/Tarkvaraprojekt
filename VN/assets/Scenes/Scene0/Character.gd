tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var dialog = [
	'You were born to a...'
]
var scene

var dialog_index = 0

func _on_Button_pressed(choice):
	CharacterStats.family = choice
	get_tree().change_scene("res://assets/Scenes/Scene0/Scene_character.tscn")

func _ready():
	CharacterStats.SaveMenu = false
	MusicController.start("res://assets/Music/1/", false)
	$VBoxContainer3/VBoxContainer4/Control.load_dialog(dialog, dialog_index)
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])
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


#	if Input.is_action_just_pressed("ui_accept"):
#	$VBoxContainer3/VBoxContainer4/Control.load_dialog(dialog, dialog_index)
#	dialog_index += 1

func save():
	var save_dict = {
		"filename" : get_tree().current_scene.filename,
		"characterf" : CharacterStats.family,
		"charactert" : CharacterStats.trait,
		"characterj" : CharacterStats.job,
		"characterm" : CharacterStats.motivation,
		"items" : Items,
		"dialog_index" : dialog_index
	}
	return save_dict
