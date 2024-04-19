extends ProgressBar

# The speed at which the progress bar fills up.
var fill_speed = 10  # Adjust the fill speed as per your game's requirements.
# Indicates whether the bar is currently moving forward.
var is_increasing = true

func _ready():
	value = 0  # Start at 0

# Called when the Attack button is pressed to stop and calculate damage.
func on_attack_button_pressed():
	# Calculate damage based on how close the value is to 50.
	var damage = calculate_damage(value)
	# TODO: Apply damage to the enemy here.
	print("Damage dealt: ", damage)

# Called every frame. Moves the progress bar value back and forth.
func _process(delta):
	if is_increasing:
		value += fill_speed * delta
		if value >= max_value:
			# Once the maximum is reached, start decreasing
			is_increasing = false
	else:
		value -= fill_speed * delta
		if value <= min_value:
			# Once the minimum is reached, start increasing
			is_increasing = true

# Calculates damage based on how close to 50 the value is.
func calculate_damage(current_value):
	var deviation = abs(50 - current_value)
	# Assuming maximum damage is 100 and it decreases as deviation increases.
	var damage = max(100 - deviation * 2, 0)
	return damage
