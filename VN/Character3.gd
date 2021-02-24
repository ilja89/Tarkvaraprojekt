tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")

func _on_Button_pressed(choice):
	CharacterStats.motivation = choice
	$Label3.text = CharacterStats.motivation
	get_tree().change_scene("res://assets/Scenes/Scene0/Scene1.tscn")


func _ready():
	$Label.text = CharacterStats.family
	$Label2.text = CharacterStats.trait
	$Label3.text = CharacterStats.job
	$Label4.text = CharacterStats.motivation
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])

func _process(_delta):
	if $VBoxContainer3/VBoxContainer4/Control.dialog_index > 1:
		$VBoxContainer3/ChoiceButtons.visible = true
