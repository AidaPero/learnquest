extends Control

@onready var current_ph_scale_text = $CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/CenterContainer/VBoxContainer/Label
@onready var ph_scale_slider = $CenterContainer/Panel/MarginContainer/VBoxContainer/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/HSlider
@onready var texture_node = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Image/TextureRect
@onready var checkPopup = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Image/CheckPopup
@onready var checkPopupLabel = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Image/CheckPopup/Label
@onready var checkPopupTexture = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/Image/CheckPopup/TextureRect
@onready var parent = $"../.."
@onready var feedback_label = $CenterContainer/Panel/HBoxContainer/Label


var feedback = "please slide the ph scale"
var answered_value = 0
const ANSWER = 7
var answered = false

func _show():
	if answered: return
	get_tree().paused = true
	show()
	pass

func _hide():
	if answered: return
	get_tree().paused = false
	hide()

func _on_exit_pressed():
	_hide()
	BackgroundMusic.emit_signal("play", "normal_sound")

	if answered_value == ANSWER:
		answered = true
		GameManager.emit_signal("add_star")
		BackgroundMusic.emit_signal("play", "small_victory_sound")
	pass # Replace with function body.

func _on_h_slider_value_changed(value):
	current_ph_scale_text.text = str(value)
	texture_node.modulate = ph_to_color(value)
	answered_value = value
	
	checkPopup.hide()
	pass # Replace with function body.

func ph_to_color(ph: float) -> Color:
	ph = clamp(ph, 0.0, 14.0)

	if ph <= 7.0:
		var t = ph / 7.0
		feedback = "still too acidic—slide up a bit"
		# From Red (1,0,0) to White (1,1,1)
		return Color(1.0, t, t)
	else:
		var t = (ph - 7.0) / 7.0
		feedback = "too basic now—slide down a little."
		# From White (1,1,1) to Blue (0,0,1)
		return Color(1.0 - t, 1.0 - t, 1.0)

func check():
	if answered_value == ANSWER:
		feedback_label.text = "perfect! the water is now neutral ph."
		checkPopupLabel.text = str("CORRECT")
		checkPopupTexture.texture = load("res://assets/gui/face_on_green_tick.png")
	else:
		feedback_label.text = str(feedback)
		checkPopupLabel.text = str("INCORRECT")
		checkPopupTexture.texture = load("res://assets/gui/face_on_cross.png")	
	checkPopup.show()
	pass

func _on_button_3_pressed():
	check()
	BackgroundMusic.emit_signal("play", "normal_sound")
	pass # Replace with function body.
