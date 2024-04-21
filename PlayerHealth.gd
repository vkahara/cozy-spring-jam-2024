# Node2D/CanvasLayer/Playerhealth/PlayerHealth.gd
# (this script is attached to textureprogress which is attached to a progressbar)

extends TextureProgress

var max_health = 100  # Maximum health of the player

func _ready():
	value = max_health
	max_value = max_health

func take_damage(damage):
	value -= damage
	if value <= 0:
		game_over()


func heal(amount):
	value += amount
	value = min(value, max_value)  # Ensure we don't go over max health
	print("Healing applied, new health: ", value)
	
	
func game_over():
	print("Player defeated!")
	var game_end_panel = get_node("/root/Node2D/CanvasLayer/GameEndPanel")
	if game_end_panel:
		game_end_panel.get_node("Label").text = "Game Over! You have been defeated."
		game_end_panel.show()
		# Delay scene change to allow player to read message
		yield(get_tree().create_timer(3.0), "timeout")
		get_tree().change_scene("res://Main.tscn")
	else:
		print("GameEndPanel not found. Check the node path.")
		get_tree().change_scene("res://Main.tscn")





