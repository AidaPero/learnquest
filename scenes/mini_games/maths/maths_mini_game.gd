extends Control
@onready var checkPopup = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer/Button/CheckPopup
@onready var checkPopupLabel = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer/Button/CheckPopup/Label
@onready var checkPopupTexture = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer/Button/CheckPopup/TextureRect

@onready var answeredLabel = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer/Button/TextureRect/Label

@onready var option_label_1 = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer2/Button/TextureRect/Label
@onready var option_label_2 = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer2/Button2/TextureRect/Label
@onready var option_label_3 = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer2/Button3/TextureRect/Label


@onready var label_after = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer/Label
@onready var label_before = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer/Label2
@onready var total_questions_label = $CenterContainer/Panel/Label
@onready var parent = $"../.."

@onready var feedback_label = $CenterContainer/Panel/HBoxContainer/Label

var options = []
var answered = false
var answered_value = 0

var good_feedbacks = [
	"great !", "well done !", "great job !", "nice !"
]
var bad_feedbacks = [
	"try again", "wow so close", "almost there", "good try!", "oops, that one’s tricky!"
]

var questions = [
	{
		"options": [2,4,1],
		"label_before": "",
		"label_after": " + 3 = 7",
		"answer": 4
	},
	{
		"options": [3,5,2],
		"label_before": "2",
		"label_after": " = 10",
		"answer": 5
	},
	{
		"options": [6,4,1],
		"label_before": "",
		"label_after": "/2 + 1 = 4",
		"answer": 6
	},
	{
		"options": [3,5,1],
		"label_before": "3",
		"label_after": " - 2 = 7",
		"answer": 3
	},
	{
		"options": [12,11,6],
		"label_before": "",
		"label_after": "/3 + 4 = 8",
		"answer": 12
	}
]
var question_index = 0
const MAX_QUESTIONS = 5

func _ready():
	init_questions()
	pass

func init_questions():
	if question_index > MAX_QUESTIONS - 1: 
		answered = true
		return
	
	var _options = questions[question_index]
	var _label_before = _options["label_before"]
	var _label_after = _options["label_after"]
	
	options = _options
	label_before.visible = _label_before != ""
	label_after.visible = _label_after != ""
	
	label_before.text = _label_before
	label_after.text = _label_after
	
	checkPopup.hide()
	answeredLabel.text = "X"
	option_label_1.text = str(options["options"][0])
	option_label_2.text = str(options["options"][1])
	option_label_3.text = str(options["options"][2])
	
	question_index += 1
	total_questions_label.text = "Maths Game " + str(question_index) + "/" + str(MAX_QUESTIONS)
	pass

func _show():
	get_tree().paused = true
	show()
	pass

func _hide():
	get_tree().paused = false
	hide()
	checkPopup.hide()

func get_good_feedback():
	return good_feedbacks[randi()%good_feedbacks.size()]
	pass

func get_bad_feedback():
	return bad_feedbacks[randi()%bad_feedbacks.size()]

func check():
	checkPopup.show()
	if answered_value == options["answer"]:
		checkPopupLabel.text = str("CORRECT")
		checkPopupTexture.texture = load("res://assets/gui/face_on_green_tick.png")
		feedback_label.text = get_good_feedback()
		await get_tree().create_timer(0.5).timeout
		init_questions()
	else:
		feedback_label.text = get_bad_feedback()
		checkPopupLabel.text = str("INCORRECT")
		checkPopupTexture.texture = load("res://assets/gui/face_on_cross.png")	
	pass

func _on_exit_pressed():
	_hide()
	BackgroundMusic.emit_signal("play", "normal_sound")
	if answered_value == options["answer"]:
		answered = true
		GameManager.emit_signal("add_star")
		BackgroundMusic.emit_signal("play", "small_victory_sound")
	pass # Replace with function body.


func answer_question(value):
	answered_value = value
	answeredLabel.text = str(value)
	checkPopup.hide()
	pass

func _on_button_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		answer_question(options["options"][0])
		BackgroundMusic.emit_signal("play", "normal_sound")
	pass # Replace with function body.


func _on_button_2_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		answer_question(options["options"][1])
		BackgroundMusic.emit_signal("play", "normal_sound")
	pass # Replace with function body.


func _on_button_3_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		answer_question(options["options"][2])
		BackgroundMusic.emit_signal("play", "normal_sound")
	pass # Replace with function body.


func _on_button_3_pressed():
	check()
	BackgroundMusic.emit_signal("play", "normal_sound")
	pass # Replace with function body.
