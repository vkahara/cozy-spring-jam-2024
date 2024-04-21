# Node2D/CanvasLayer/HealButtonPanel/HealButton.gd
extends Button  # Make sure this inherits from Button, not Panel

func _ready():
	# Connect this button's pressed signal to the show_mini_game method in the CountdownPanel
	var countdown_panel = get_node("/root/Node2D/CanvasLayer/CountdownPanel")  # Adjust path as necessary
	connect("pressed", countdown_panel, "show_mini_game")
