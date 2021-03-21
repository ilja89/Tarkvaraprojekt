extends Control

onready var _buttons = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
onready var _dialog = $MarginContainer/AcceptDialog
onready var _TextBox = $MarginContainer/AcceptDialog/LineEdit
var selected_game

var save_name

func _ready():
	_dialog.register_text_enter(_TextBox)
	if SaveGame.saving == true:
		_dialog.visible = true
		_TextBox.grab_focus()
	_TextBox.connect("text_entered", self, "_on_LineEdit_text_entered")
	_list_files()

func _list_files():
	selected_game = null
	for button in _buttons.get_children():
		button.queue_free()
	SaveGame.list_files_in_directory("res://saves/")
	for i in SaveGame.savecount: 
		var button = Button.new()
		button.text = SaveGame.saves[i]
		button.flat = true
		_buttons.add_child(button)
	for button in _buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.text])


func _on_Button_pressed(text):
	selected_game = text



func _on_Back_pressed():
	CharacterStats.emit_signal("exit_menu")


func _on_Load_pressed():
	if selected_game != null:
		SaveGame.load_game(selected_game)


func _on_Delete_pressed():
	if selected_game != null:
		var dir = Directory.new()
		dir.remove("res://saves/%s" %selected_game)
		for button in _buttons.get_children():
			if button.text == selected_game:
				button.queue_free()
		SaveGame.savecount -= 1
		selected_game = null

func _on_Save_pressed():
#	$MarginContainer/LineEdit.visible = true
	_dialog.visible = true
	_TextBox.grab_focus()
	

func _on_LineEdit_text_entered(new_text : String):
	var cancelled = 0
	for i in SaveGame.savecount:
		if "%s.save"%new_text == SaveGame.saves[i]:
			$MarginContainer/ConfirmationDialog.visible = true
			save_name = new_text
			cancelled = 1
	if cancelled != 1:
		_save_game(new_text)



func _save_game(new_text):
	SaveGame.save_game(new_text)
	_dialog.visible = false
	_TextBox.clear()
	SaveGame.saving = false
	_on_Back_pressed()


func _on_AcceptDialog_confirmed():
	_on_LineEdit_text_entered(save_name)


func _on_LineEdit_text_changed(new_text):
	save_name = new_text


func _on_ConfirmationDialog_confirmed():
	_save_game(save_name)
	_TextBox.clear()
