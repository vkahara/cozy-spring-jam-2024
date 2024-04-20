# PlayerHealth.gd

extends TextureProgress

var max_health = 100  # Maximum health of the player

func _ready():
	value = max_health
	max_value = max_health

func take_damage(damage):
	value -= damage
	if value <= 0:
		game_over()

func game_over():
	print("Player defeated!")
	# Here you would handle the player's defeat, such as showing a defeat screen or restarting the game.
	var game_end_panel = get_node("/root/Node2D/CanvasLayer/GameEndPanel")
	if game_end_panel:
		game_end_panel.get_node("Label").text = "Game Over! You have been defeated."
		game_end_panel.show()
	else:
		print("GameEndPanel not found. Check the node path.")
