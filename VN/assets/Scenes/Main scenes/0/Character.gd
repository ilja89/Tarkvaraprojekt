tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")


var scene


func _on_Button_pressed(choice):
	CharacterStats.family = choice
	if choice == "farmer":
		CharacterStats.Intelligence += 1
		CharacterStats.Agility += 2
		CharacterStats.Strength += 2
		CharacterStats.Stamina += 4
		CharacterStats.Charisma += 2
		CharacterStats.Luck += 1
	elif choice == "veteran":
		CharacterStats.Intelligence += 2
		CharacterStats.Agility += 4
		CharacterStats.Strength += 6
		CharacterStats.Stamina += 3
		CharacterStats.Charisma += 2
		CharacterStats.Luck += 1
	elif choice == "aristocrat":
		CharacterStats.Intelligence += 3
		CharacterStats.Agility += 2
		CharacterStats.Strength += 2
		CharacterStats.Stamina += 3
		CharacterStats.Charisma += 4
		CharacterStats.Luck += 2
	elif choice == "alchemist":
		CharacterStats.Intelligence += 4
		CharacterStats.Agility += 2
		CharacterStats.Strength += 2
		CharacterStats.Stamina += 2
		CharacterStats.Charisma += 2
		CharacterStats.Luck += 4
	elif choice == "priest":
		CharacterStats.Intelligence += 4
		CharacterStats.Agility += 2
		CharacterStats.Strength += 2
		CharacterStats.Stamina += 4
		CharacterStats.Charisma += 2
		CharacterStats.Luck += 3
	elif choice == "artist":
		CharacterStats.Intelligence += 2
		CharacterStats.Agility += 5
		CharacterStats.Strength += 2
		CharacterStats.Stamina += 3
		CharacterStats.Charisma += 5
		CharacterStats.Luck += 2
	elif choice == "orphan":
		CharacterStats.Intelligence += 1
		CharacterStats.Agility += 2
		CharacterStats.Strength += 2
		CharacterStats.Stamina += 3
		CharacterStats.Charisma += 2
		CharacterStats.Luck += 5
	get_tree().change_scene("res://assets/Scenes/Main scenes/0/Scene_character.tscn")

func _ready():
	CharacterStats.SaveMenu = false
	MusicController.start("res://assets/Music/Calm/", false)
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/SaveButton.connect("pressed", self, "_save_menu")
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/LoadButton.connect("pressed", self, "_load_menu")
	$"/root/CharacterStats".connect("exit_menu", self, "_exit_menu")
	CharacterStats.Intelligence = 0
	CharacterStats.Agility = 0
	CharacterStats.Strength = 0
	CharacterStats.Stamina = 0
	CharacterStats.Charisma = 0
	CharacterStats.Luck = 0
	Items.choices["village_steal"] = false
	Items.choices["village_tavern_hungry"] = false
	Items.choices["village_work"] = false
	Items.choices["village_steal_wallet"] = false
	Items.choices["village_tavern_beer"] = false
	Items.choices["village_necromancer"] = false
	Items.choices["tavern_accomplice_friend"] = false
	Items.choices["lich_sword"] = false
	Items.choices["town_walk"] = false

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
