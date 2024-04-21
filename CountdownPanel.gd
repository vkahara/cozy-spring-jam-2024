# Node2D/CanvasLayer/CountdownPanel.gd
extends Panel

# References to UI elements within the Countdown Panel
onready var progress_bar = $ProgressBar
onready var timer = Timer.new()  # Create a new Timer node

var countdown_duration = 10  # Duration of the countdown in seconds

func _ready():
	hide()  # Initially hidden
	# Setup the timer
	timer.wait_time = 1  # Update every second
	timer.autostart = false
	timer.one_shot = false  # Continues to timeout repeatedly
	add_child(timer)  # Add the timer to the node tree
	timer.connect("timeout", self, "_on_Timer_timeout")  # Connect signal to method
	# Initialize progress bar
	progress_bar.max_value = countdown_duration
	progress_bar.value = countdown_duration

	var heal_button_panel = get_node("/root/Node2D/CanvasLayer/HealButtonPanel")
	if heal_button_panel.is_connected("clicks_counted", self, "_on_clicks_counted"):
		print("Already connected.")
	else:
		heal_button_panel.connect("clicks_counted", self, "_on_clicks_counted")
		print("Connection made.")

func show_mini_game():
	show()
	start_mini_game()

func start_mini_game():
	# Reset the progress bar and start the timer
	progress_bar.value = countdown_duration
	timer.start()  # Start the countdown
	print("Mini-game initialized and timer started.")

func _on_Timer_timeout():
	progress_bar.value -= 1  # Decrement the progress bar value each second
	print("Countdown: ", progress_bar.value)
	
	# Check if the countdown has finished
	if progress_bar.value <= 0:
		timer.stop()  # Stop the timer
		finish_mini_game()  # Call a method to handle the end of the mini-game

func finish_mini_game():
	print("Mini-game finished. About to emit clicks.")
	# Assuming HealButtonPanel controls when to emit clicks.
	var heal_button_panel = get_node("/root/Node2D/CanvasLayer/HealButtonPanel")
	heal_button_panel.emit_clicks()  # Ensure this method exists and is public in HealButtonPanel


func _on_clicks_counted(received_clicks):
	print("Received clicks count:", received_clicks)
	var player_health_node = get_node("/root/Node2D/CanvasLayer/PlayerHealth/TextureProgress")
	if player_health_node:
		player_health_node.heal(received_clicks)
		print("Player healed by ", received_clicks, " points.")
	else:
		print("Error: PlayerHealth node not found.")

	hide()
	get_node("/root/Node2D").end_player_turn()
