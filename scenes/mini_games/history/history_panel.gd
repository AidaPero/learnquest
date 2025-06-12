extends Panel

@onready var texture_node = $TextureRect
@onready var checkPopup = $CheckPopup
@onready var checkPopupTexture = $CheckPopup/TextureRect
@onready var parent = $"../../../../../../.."
@onready var label_node = $Label

var details = null
var disabled = false

func set_details(_details):
	details = _details
	label_node.text = str(details.label)
	#var _texture = details.texture
	#texture_node.texture = load(_texture)
	hide_checkbox()
	pass

func hide_details():
	texture_node.texture = null
	
	pass

func hide_checkbox():
	checkPopup.hide()

func check(index):
	var condition = index == details.index
	if condition:
		checkPopupTexture.texture = load("res://assets/gui/face_on_green_tick.png")
		label_node.text = str(details.comment)
		#label_node.label_settings.
		disabled = true
		modulate.a = 0.9
	else:
		checkPopupTexture.texture = load("res://assets/gui/face_on_cross.png")
	checkPopup.show()
	return condition
	pass

func drag():
	parent.draggable.set_texture(details, self)
	pass


func _on_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed() and !disabled:
		drag()
		hide_details()
		BackgroundMusic.emit_signal("play", "normal_sound")
		pass
	
	pass # Replace with function body.


func _on_mouse_entered():
	if disabled: return
	parent.draggable.next_target = self
	parent.draggable.next_target_details = details
	pass # Replace with function body.


func _on_mouse_exited():
	parent.draggable.next_target = null
	parent.draggable.next_target_details = null
	pass # Replace with function body.
