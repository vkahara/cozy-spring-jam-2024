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
	Game.advance_level()  # Advance to the next level or go to credits
