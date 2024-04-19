# AttackButton.gd

extends Button

func _ready():
	connect("pressed", self, "_on_AttackButton_pressed")

func _on_AttackButton_pressed():
	# The PowerBar is under a sibling node called Panel3.
	var power_bar = get_node("../../Panel3/PowerBar")
	if power_bar.move_direction != 0:
		power_bar.stop_filling()
	else:
		power_bar.start_filling()
