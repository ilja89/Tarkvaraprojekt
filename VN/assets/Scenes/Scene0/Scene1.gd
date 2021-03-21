tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var rng = RandomNumberGenerator.new()
var scene

func _on_Button_pressed(choice):
	if choice == 'forest':
		get_tree().change_scene("res://assets/Scenes/Scene3/Scene30.tscn")
	if choice == 'return':
		get_tree().change_scene("res://assets/Scenes/Scene4/Scene40.tscn")
	if choice == 'city':
		get_tree().change_scene("res://assets/Scenes/Scene5/Scene50.tscn")
	if choice == 'mystic':
		$VBoxContainer3/ChoiceButtons.visible = false
		if CharacterStats.motivation == 'suicidal':
			rng.randomize()
			var chance = rng.randi_range(0, 100)
			if chance < 60:
				$VBoxContainer3/VBoxContainer4/Control.load_dialog()
			else:
				get_tree().change_scene("res://assets/Scenes/Scene2/Scene20.tscn")

func _process(_delta):
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index > 2:
		$VBoxContainer3/ChoiceButtons/TextureButton6.visible = false
		$VBoxContainer3/ChoiceButtons.visible = true

func _ready():
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])
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
