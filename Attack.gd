extends Button

func _ready():
	connect("pressed", self, "_on_OuterButton_pressed")

func _on_OuterButton_pressed():
	var panel3 = get_node("../../Panel3")  # Adjust the path as necessary.
	if panel3:
		panel3.toggle_visibility()
	else:
		print("Panel3 not found. Check the node path.")
