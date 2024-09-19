extends Node

var player_position: Vector2 = Vector2.ZERO
var player_2_position : Vector2 = Vector2.ZERO
var day_and_night: int = 0
var global_fuel: int = 0
var game_over = false
var daytime_process = false
var single_player = true
var multiplayer_game_over : int  = 0
var Player = preload("res://Player.tscn")

func update_player_2_position(pos: Vector2):
	player_2_position = pos

func update_player_position(pos: Vector2): # called function update_player_position, with the variable in the parameter being a Vector2 Variable.
	player_position = pos # the player_position variable is set to the Vector2 Variable in the parameter.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame. 
func _process(_delta):
	if multiplayer_game_over == 2:
		game_over = true
	# update_player_position($Player.global_position()) # instead of this, the player position is updated from the player scene. 
	if (day_and_night % 2) != 0: #this checks if it is day, to check if the following should be run.
		if daytime_process: # this prevents this being run multiple times.
			return
		else:
			daytime_process = true 
			await get_tree().create_timer(30.0).timeout # this times the day, after 30 seconds it times out and makes the day turn back into night.
			if day_and_night != 0: # this patches a potential error, as when re playing the game, this timer continues, so this could cause, if the player died during the day, the night to randomly turn to day for no reason. However, since day_and_night is reset to 0 in new playthroughs from the main scene, and this code doesn't run until minimum day_and_night = 1, this small line of code patches that potential error with no possible repercussions.
				day_and_night += 1
				daytime_process = false
			
	
func update_day_and_night(new_day_or_night_value: int):
	day_and_night = new_day_or_night_value

func update_fuel(fuel_var):
	global_fuel = fuel_var

func update_game_over(is_game_over: bool):
	game_over = is_game_over
	
func update_single_player(true_or_false : bool):
	single_player = true_or_false
	
func update_multiplayer_game_over(new_game_over : int):
	multiplayer_game_over = new_game_over
