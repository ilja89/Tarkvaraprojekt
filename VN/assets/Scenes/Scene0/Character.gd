tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")


func _on_Button_pressed(choice):
	CharacterStats.family = choice
	$Label.text = CharacterStats.family
	get_tree().change_scene("res://assets/Scenes/Scene0/Scene_character.tscn")

func _ready():
	$Label.text = CharacterStats.family
	$Label2.text = CharacterStats.trait
	$Label3.text = CharacterStats.job
	$Label4.text = CharacterStats.motivation
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])

