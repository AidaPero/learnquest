extends CharacterBody2D

@export var speed := 200.0

@onready var interact_anim_player = $InteractiveNode/AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var sprite = $Character
@onready var sound_player = $AudioStreamPlayer2D

var interactable = false
var pin = null

func _ready():
	pass

func _physics_process(delta):
	movement()
	_look()

func movement():
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	anim_tree.set("parameters/blend_position", input_vector.x if input_vector.x else input_vector.y)
	if input_vector != Vector2.ZERO: 
		input_vector = input_vector.normalized()
		if !sound_player.playing:
			sound_player.play()
			sound_player.stream_paused = false
	else:
		if sound_player.playing:
			sound_player.stream_paused = true
	velocity = input_vector * speed
	move_and_slide()
	
	pass

func _input(event):
	if Input.is_action_just_pressed("interact") and pin:
		interact()
		pass
	pass

func interact():
	pin.open_mini_game()
	pass

func _look():
	if Input.is_action_just_pressed("ui_left"):
		sprite.flip_h = true
		
	if Input.is_action_just_pressed("ui_right"):
		sprite.flip_h = false
	pass

func _on_area_2d_area_entered(area):
	if !area.is_in_group("pin"): return
	interactable = true
	interact_anim_player.play("move_up")
	pin = area
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	if !area.is_in_group("pin"): return
	interactable = false
	interact_anim_player.play("move_down")
	pin = null
	pass # Replace with function body.
