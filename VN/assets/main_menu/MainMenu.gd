extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scene

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.start("res://assets/Music/Calm/", false)
	if CharacterStats.FirstLaunch == true:
		load_stats()
		CharacterStats.FirstLaunch = false
	else:
		save_stats()
	$"/root/CharacterStats".connect("exit_menu", self, "_exit_menu")
	for button in $HBoxContainer/VBoxContainer/VBoxContainer/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])



func _on_Button_pressed(_scene_to_load):
	get_tree().change_scene(_scene_to_load)


func _on_ContinueButton_pressed():
	SaveGame.menu = true
	SaveGame.saving = false
	scene = preload("res://assets/GUI/SaveMenu.tscn").instance()
	add_child(scene)
	scene.add_to_group("Temporary")

func _exit_menu():
	remove_child(scene)


func _on_Gallery_pressed():
	get_tree().change_scene("res://assets/Gallery/Gallery.tscn")


func load_stats():
	var save = File.new()
	if not save.file_exists("res://Settings.json"):
		return # Error! We don't have a save to load.
	save.open("res://Settings.json", File.READ)
	while save.get_position() < save.get_len():
		Items.endings = parse_json(save.get_line())
		CharacterStats.TextSpeed = parse_json(save.get_line())
		MusicController.volume = parse_json(save.get_line())
		MusicController.is_manual_music = parse_json(save.get_line())
	save.close()

func save_stats():
	var save = File.new()
	save.open("res://Settings.json", File.WRITE)
	save.store_line(to_json(Items.endings))
	save.store_line(to_json(CharacterStats.TextSpeed))
	save.store_line(to_json(MusicController.volume))
	save.store_line(to_json(MusicController.is_manual_music))
	save.close()
