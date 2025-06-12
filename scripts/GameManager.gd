extends Node

signal show_mini_game(type, pin)
signal add_star
signal remove_treasure
signal game_completed
signal show_last_pin

var current_treasure = null

func _ready():
	#add_cursor_texture()
	
	pass

func add_cursor_texture():
	var cursor_texture = load("res://assets/gui/01.png")
	Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW, Vector2(0, 0))  # Top-left hotspot
	pass
