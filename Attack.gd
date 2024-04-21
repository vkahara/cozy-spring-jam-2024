# Node2D/CanvasLayer/AttackButtonPanel/attack.gd (button to open the attack-mini-game)
extends Button

func _ready():
	connect("pressed", self, "_on_AttackButton_pressed")

func _on_AttackButton_pressed():
	var panel3 = get_node("../../Panel3")  # Adjust the path as necessary.
	if panel3:
		panel3.show()  # Use show() method to make Panel3 visible when the button is pressed.
	else:
		print("Panel3 not found. Check the node path.")
