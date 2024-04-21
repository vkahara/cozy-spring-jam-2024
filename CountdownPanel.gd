# Node2D/CanvasLayer/CountdownPanel.gd
extends Panel

onready var progress_bar = $ProgressBar
onready var timer = Timer.new()  # Create a new Timer node
var countdown_duration = 10  # Duration of the countdown in seconds
var clicks = 0  # Declare clicks here at the class level

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

func show_mini_game():
	show()
	start_mini_game()

func start_mini_game():
	# Reset the progress bar and start the timer
	progress_bar.value = countdown_duration
	timer.start()  # Start the countdown
	clicks = 0  # Reset clicks whenever mini-game starts
	print("Mini-game initialized and timer started.")

func _on_Timer_timeout():
	progress_bar.value -= 1  # Decrement the progress bar value each second
	print("Countdown: ", progress_bar.value)
	
	# Check if the countdown has finished
	if progress_bar.value <= 0:
		timer.stop()  # Stop the timer
		finish_mini_game()  # Call a method to handle the end of the mini-game

# CountdownPanel.gd or similar
func finish_mini_game():
	print("Mini-game finished.")
	hide()  # Optionally hide the countdown panel
	
	# Ensure that healing is applied with the current clicks count
	var player_health_node = get_node("/root/Node2D/CanvasLayer/PlayerHealth/TextureProgress")

	if player_health_node:
		print("Applying healing. Clicks count: ", clicks)
		player_health_node.heal(clicks)  # Call the heal function with the current clicks count
		print("Player healed by ", clicks, " points.")
	else:
		print("Error: PlayerHealth node not found.")

	# Reset clicks to 0 after healing
	clicks = 0
	print("Clicks reset to 0 after healing.")

	# Signal to end the player turn and switch to the enemy's turn
	get_node("/root/Node2D").end_player_turn()

