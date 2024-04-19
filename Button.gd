extends Button

func _ready():
	# Connect the button's `pressed` signal to the `on_button_pressed` function.
	connect("pressed", self, "on_button_pressed")

# Called when the button is pressed.
func on_button_pressed():
	var power_bar = get_node("../PowerBar")  # Adjust the path as needed.
	if power_bar.is_moving:
		power_bar.stop_filling()
	else:
		power_bar.start_filling()
