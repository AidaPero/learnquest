extends Node2D

@onready var history_game = $CanvasLayer/HistoryMiniGame
@onready var ph_slider_game = $CanvasLayer/PhSliderMiniGame
@onready var maths_game = $CanvasLayer/MathsMiniGame
@onready var memory_game = $CanvasLayer/MemoryMiniGame
@onready var victory_menu = $CanvasLayer/VictoryMenu
var current_pin = null

func _ready():
	GameManager.connect("add_star", delete_pin)
	GameManager.connect("show_mini_game", show_mini_game)
	GameManager.connect("game_completed", show_victory_menu)
	pass

func delete_pin():
	current_pin.queue_free()
	current_pin = null
	pass

func show_mini_game(type: String, pin):
	current_pin = pin
	match type:
		"History":
			history_game._show()
			pass
		"Science":
			ph_slider_game._show()
			pass
		"Maths":
			maths_game._show()
			pass
		"Memory":
			memory_game._show()
			pass
	pass

func show_victory_menu():
	await get_tree().create_timer(2).timeout
	victory_menu._show()
	
	pass

func _on_hill_area_layer_body_entered(body):
	if !body.is_in_group("player"): return
	body.z_index += 1
	pass # Replace with function body.


func _on_hill_area_layer_body_exited(body):
	if !body.is_in_group("player"): return
	body.z_index -= 1
	pass # Replace with function body.
