tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var scene

func _on_Button_pressed(choice):
	CharacterStats.job = choice
	if choice == "soldier":
		CharacterStats.Intelligence += 0
		CharacterStats.Agility += 1
		CharacterStats.Strength += 4
		CharacterStats.Stamina += 2
		CharacterStats.Charisma += 0
		CharacterStats.Luck += 0
	elif choice == "bandit":
		CharacterStats.Intelligence += 0
		CharacterStats.Agility += 0
		CharacterStats.Strength += 2
		CharacterStats.Stamina += 1
		CharacterStats.Charisma += 0
		CharacterStats.Luck += 2
	elif choice == "guard":
		CharacterStats.Intelligence += 0
		CharacterStats.Agility += 3
		CharacterStats.Strength += 3
		CharacterStats.Stamina += 1
		CharacterStats.Charisma += 0
		CharacterStats.Luck += 0
	elif choice == "farmer":
		CharacterStats.Intelligence += 1
		CharacterStats.Agility += 0
		CharacterStats.Strength += 1
		CharacterStats.Stamina += 4
		CharacterStats.Charisma += 0
		CharacterStats.Luck += 1
	elif choice == "diviner":
		CharacterStats.Intelligence += 0
		CharacterStats.Agility += 0
		CharacterStats.Strength += 0
		CharacterStats.Stamina += 0
		CharacterStats.Charisma += 4
		CharacterStats.Luck += 3
	elif choice == "blacksmith":
		CharacterStats.Intelligence += 0
		CharacterStats.Agility += 0
		CharacterStats.Strength += 4
		CharacterStats.Stamina += 2
		CharacterStats.Charisma += 0
		CharacterStats.Luck += 0
	elif choice == "grocer":
		CharacterStats.Intelligence += 0
		CharacterStats.Agility += 0
		CharacterStats.Strength += 2
		CharacterStats.Stamina += 0
		CharacterStats.Charisma += 3
		CharacterStats.Luck += 3
	get_tree().change_scene("res://assets/Scenes/Main scenes/0/Scene_character3.tscn")


func _ready():
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
