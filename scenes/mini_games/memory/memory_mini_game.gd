extends Control

@onready var cards_container = $CenterContainer/Panel/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer
@onready var parent = $"../.."

var cards_textures = [
	"res://assets/cards/clubs_02.png",
	"res://assets/cards/clubs_04.png",
	"res://assets/cards/clubs_ace.png",
	"res://assets/cards/spades_04.png",
	"res://assets/cards/spades_ace.png",
	"res://assets/cards/spades_king.png"
]

var flipped_cards = []
var answered = false

func _ready():
	set_cards()

func set_cards():
	cards_textures.shuffle()
	var first_five = cards_textures.slice(0, 5)
	
	var result = first_five + first_five
	result.shuffle()
	
	for i in result.size():
		cards_container.get_child(i).set_texture(result[i])
	
	pass

func add_flipped_card(_card):
	if flipped_cards.size() <= 0:
		flipped_cards.append(_card)
		return
	
	flipped_cards.append(_card)
	if flipped_cards[0].front.texture.resource_path != flipped_cards[1].front.texture.resource_path:
		for card in flipped_cards:
			card.check(false)
		await get_tree().create_timer(0.5).timeout
		for card in flipped_cards:
			card.flip_backwards()
		flipped_cards.clear()
	else:
		for card in flipped_cards:
			card.check(true)
		flipped_cards.clear()
	
	check()

func check():
	var _answered = true
	for card in cards_container.get_children():
		if !card.answered: _answered = card.answered
	
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
	_hide()
	BackgroundMusic.emit_signal("play", "normal_sound")
	set_cards()
	if answered:
		GameManager.emit_signal("add_star")
		BackgroundMusic.emit_signal("play", "small_victory_sound")
	pass # Replace with function body.
