extends KinematicBody

# Movement speed, rotation speed, gravity, and jump power.
var speed = 200.0
var rotation_speed = 1.0
var gravity = -80.0  # Negative value to pull down
var flap_power = 100.0  # The power of each flap upwards
var vertical_velocity = 0.0  # Current vertical speed

# Physics process runs every fixed frame
func _physics_process(delta):
	var forward_backward = 0
	var rotation_dir = 0

	# Check for movement and rotation input.
	if Input.is_action_pressed("ui_up"):  # Move forward
		forward_backward += 1
	if Input.is_action_pressed("ui_down"):  # Move backward
		forward_backward -= 1
	if Input.is_action_pressed("ui_right"):  # Rotate left
		rotation_dir -= 1
	if Input.is_action_pressed("ui_left"):  # Rotate right
		rotation_dir += 1
	if Input.is_action_just_pressed("flap"):  # Flap upwards
		vertical_velocity = flap_power

	# Apply gravity to the vertical velocity
	vertical_velocity += gravity * delta

	# Apply rotation to the player.
	rotation.y += rotation_dir * rotation_speed * delta

	# Calculate the forward movement vector, including vertical movement.
	var movement = Vector3(0, vertical_velocity * delta, -forward_backward * speed * delta).rotated(Vector3(0, 1, 0), rotation.y)

	# Move the player.
	move_and_slide(movement, Vector3.UP)
