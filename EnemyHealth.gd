extends TextureProgress

# Enemy's maximum health
var max_health = 100

func _ready():
	value = max_health  # This sets the current fill of the progress bar
	max_value = max_health  # This sets the maximum value of the progress bar
