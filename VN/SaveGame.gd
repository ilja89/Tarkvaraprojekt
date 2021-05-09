extends Node

var saving = false
var saves = []
var savecount
var bar
var menu : bool

func _ready():
	list_files_in_directory("res://saves/")
	savecount = saves.size()

func save_game(filename : String):
	list_files_in_directory("res://saves/")
	var save_game = File.new()
	var savepath
	if filename == "":		#if no filename is provided
		bar = false
		for i in savecount + 1:
			for j in savecount:
				if "savegame%d.save" %i == saves[j]:
					bar = true
					break
			if not bar:
				savepath = "res://saves/savegame%d.save" %i
				break
			elif bar :
				bar = false
	else:
		savepath = "res://saves/%s.save" %filename
#	if savecount == 0:
#		savepath = "res://saves/savegame0.save"
	save_game.open(savepath, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("saved")
	for node in save_nodes:
		var node_data = node.call("save")
		save_game.store_line(to_json((node_data)))
	save_game.store_line(to_json(Items.choices))
	save_game.close()
	list_files_in_directory("res://saves/")

func load_game(savegame):
	var save_game = File.new()
	if not save_game.file_exists("res://saves/%s" %savegame):
		return # Error! We don't have a save to load.
	save_game.open("res://saves/%s" %savegame, File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		for i in node_data.keys():
			CharacterStats.family = node_data['characterf']
			CharacterStats.trait = node_data['charactert']
			CharacterStats.job = node_data['characterj']
			CharacterStats.motivation = node_data['characterm']
			CharacterStats.Intelligence = node_data["characterint"]
			CharacterStats.Agility = node_data["characteragi"]
			CharacterStats.Strength = node_data["characterstr"] 
			CharacterStats.Stamina = node_data["charactersta"]
			CharacterStats.Charisma = node_data["charactercha"]
			CharacterStats.Luck = node_data["characterluc"]
			get_tree().change_scene(node_data['filename'])
		Items.choices = parse_json(save_game.get_line())
	save_game.close()

func list_files_in_directory(path):
	saves.clear()
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		else:
			saves.append(file)
	dir.list_dir_end()
	savecount = saves.size()
	return saves
