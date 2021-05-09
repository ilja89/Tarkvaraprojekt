tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var rng = RandomNumberGenerator.new()
var scene
var chance1 = 10 - CharacterStats.Luck
var chance2 = 10 - CharacterStats.Intelligence
var chance3 = CharacterStats.Intelligence + CharacterStats.Luck + CharacterStats.Charisma / 4



func _on_Button_pressed(choice):
	$VBoxContainer3/ChoiceButtons.visible = false
	if choice == "was":
		$VBoxContainer3/VBoxContainer4/Control.load_dialog()
	if choice == "no":
		rng.randomize()
		var chance = rng.randi_range(1, chance1 + chance2 + chance3)
		if chance <= chance1:
			get_tree().change_scene("res://assets/Scenes/Endings/0027/Scene.tscn")
		elif chance <= chance1 + chance2:
			$VBoxContainer3/VBoxContainer4/Control.dialog_index += 2
			$VBoxContainer3/VBoxContainer4/Control.load_dialog()
		else:
			get_tree().change_scene("res://assets/Scenes/Endings/0029/Scene.tscn")
		
func _process(_delta):
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index == 2:
		$VBoxContainer3/ChoiceButtons.visible = true
	

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
