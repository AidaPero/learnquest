extends Control

@onready var main_scene = "res://scenes/main_menu/main_menu.tscn"
var is_active = false

func _ready():
	deactivate_pause()
	pass

func deactivate_pause():
	get_tree().paused = false
	is_active = false
	hide()
	pass

func activate_pause():
	get_tree().paused = true
	is_active = true
	show()
	pass

func _input(event):
	if event is InputEventKey and event.keycode == KEY_ESCAPE and event.is_pressed():
		if is_active: deactivate_pause()
		else: activate_pause()
		pass


func _on_continue_button_pressed():
	deactivate_pause()
	pass # Replace with function body.


func _on_home_button_pressed():
	deactivate_pause()
	Transition.navigate(main_scene)
	pass # Replace with function body.
