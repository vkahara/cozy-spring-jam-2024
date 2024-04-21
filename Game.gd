extends Node

var current_level = 1  # Start from level 1

func advance_level():
	current_level += 1  # Move to the next level

func get_next_world_scene_path():
	return "res://world%d.tscn" % current_level
