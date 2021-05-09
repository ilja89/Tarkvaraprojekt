extends Control


# Load the music player node
onready var _player = $AudioStreamPlayer
onready var _player2 = $AudioStreamPlayer2
var files = []
var played
var music_directory
var is_manual_music : bool
var volume = -12
var current
var progress
var fade_finished = true

func _process(_delta):
	if fade_finished:
		_player.volume_db = volume
	if !current == null:
		progress = _player.get_playback_position() / current * 100
	else:
		progress = 0
	if progress == 100:
		next()

func start(track_url : String, manual : bool):
	if is_manual_music == manual:
		if not track_url == music_directory:
			fade_finished = false
			_player2.volume_db = -80
			var _player3 = _player
			_player = _player2
			_player2 = _player3
			if not _player.stream_paused:
				$Tween.interpolate_property(_player2, "volume_db", volume, -80, 5, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
				$Tween.start()
			music_directory = track_url
			list_files_in_directory(track_url)
			files = shuffleList(files)
			var path = track_url + files[0]
			var new_track = load(path)
			_player.stream = new_track
			current = _player.stream.get_length()
			played = 0
			_player.play()
			$Tween2.interpolate_property(_player, "volume_db", -80, volume, 4, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
			$Tween2.start()

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


func list_files_in_directory(path):
	files.clear()
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		if not file.ends_with(".import"):
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


func _on_Tween_tween_completed(_object, _key):
	_player2.stop()


func _on_Tween2_tween_completed(_object, _key):
	fade_finished = true

