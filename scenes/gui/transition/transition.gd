extends CanvasLayer

@onready var anim = $Control/AnimationPlayer
var scene = ""

func load_scene():
	get_tree().change_scene_to_file(scene)
	pass

func navigate(_scene: String):
	anim.play("fade")
	scene = _scene
	pass
