extends Panel

var clicks = 0

signal clicks_counted(clicks)

func _ready():
	show()

func _on_HealSmashButton_pressed():
	clicks += 1
	print("Button pressed. Total clicks:", clicks)

func emit_clicks():
	emit_signal("clicks_counted", clicks)
	clicks = 0  # Reset clicks after emitting the signal
	print("Signal emitted with clicks count:", clicks)

