extends Node

@onready var button_sound = $button_sound



@onready var music_player = $music_player
@onready var music_delay = $music_player/music_delay

#var songs = {
	#"title" : [preload("res://assets/audio/music/title.mp3"), 0],
	#"main-m1" : [preload("res://assets/audio/music/t2-3.mp3"), 0],
	#"m1-1" : [preload("res://assets/audio/music/t1-1.mp3"), 0],
	#"m1-2" : [preload("res://assets/audio/music/t1-2.mp3"), 0],
	#"m1-3" : [preload("res://assets/audio/music/t1-3.mp3"), 0],
	#"b1-1" : [preload("res://assets/audio/music/t2-1.mp3"), 0],
	#"b1-2" : [preload("res://assets/audio/music/t2-2.mp3"), 0],
	#"b1-3" : [preload("res://assets/audio/music/t2-3.mp3"), 0],
#}
var songs = {
	"title" : [preload("res://assets/audio/music/title.mp3"), 0],
	
	"main-m1.0" : [preload("res://assets/audio/music/main_theme_beginning.mp3"), 2],
	"main-m1.1" : [preload("res://assets/audio/music/main_theme_simple.mp3"), 2],
	
	"m1-1" : [preload("res://assets/audio/music/2.mp3"), 0],
	"m1-2" : [preload("res://assets/audio/music/1.mp3"), 2],
	
	"b1-1" : [preload("res://assets/audio/music/bonus2.mp3"), 2],
	"b1-2" : [preload("res://assets/audio/music/bonus1.mp3"), 0],
	"b1-3" : [preload("res://assets/audio/music/web3.mp3"), 2],
	"b1-4" : [preload("res://assets/audio/music/bonus_minilogue.mp3"), 3],
}
var song_stream = 0 #index, used like songs[song title][song_stream]
var song_last_played_at = 1 #index, used like songs[song title][song_last_played_at]

######## playlists
var title = ["title", "main-m1.0"]
var m1_beginning = ["main-m1.0","m1-1"]
var m1_beat = ["main-m1.1", "m1-1", "m1-2"]
var b1 = ["b1-1", "b1-2", "b1-3"]
var b2 = ["b1-1", "b1-2", "b1-3", "b1-4"]
var b3 = []
##### conditions for playlists
var m1_complete = false

var next_song_from = title
var current_song = "none"

var song_queue = []
var song_numb = 1


func _ready() -> void:
	await get_tree().process_frame
	connect_buttons.call_deferred()
	
	play_song()

func connect_buttons():
	var buttons: Array = get_tree().get_nodes_in_group("UI_buttons")
	for inst in buttons:
		if not inst.pressed.is_connected(on_button_pressed):
			inst.pressed.connect(on_button_pressed)

func on_button_pressed()->void:
	button_sound.play()



func show_title():
	songs["title"][song_last_played_at] = 0
	next_song_from = title

func _on_maze_won(_data):
	m1_complete = true

var first_load = false
func load_maze(numb):
	if !first_load:
		first_load = true
		return
	next_song_from = select_playlist(numb)
	if !song_in_playlist(current_song, next_song_from):
		print("song not in playlist")
		#if next_song_from == m1_beat:
			#if current_song == "main-m1.0":
				#return
		if next_song_from == b1:
			music_delay.stop()
			play_song()
			print("playing song from b1")
			return
		
		current_song = "none"
		music_player.stop()
		music_delay.start()
		print("starting delay")

func song_in_playlist(song, playlist):
	for s in playlist:
		if s == song:
			return true
	return false

func select_playlist(numb):
	match numb:
		1:
			if m1_complete:
				return m1_beat
			else:
				return m1_beginning
		2:
			return b1
		3:
			return b2
		4:
			return b3

func select_song(): #### selects song from next_song_from
	var playlist = next_song_from
	## finds song played longest ago in playlist
	if playlist.size() > 0:
		var numbs = []
		for n in playlist:
			numbs.append(songs[n][song_last_played_at])
		var least = numbs.min()
		var least_idx = numbs.find(least)
		var son = playlist[least_idx]
		return son
	else:
		return "dont"


func queue_song(song):
	song_queue.append(song)

func play_song(song = "none"):
	if song == "none":
		if song_queue.size() > 0: ### if songs in queue
			song = song_queue.pop_front()
		else:
			song = select_song()
	if song == "dont":
		current_song = "none"
		return

	var stream = songs[song][song_stream]
	
	music_player.stop()
	music_player.stream = stream
	music_player.play()
	
	current_song = song
	song_numb += 1
	songs[song][song_last_played_at] = song_numb
	
	if song == "b1-2":
		songs[song][song_last_played_at] = 1000

func _on_music_player_finished() -> void:
	music_delay.start()

func _on_music_delay_timeout() -> void:
	play_song()
