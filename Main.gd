extends Spatial

func _ready():
	load_current_level_world()

func load_current_level_world():
	var current_world_path = Game.get_next_world_scene_path()
	if current_world_path != "":
		var world_scene = load(current_world_path).instance()
		for child in get_children():
			if child.name.begins_with("world"):
				remove_child(child)
				child.queue_free()
		add_child(world_scene)
		world_scene.name = "world"
	else:
		# If there's no next world, the game should be over, handle accordingly
		print("No more worlds to load. Should switch to credits if not already handled.")
