extends Control

@onready var anim = $AnimationPlayer
@onready var sound_player = $AudioStreamPlayer

func _show():
	show()
	anim.play("scale")
	sound_player.play()
	pass


func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
	pass # Replace with function body.
