tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var rng = RandomNumberGenerator.new()
var scene

func _on_Button_pressed(choice):
	$VBoxContainer3/ChoiceButtons/TextureButton3.visible = false
	$VBoxContainer3/ChoiceButtons/TextureButton4.visible = false
	if choice == "no":
		$VBoxContainer3/VBoxContainer4/Control.load_dialog()
	elif choice == "yes":
		rng.randomize()
		var chance = rng.randi_range(1, 500)
		if chance <= 100:
			$VBoxContainer3/VBoxContainer4/Control.dialog_index += 1
			$VBoxContainer3/VBoxContainer4/Control.load_dialog()
		elif chance <= 200:
			CharacterStats.Strength += 1
			$VBoxContainer3/VBoxContainer4/Control.dialog_index += 2
			$VBoxContainer3/VBoxContainer4/Control.load_dialog()
		elif chance <= 300:
			CharacterStats.Intelligence += 1
			$VBoxContainer3/VBoxContainer4/Control.dialog_index += 3
			$VBoxContainer3/VBoxContainer4/Control.load_dialog()
		elif chance <= 400:
			CharacterStats.Charisma += 1
			$VBoxContainer3/VBoxContainer4/Control.dialog_index += 4
			$VBoxContainer3/VBoxContainer4/Control.load_dialog()
		elif chance <= 500:
			get_tree().change_scene("res://assets/Scenes/Endings/0005/Scene.tscn")
	if choice == "village":
		get_tree().change_scene("res://assets/Scenes/Main scenes/1/3/Scene.tscn")
	if choice == "castle":
		get_tree().change_scene("res://assets/Scenes/Main scenes/4/1/Scene.tscn")


func _ready():
	MusicController.start("res://assets/Music/Calm/", false)
	$VBoxContainer3/ChoiceButtons.visible = false
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/SaveButton.connect("pressed", self, "_save_menu")
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/LoadButton.connect("pressed", self, "_load_menu")
	$"/root/CharacterStats".connect("exit_menu", self, "_exit_menu")

func _process(delta):
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index == 2:
		$VBoxContainer3/ChoiceButtons.visible = true
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index == 8:
		$VBoxContainer3/ChoiceButtons/TextureButton5.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton6.visible = true

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
