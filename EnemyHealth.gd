extends TextureProgress

var max_health = 100  # Maximum health

func _ready():
	value = max_health
	max_value = max_health
	var power_bar = get_node("../../Panel3/PowerBar")
	power_bar.connect("attack_made", self, "_on_attack_made")

func _on_attack_made(damage):
	value -= damage
	if value <= 0:
		die()

func die():
	print("Enemy defeated!")
	Game.advance_level()  # Advance to the next level
	var game_end_panel = get_node("/root/Node2D/CanvasLayer/GameEndPanel")
	if game_end_panel:
		game_end_panel.show()
		# Optionally delay the scene change to allow player to see game end panel
		yield(get_tree().create_timer(2.0), "timeout")  # Wait for 2 seconds
		get_tree().change_scene("res://Main.tscn")
	else:
		print("GameEndPanel not found. Check the node path.")
		get_tree().change_scene("res://Main.tscn")
