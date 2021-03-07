extends TextureButton



func _on_ContinueButton_pressed():
	SaveGame.load_game(SaveGame.saves[SaveGame.savecount])
