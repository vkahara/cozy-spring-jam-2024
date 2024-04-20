# AttackButton.gd (attached to the second Attack Button in the mini-game)

extends Button

func _ready():
	connect("pressed", self, "_on_AttackButton_pressed")

func _on_AttackButton_pressed():
	# Assuming ProgressBar.gd is attached to the PowerBar and it has a stop_filling function.
	var power_bar = get_node("../PowerBar")
	power_bar.stop_filling()
	# Call end_player_turn on the battle.gd script attached to Node2D.
	get_node("/root/Node2D").end_player_turn()
