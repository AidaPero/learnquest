extends Node2D

@onready var texture_node = $TextureRect
@onready var label = $Label

var previous_target = null
var previous_target_details = null
var next_target = null
var next_target_details = null

var can_drag = false

func _ready():
	hide()

func _process(delta):
	if can_drag: global_position = get_global_mouse_position()
	pass

func set_texture(_details, _previous_target):
	show()
	can_drag = true
	previous_target_details = _details
	#var texture = _details["texture"]
	previous_target = _previous_target
	#texture_node.texture = load(texture)
	label.text = str(_details.label)
	
	pass

func _hide():
	hide()
	can_drag = false
	
	if next_target and next_target != previous_target:
		previous_target.set_details(next_target_details)
		next_target.set_details(previous_target_details)
		next_target = null
		next_target_details = null
	else:
		if previous_target: previous_target.set_details(previous_target_details)
	pass

func _input(event):
	if event is InputEventScreenTouch and can_drag:
		if event.is_pressed():
			pass
		else:
			_hide()
			BackgroundMusic.emit_signal("play", "drop_sound")
	pass
