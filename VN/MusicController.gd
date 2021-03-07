extends Control


# Load the music player node
onready var _player = $AudioStreamPlayer
var files = []
var played
var music_directory
var is_manual_music : bool
var volume = -12
var current
var progress

func _process(delta):
	_player.volume_db = volume
	if !current == null:
		progress = _player.get_playback_position() / current * 100

func start(track_url : String, manual : bool):
	if is_manual_music == manual:
		music_directory = track_url
		if not _player.stream_paused:
			_player.stop()
		list_files_in_directory(track_url)
		files.shuffle()
		var path = track_url + files[0]
		var new_track = load(path)
		_player.stream = new_track
		current = _player.stream.get_length()
		played = 0
		_player.play()

func next():
	if played < files.size() - 1:
		played += 1
	else: 
		played = 0
	var path = music_directory + files[played]
	var new_track = load(path)
	_player.stream = new_track
	current = _player.stream.get_length()
	_player.play()

func previous():
	if played > 0:
		played -= 1
	else:
		played = files.size() - 1
	var path = music_directory + files[played]
	var new_track = load(path)
	_player.stream = new_track
	current = _player.stream.get_length()
	_player.play()

func _on_AudioStreamPlayer_finished():
	next()

func list_files_in_directory(path):
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		else:
			files.append(file)
	dir.list_dir_end()
	return files

func shuffleList(list):
	var shuffledList = []
	var indexList = range(list.size())
	for _i in range(list.size()):
		randomize()
		var x = randi()%indexList.size()
		shuffledList.append(list[x])
		indexList.remove(x)
		list.remove(x)
	return shuffledList

func pause():
	_player.stream_paused = !_player.stream_paused
