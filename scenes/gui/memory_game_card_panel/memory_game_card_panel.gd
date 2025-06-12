extends Panel

@onready var anim = $AnimationPlayer
@onready var front = $Front
@onready var parent = $"../../../../../../.."
@onready var checkPopup = $CheckPopup
@onready var checkPopupTexture = $CheckPopup/TextureRect

var disabled = false
var answered = false
func _ready():
	hide_checkbox()
	await get_tree().create_timer(1).timeout
	anim.play("show_back")
	pass
	

func hide_checkbox():
	checkPopup.hide()

func set_texture(texture):
	front.texture = load(texture)
	
	pass

func flip():
	anim.play_backwards("show_back")
	pass

func flip_backwards():
	anim.play("show_back")
	hide_checkbox()
	pass

func check(condition):
	checkPopup.show()
	if condition:
		checkPopupTexture.texture = load("res://assets/gui/face_on_green_tick.png")
		disabled = true
		answered = true
		modulate.a = 0.9
	else:
		checkPopupTexture.texture = load("res://assets/gui/face_on_cross.png")
	pass

func _on_gui_input(event):
	if event is InputEventScreenTouch and event.pressed and !disabled:
		flip()
		parent.add_flipped_card(self)
		BackgroundMusic.emit_signal("play", "normal_sound")
	pass # Replace with function body.
