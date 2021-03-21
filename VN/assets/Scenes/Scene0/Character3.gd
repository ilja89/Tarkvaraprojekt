tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var scene
func _on_Button_pressed(choice):
	CharacterStats.motivation = choice
	get_tree().change_scene("res://assets/Scenes/Scene0/Scene01.tscn")


func _ready():
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])

func _process(_delta):
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index > 1:
		$VBoxContainer3/ChoiceButtons.visible = true
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/SaveButton.connect("pressed", self, "save_menu")
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/LoadButton.connect("pressed", self, "load_menu")
	$"/root/CharacterStats".connect("exit_menu", self, "_exit_menu")

func _load_menu():
	SaveGame.saving = false
	scene = preload("res://assets/GUI/SaveMenu.tscn").instance()
	add_child(scene)
	scene.add_to_group("Temporary")

func _exit_menu():
	remove_child(scene)


func _save_menu():
	SaveGame.saving = true
	scene = preload("res://assets/GUI/SaveMenu.tscn").instance()
	add_child(scene)
	scene.add_to_group("Temporary")


func save():
	var save_dict = {
		"filename" : get_tree().current_scene.filename,
		"characterf" : CharacterStats.family,
		"charactert" : CharacterStats.trait,
		"characterj" : CharacterStats.job,
		"characterm" : CharacterStats.motivation,
		"items" : Items,
		"dialog_index" : $VBoxContainer3/VBoxContainer4/Control.dialog_index
	}
	return save_dict
