extends Control

@onready var histories_panels_container = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer
@onready var draggable = $HistoryDraggableItem
@onready var parent = $"../.."

const HISTORY = ['a', 'b', 'c', 'd', 'e']
var history_panels = [
	{ "index": 0, "name": "a", "texture": "res://assets/images/8ca491d783ca90df0e8983276f81c929.jpg", "label": "Unification of Upper & Lower Egypt", "comment": "Unification of Upper & Lower Egypt was around 3100 BC!" },
	{ "index": 1, "name": "b", "texture": "res://assets/images/29d84663a50c3cff27fe7eba58638a72.jpg", "label": "Construction of the Great Pyramid of Giza", "comment": "Great Pyramid built around 2560 BC!" },
	{ "index": 2, "name": "c", "texture": "res://assets/images/95f5ae429960e41944a70bcc346f8515.jpg", "label": "Beginning of Hatshepsut’s Reign", "comment": "Beginning of Hatshepsut’s Reign was around 1479 BC!" },
	{ "index": 3, "name": "d", "texture": "res://assets/images/57912ef8e69593012be80f13676a40b5.jpg", "label": "Reign of Tutankhamun", "comment": "Reign of Tutankhamun was around 1332–1323 BC!" },
	{ "index": 4, "name": "e", "texture": "res://assets/images/cf838f2c826bb944a34078045d992311.jpg", "label": "Battle of Kadesh vs. the Hittites", "comment": "Battle of Kadesh vs. the Hittites happened around 1274 BC!" },
]
var answered = false

func _ready():
	init_histories()

func init_histories():
	history_panels.shuffle()
	for i in history_panels.size():
		histories_panels_container.get_child(i).set_details(history_panels[i])
	pass

func check():
	var _answered = true
	for i in HISTORY.size():
		var answer = histories_panels_container.get_child(i).check(i)
		if (!answer): _answered = false
	
	answered = _answered
	pass


func _show():
	if answered: return

	get_tree().paused = true
	show()
	pass

func _hide():
	get_tree().paused = false
	hide()

func _on_button_2_pressed():
	
	BackgroundMusic.emit_signal("play", "normal_sound")
	_hide()
	if answered:
		GameManager.emit_signal("add_star")
		BackgroundMusic.emit_signal("play", "small_victory_sound")
	pass # Replace with function body.


func _on_button_pressed():
	check()
	BackgroundMusic.emit_signal("play", "normal_sound")
	pass # Replace with function body.
