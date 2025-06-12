extends Node2D

@onready var sound_player = $UISoundPlayer

signal play(sound_type)

var sounds = {
	"normal_sound": "res://sounds/click1.ogg",
	"open_sound": "res://sounds/rollover1.ogg",
	"drop_sound": "res://sounds/click2.ogg",
	"small_victory_sound": "res://sounds/Strange.wav"
}

func _ready():
	connect("play", play_sound)
	pass

func play_sound(sound_type):
	if sound_type == "small_victory_sound":
		sound_player.volume_db = 10
	else: sound_player.volume_db = -10
	sound_player.stream = load(sounds[sound_type])
	sound_player.play()
	pass
