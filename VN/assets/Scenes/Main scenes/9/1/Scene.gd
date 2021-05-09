tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var rng = RandomNumberGenerator.new()
var scene

func _on_Button_pressed(choice):
	$VBoxContainer3/ChoiceButtons/TextureButton3.visible = false
	$VBoxContainer3/ChoiceButtons/TextureButton4.visible = false
	if choice == 'yes':
		if CharacterStats.Strength > 6 && CharacterStats.Agility > 6:
			get_tree().change_scene("res://assets/Scenes/Main scenes/9/2/Scene.tscn")
		else:
			rng.randomize()
			var chance = rng.randi_range(1, 100)
			if chance <= 60 + CharacterStats.Luck * 4:
				get_tree().change_scene("res://assets/Scenes/Endings/0020/Scene.tscn")
			else:
				get_tree().change_scene("res://assets/Scenes/Endings/0021/Scene.tscn")
	if choice == 'no':
		$VBoxContainer3/ChoiceButtons/TextureButton5.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton6.visible = true
	if choice == "more":
		$VBoxContainer3/ChoiceButtons/TextureButton5.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton6.visible = false
		$VBoxContainer3/VBoxContainer4/Control.load_dialog()
	if choice == "leave":
		$VBoxContainer3/ChoiceButtons/TextureButton5.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton6.visible = false
		$VBoxContainer3/VBoxContainer4/Control.dialog_index += 1
		$VBoxContainer3/VBoxContainer4/Control.load_dialog()

func _process(_delta):
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index == 2:
		$VBoxContainer3/ChoiceButtons.visible = true

func _ready():
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
