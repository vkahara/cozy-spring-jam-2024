extends KinematicBody

# Movement speed, rotation speed, gravity, and jump power.
var speed = 800.0
var rotation_speed = 5.0
var gravity = -650
var flap_power = 550.0
var vertical_velocity = 19.0

var max_flaps = 5  # Maximum number of flaps before needing to land
var flaps_left = max_flaps  # Current number of flaps left

var sound_played = false

func _ready():
	add_to_group("players")


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

	# Handle flapping if flaps are available.
	if Input.is_action_just_pressed("flap") and flaps_left > 0:
		vertical_velocity = flap_power
		flaps_left -= 1  # Decrease flap count
		$AudioStreamPlayer3D.play()

	# Apply gravity to the vertical velocity
	vertical_velocity += gravity * delta

	# Apply rotation to the player.
	rotation.y += rotation_dir * rotation_speed * delta

	# Calculate the forward movement vector, including vertical movement.
	var movement = Vector3(0, vertical_velocity * delta, -forward_backward * speed * delta).rotated(Vector3(0, 1, 0), rotation.y)

	# Move the player and check if it's on the ground.
	if is_on_floor():
		flaps_left = max_flaps  # Reset flaps if the player has landed

	# Move the player.
	move_and_slide(movement, Vector3.UP)
