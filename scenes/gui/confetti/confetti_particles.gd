extends GPUParticles2D


func _ready():
	GameManager.connect("add_star", play_confetti)
	GameManager.connect("game_completed", play_victory_confetti)
	

func play_confetti():
	restart()
	emitting = true
	
	pass

func play_victory_confetti():
	restart()
	amount = 600
	lifetime = 5
	randomness = 0.5
	emitting = true
	pass
