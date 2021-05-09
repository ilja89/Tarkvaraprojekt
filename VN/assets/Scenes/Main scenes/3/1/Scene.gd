tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var rng = RandomNumberGenerator.new()
var scene

func _on_Button_pressed(choice):
	if choice == 'village_steal':
		Items.choices[choice] = true
		$VBoxContainer3/VBoxContainer4/Control.load_dialog()
		$VBoxContainer3/ChoiceButtons/Choice.visible = false
		$VBoxContainer3/ChoiceButtons/ChoiceSteal.visible = true
	if choice == 'village_tavern_hungry':
		Items.choices[choice] = true
		get_tree().change_scene("res://assets/Scenes/Main scenes/3/4/Scene.tscn")
	if choice == 'village_work':
		Items.choices[choice] = true
		get_tree().change_scene("res://assets/Scenes/Main scenes/3/5/Scene.tscn")
	if choice == 'no':
		get_tree().change_scene("res://assets/Scenes/Main scenes/3/1/Scene.tscn")
	if choice == 'village_steal_wallet':
		Items.choices[choice] = true
		get_tree().change_scene("res://assets/Scenes/Main scenes/3/2/Scene.tscn")
	if choice == 'accomplice':
		get_tree().change_scene("res://assets/Scenes/Main scenes/3/3/Scene.tscn")
	if choice == 'village_tavern_beer':
		get_tree().change_scene("res://assets/Scenes/Main scenes/3/6/Scene.tscn")

func _ready():
	MusicController.start("res://assets/Music/Calm/", false)
	$VBoxContainer3/ChoiceButtons/Choice/TextureButton6.visible = false
	if Items.choices.get("village_steal") == true:
		$VBoxContainer3/ChoiceButtons/Choice/TextureButton3.visible = false
	if Items.choices.get("village_tavern_hungry") == true:
		$VBoxContainer3/ChoiceButtons/Choice/TextureButton4.visible = false
	if Items.choices.get("village_work") == true:
		$VBoxContainer3/ChoiceButtons/Choice/TextureButton5.visible = false
	if Items.choices.get("village_steal_wallet") == true:
		$VBoxContainer3/ChoiceButtons/ChoiceSteal/TextureButton7.visible = false
	if $VBoxContainer3/ChoiceButtons/Choice/TextureButton3.visible == false && $VBoxContainer3/ChoiceButtons/Choice/TextureButton4.visible == false && $VBoxContainer3/ChoiceButtons/Choice/TextureButton5.visible == false:
		$VBoxContainer3/ChoiceButtons/Choice/TextureButton6.visible = true
	$VBoxContainer3/ChoiceButtons/Choice.visible = true
	for button in $VBoxContainer3/ChoiceButtons/Choice.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])
	for button in $VBoxContainer3/ChoiceButtons/ChoiceSteal.get_children():
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
