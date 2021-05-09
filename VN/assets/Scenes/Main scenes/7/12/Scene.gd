tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var rng = RandomNumberGenerator.new()
var scene

func _on_Button_pressed(choice):
	if choice == "accept":
		$VBoxContainer3/VBoxContainer4/Control.load_dialog()
		$VBoxContainer3/ChoiceButtons/TextureButton3.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton4.visible = false
		if CharacterStats.motivation == "suicidal":
			$VBoxContainer3/ChoiceButtons/TextureButton5.visible = true
		if CharacterStats.motivation == "dragon":
			$VBoxContainer3/ChoiceButtons/TextureButton6.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton7.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton8.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton9.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton10.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton11.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton12.visible = true
	if choice == "death":
		get_tree().change_scene("res://assets/Scenes/Main scenes/7/13/Scene.tscn")
	if choice == "dragon":
		get_tree().change_scene("res://assets/Scenes/Main scenes/7/16/Scene.tscn")
	if choice == "discover":
		get_tree().change_scene("res://assets/Scenes/Endings/0055/Scene.tscn")
	if choice == "evil":
		get_tree().change_scene("res://assets/Scenes/Endings/0056/Scene.tscn")
	if choice == "goal":
		get_tree().change_scene("res://assets/Scenes/Endings/0054/Scene.tscn")

func _process(_delta):
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index == 1:
		$VBoxContainer3/ChoiceButtons.visible = true

func _ready():
	$VBoxContainer3/ChoiceButtons.visible = false
	MusicController.start("res://assets/Music/Agressive/", false)
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/SaveButton.connect("pressed", self, "_save_menu")
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/LoadButton.connect("pressed", self, "_load_menu")
	$"/root/CharacterStats".connect("exit_menu", self, "_exit_menu")


func _load_menu():
	get_tree().paused = true
	SaveGame.menu = false 
	SaveGame.saving = false
	scene = preload("res://assets/GUI/SaveMenu.tscn").instance()
	add_child(scene)
	scene.add_to_group("Temporary")

func _exit_menu():
	remove_child(scene)
	get_tree().paused = false

func _save_menu():
	get_tree().paused = true
	SaveGame.menu = false 
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
		"characterint" : CharacterStats.Intelligence,
		"characteragi" : CharacterStats.Agility,
		"characterstr" : CharacterStats.Strength,
		"charactersta" : CharacterStats.Stamina,
		"charactercha" : CharacterStats.Charisma,
		"characterluc" : CharacterStats.Luck,
		"dialog_index" : $VBoxContainer3/VBoxContainer4/Control.dialog_index
	}
	return save_dict
