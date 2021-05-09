tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var rng = RandomNumberGenerator.new()
var scene

func _on_Button_pressed(choice):
	$VBoxContainer3/ChoiceButtons.visible = false
	if choice == "talk":
		rng.randomize()
		var chance = rng.randi_range(1, 100)
		if chance <= CharacterStats.Charisma * 9 + CharacterStats.Luck:
			$VBoxContainer3/VBoxContainer4/Control.load_dialog()
		else:
			$VBoxContainer3/VBoxContainer4/Control.dialog_index += 1
			$VBoxContainer3/VBoxContainer4/Control.load_dialog()
	if choice == "fight":
		_fight()

func _fight():
	rng.randomize()
	var chance = rng.randi_range(1, 100)
	if chance <= 5:
		get_tree().change_scene("res://assets/Scenes/Main scenes/3/27/Scene.tscn")
	else:
		rng.randomize()
		chance = rng.randi_range(1, 100)
		if chance <= 20:
			get_tree().change_scene("res://assets/Scenes/Main scenes/3/26/Scene.tscn")
		elif chance <= 20 + CharacterStats.Strength * 4 + CharacterStats.Agility * 3 + CharacterStats.Luck:
			get_tree().change_scene("res://assets/Scenes/Main scenes/3/28/Scene.tscn")
		else:
			get_tree().change_scene("res://assets/Scenes/Endings/0014/Scene.tscn")

func _process(_delta):
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index == 2:
		$VBoxContainer3/ChoiceButtons.visible = true
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index == 5:
		_fight()

func _ready():
	$VBoxContainer3/ChoiceButtons.visible = false
	MusicController.start("res://assets/Music/Medium/", false)
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
