#panel3.gd (the minigame panel)

extends Panel

func _ready():
	hide()  # This hides Panel3 when the game starts.
	print("Panel3 is hidden on start")  # Debug statement.

# A function to toggle visibility.
func toggle_visibility():
	if is_visible_in_tree():
		hide()
	else:
		show()
