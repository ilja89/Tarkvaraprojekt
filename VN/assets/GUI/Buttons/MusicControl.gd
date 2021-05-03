extends Control

var play = load("res://assets/GUI/play.png")
var pause = load("res://assets/GUI/pause.png")

func _on_Play_toggled(button_pressed):
	MusicController.pause()
	if button_pressed == true:
		$MarginContainer/HBoxContainer/Play.icon = pause
	else:
		$MarginContainer/HBoxContainer/Play.icon = play

func _process(_delta):
	$MarginContainer/VBoxContainer/TextureProgress.value = MusicController.progress

func _on_Next_pressed():
	MusicController.next()


func _on_Prev_pressed():
	MusicController.previous()
