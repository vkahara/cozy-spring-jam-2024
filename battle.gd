extends Node2D

# Example of setting initial health
var max_health = 100
var current_health = max_health

func take_damage(amount):
	current_health -= amount
	current_health = max(0, current_health)  # Ensure health doesn't go below 0
	update_health_bar()

func update_health_bar():
	var enemy_health_bar = get_node("EnemyHealth/TextureProgress")
	if enemy_health_bar != null:
		enemy_health_bar.value = current_health  # Update the health bar value
	else:
		print("EnemyHealth/TextureProgress node not found. Check the node path.")

func _ready():
	# As _ready is called when the node enters the scene tree,
	# all descendant nodes should be available.
	var enemy_health_bar = get_node("EnemyHealth/TextureProgress")
	if enemy_health_bar != null:
		enemy_health_bar.max_value = max_health
		enemy_health_bar.value = current_health
	else:
		print("EnemyHealth/TextureProgress node not found. Check the node path.")
