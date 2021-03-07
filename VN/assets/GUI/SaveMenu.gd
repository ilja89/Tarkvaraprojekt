extends Control

onready var _buttons = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer

func _ready():
	for button in _buttons.get_children():
		remove_child(button)
	SaveGame.list_files_in_directory("res://saves/")
	for i in SaveGame.savecount: 
		var button = Button.new()
		button.text = SaveGame.saves[i]
		button.flat = true
		_buttons.add_child(button)
	for button in _buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.text])

func _on_Button_pressed(text):
	SaveGame.load_game(text)

func _on_Back_pressed():
	CharacterStats.emit_signal("exit_menu")
