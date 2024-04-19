extends Button

# The amount of damage each attack will do.
var damage_amount = 10

func _ready():
	connect("pressed", self, "_on_AttackButton_pressed")

func _on_AttackButton_pressed():
	var enemy_health_node = get_node("../../EnemyHealth/TextureProgress")
	if enemy_health_node != null:
		enemy_health_node.value -= damage_amount
		if enemy_health_node.value <= 0:
			print("Enemy defeated!")
		# Additional logic for what happens when the enemy is defeated can be added here.
	else:
		print("EnemyHealth node not found. Check the node path.")
