# Node2D/CanvasLayer/HealButtonPanel.gd
extends Panel

var clicks = 0  # This variable will count the clicks

func _ready():
	show()  # Ensure this is always visible if it's just a backdrop.
	print("HealButtonPanel is visible as backdrop.")

func _on_HealSmashButton_pressed():
	clicks += 1
	print("Button pressed. Total clicks:", clicks)
	# Add additional logic here to handle what happens with each click, if necessary.
