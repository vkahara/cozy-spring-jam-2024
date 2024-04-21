# Node2D/CanvasLayer/CountdownButton/HealSmashButton.gd
extends Button

func _ready():
	var heal_button_panel = get_parent().get_parent().get_node("HealButtonPanel")
	if is_connected("pressed", heal_button_panel, "_on_HealSmashButton_pressed"):
		disconnect("pressed", heal_button_panel, "_on_HealSmashButton_pressed")
	
	connect("pressed", heal_button_panel, "_on_HealSmashButton_pressed")
	print("Connected HealSmashButton to HealButtonPanel")
