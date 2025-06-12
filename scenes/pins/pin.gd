extends Area2D

@export_enum("History", "Maths", "Science", "Memory") var type: String = "History"
@export var hide_pin = false

@onready var collision = $StaticBody2D/CollisionShape2D
@onready var area_collision = $CollisionShape2D

func _ready():
	GameManager.connect("remove_treasure", kill)
	GameManager.connect("show_last_pin", enable_collision)
	if hide_pin: disable_collision()
	pass

func kill():
	queue_free()
	pass

func open_mini_game():
	BackgroundMusic.emit_signal("play", "open_sound")
	GameManager.emit_signal("show_mini_game", type, self)
	GameManager.current_treasure = self
	pass

func disable_collision():
	hide()
	monitoring = false
	monitorable = false
	collision.disabled = true
	area_collision.disabled = true
	pass

func enable_collision():
	show()
	monitoring = true
	monitorable = true
	collision.disabled = false
	area_collision.disabled = false
	pass
