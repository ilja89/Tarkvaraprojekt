tool
extends Node

#onready var CharacterStats = get_node("/root/Stats.gd")


func _on_Button_pressed(choice):

	get_tree().change_scene("res://assets/Scenes/Scene0/Scene2.tscn")


func _ready():
	$Label.text = CharacterStats.family
	$Label2.text = CharacterStats.trait
	$Label3.text = CharacterStats.job
	$Label4.text = CharacterStats.motivation
	for button in $VBoxContainer3/ChoiceButtons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.choice])



func save():
	var save_dict = {
		"filename" : get_tree().edited_scene_root.filename,
		"characterstats" : CharacterStats,
		"items" : Items,
		"dialog_index" : $VBoxContainer3/VBoxContainer4/Control.dialog_index
	}
	return save_dict
