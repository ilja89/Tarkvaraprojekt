tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")

func _on_Button_pressed(choice):
	CharacterStats.job = choice
	$Label3.text = CharacterStats.job
	get_tree().change_scene("res://assets/Scenes/Scene0/Scene_character3.tscn")

#var rng = RandomNumberGenerator.new()
#func rng():
#	rng.randomize()
#	var my_random_number = rng.randf_range(0, 60)
#	if my_rand_number <


func _ready():
	$Label.text = CharacterStats.family
	$Label2.text = CharacterStats.trait
	$Label3.text = CharacterStats.job
	$Label4.text = CharacterStats.motivation
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])

