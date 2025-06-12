extends Control

@onready var world_scene = "res://scenes/world.tscn"

func _on_play_button_pressed():
	BackgroundMusic.emit_signal("play", "normal_sound")
	Transition.navigate(world_scene)
	pass # Replace with function body.


func _on_exit_button_pressed():
	BackgroundMusic.emit_signal("play", "normal_sound")
	get_tree().quit()
	pass # Replace with function body.
