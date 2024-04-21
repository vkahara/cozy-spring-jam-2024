extends Node

var current_level = 1  # Start from level 1
var total_levels = 4  # Assume there are 4 levels

func advance_level():
	current_level += 1
	if current_level > total_levels:
		# Game over, go to credits
		get_tree().change_scene("res://Credits.tscn")
	else:
		# Normal level progression
		get_tree().change_scene("res://Main.tscn")

func get_next_world_scene_path():
	if current_level <= total_levels:
		return "res://world%d.tscn" % current_level
	return ""
