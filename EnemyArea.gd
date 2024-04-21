extends Area

func _ready():
	# Wait until the end of the current frame to ensure all nodes are fully loaded
	call_deferred("setup_signal_connections")

func setup_signal_connections():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		print("Player found, signals would have been connected...")
		print("Collision Layer (Player):", player.collision_layer)
		print("Collision Mask (Area):", collision_mask)
	else:
		print("Player node not found!")

# In the EnemyArea script
func _process(delta):
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		var distance = global_transform.origin.distance_to(player.global_transform.origin)
		print("Distance to Player:", distance)
		if distance < 10:  # If within 10 units, consider it as 'area entered'
			print("Player is within 10 units of the EnemyArea.")
			if not player.is_in_group("triggered"):  # Avoid multiple triggers
				player.add_to_group("triggered")
				_on_Area_entered(player)

func _on_Area_entered(body):
	print("Manual area entry triggered by:", body.name)
	if body.is_in_group("players"):
		print("Player has manually entered the goal area!")
		switch_to_battle_scene()

func switch_to_battle_scene():
	# Assuming your battle scene is saved as "res://BattleScene.tscn"
	var battle_scene = preload("res://battle.tscn").instance()
	get_tree().current_scene.queue_free()  # Remove the current scene
	get_tree().root.add_child(battle_scene)  # Add the new scene
	get_tree().set_current_scene(battle_scene)  # Make it the current scene
