extends Control

var stars = 0

@onready var stars_container = $MarginContainer/HBoxContainer
@onready var star1 = $MarginContainer/HBoxContainer/TextureRect
@onready var star2 = $MarginContainer/HBoxContainer/TextureRect2
@onready var star3 = $MarginContainer/HBoxContainer/TextureRect3
@onready var star4 = $MarginContainer/HBoxContainer/TextureRect4

@onready var stars_label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/Label2

func _ready():
	GameManager.connect("add_star", add_star)
	pass
	

func game_completed():
	GameManager.emit_signal("game_completed")
	pass

func activate_last_pin():
	GameManager.emit_signal("show_last_pin")

func add_star():
	stars += 1
	stars_label.text = "(" + str(stars) + "/4)"
	match stars:
		1: 
			star1.show()
		2: 
			star1.show()
			star2.show()
		3: 
			star1.show()
			star2.show()
			star3.show()
			activate_last_pin()
		4:
			star1.show()
			star2.show()
			star3.show()
			star4.show()
			game_completed()
	pass
