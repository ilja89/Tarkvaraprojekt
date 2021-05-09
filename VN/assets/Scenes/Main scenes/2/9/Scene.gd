tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")
var rng = RandomNumberGenerator.new()
var scene
var R = 0
var G = 0
var Y = 0
var index = 0


func _on_Button_pressed(choice):
	index += 1
	if choice == "R":
		R += 1
	elif choice == "G":
		G += 1
	elif choice == "Y":
		Y += 1
	
	if index == 1:
		$VBoxContainer3/ChoiceButtons/TextureButton1.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton2.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton3.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton4.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton5.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton6.visible = true
	if index == 2:
		$VBoxContainer3/ChoiceButtons/TextureButton4.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton5.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton6.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton7.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton8.visible = true
		$VBoxContainer3/ChoiceButtons/TextureButton9.visible = true
	if index == 3:
		$VBoxContainer3/ChoiceButtons/TextureButton7.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton8.visible = false
		$VBoxContainer3/ChoiceButtons/TextureButton9.visible = false
		if R > Y && R > G:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/10/SceneR.tscn")
		elif Y > R && Y > G:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/10/SceneY.tscn")
		else:
			get_tree().change_scene("res://assets/Scenes/Main scenes/2/10/SceneG.tscn")
	$VBoxContainer3/VBoxContainer4/Control.load_dialog()



func _ready():
	MusicController.start("res://assets/Music/Agressive/", false)
	$VBoxContainer3/ChoiceButtons.visible = false
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/SaveButton.connect("pressed", self, "_save_menu")
	$VBoxContainer3/VBoxContainer4/Control/GUI/VBoxContainer/MarginContainer/BottomMenu/Buttons/LoadButton.connect("pressed", self, "_load_menu")
	$"/root/CharacterStats".connect("exit_menu", self, "_exit_menu")

func _process(delta):
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index == 2:
		$VBoxContainer3/ChoiceButtons.visible = true


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
