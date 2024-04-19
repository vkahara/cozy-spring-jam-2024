extends ProgressBar

signal attack_made(damage)
# The speed at which the progress bar fills up.
var fill_speed = 100  # Adjust this value as necessary for your game's pacing.
# Indicates whether the bar is currently moving, and in which direction.
var move_direction = 1  # 1 for increasing, -1 for decreasing.

# This function starts the progress bar movement.
func start_filling():
	move_direction = 1  # Always start by increasing.
	value = 0  # Optionally reset to 0 whenever we start.

# This function stops the progress bar and calculates damage.
func stop_filling():
	var damage = calculate_damage(value)
	emit_signal("attack_made", damage)  # Emit the signal with the damage value.
	print("Attack power: ", value, ", Damage dealt: ", damage)
	value = 0  # Reset the progress bar.
	move_direction = 1  # Reset the direction to start increasing again.
	# Optionally, you can reset the value of the progress bar and keep it moving
	# value = 0
	# move_direction = 1

# Called every frame. Updates the progress bar value.
func _process(delta):
	if move_direction != 0:  # If the progress bar is supposed to move.
		value += fill_speed * delta * move_direction
		
		# When value reaches the maximum, switch direction to decreasing.
		if value >= max_value:
			move_direction = -1
			value = max_value
		
		# When value reaches the minimum, switch direction to increasing.
		elif value <= 0:
			move_direction = 1
			value = 0

# Calculates damage based on how close to 50 the value is.
func calculate_damage(current_value):
	var deviation = abs(50 - current_value)
	# Assuming maximum damage is 100 and it decreases as deviation increases.
	var damage = max(100 - deviation * 2, 0)
	return damage
