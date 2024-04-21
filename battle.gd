#battle.gd

extends Node2D

enum Turn { PLAYER, ENEMY }
var current_turn = Turn.PLAYER
var max_health = 100
var player_current_health = max_health
var enemy_current_health = max_health

# Signal to update health UI (connect this signal to health bar nodes)
signal update_player_health(health)
signal update_enemy_health(health)

func take_damage(target, amount):
	if target == "player":
		player_current_health -= amount
		player_current_health = max(player_current_health, 0)  # Ensure health doesn't go below 0
		emit_signal("update_player_health", player_current_health)
		if player_current_health == 0:
			end_game("Enemy wins!")
		else:
			player_turn()  # Give turn back to player if they're still alive

	elif target == "enemy":
		enemy_current_health -= amount
		enemy_current_health = max(enemy_current_health, 0)
		emit_signal("update_enemy_health", enemy_current_health)
		if enemy_current_health == 0:
			end_game("Player wins!")
		else:
			enemy_turn()

func player_turn():
	current_turn = Turn.PLAYER
	# Show the player attack panel (mini-game).
	# $CanvasLayer/Panel3.visible = true   # Remove this line to prevent automatic opening.
	# Disable the outer attack button while the mini-game is active.
	$CanvasLayer/Panel2/Button.disabled = true
	$CanvasLayer/Panel/Attack.disabled = false   # Make sure this is enabled so the player can initiate the mini-game.


func enemy_turn():
	current_turn = Turn.ENEMY
	# Hide the player attack panel (mini-game).
	$CanvasLayer/Panel3.visible = false
	# Simulate enemy attack after 2 seconds.
	yield(get_tree().create_timer(2.0), "timeout")  # Wait for 2 seconds
	var damage = rand_range(10, 60)
	# Ensure the path to the PlayerHealth node is correct
	var player_health = get_node("CanvasLayer/PlayerHealth/TextureProgress")
	if player_health and player_health.has_method("take_damage"):
		player_health.take_damage(damage)
	else:
		print("PlayerHealth node or take_damage function not found. Check the node path and function.")


func _ready():
	randomize()  # Initialize random number generator.
	$CanvasLayer/Panel3.visible = false
	player_turn()  # Start with the player's turn.
	connect_health_bars()
	
func end_player_turn():
	current_turn = Turn.ENEMY
	enemy_turn()

func connect_health_bars():
	# Connect the signals to health bar nodes to update UI.
	var player_health_bar = get_node("CanvasLayer/PlayerHealth")
	var enemy_health_bar = get_node("CanvasLayer/EnemyHealth/TextureProgress")
	connect("update_player_health", player_health_bar, "set_value")
	connect("update_enemy_health", enemy_health_bar, "set_value")
	# Initialize health bars.
	player_health_bar.max_value = max_health
	player_health_bar.value = player_current_health
	enemy_health_bar.max_value = max_health
	enemy_health_bar.value = enemy_current_health

func end_game(message):
	print(message)
	# Show the game end panel with a message, disable all controls, etc.
	$CanvasLayer/GameEndPanel.visible = true
