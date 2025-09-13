extends Node

var player_position: Vector2 = Vector2.ZERO
var player_2_position: Vector2 = Vector2.ZERO
var day_and_night: int = 0
var global_fuel: int = 0
var game_over = false
var daytime_process_declarations: int = 0
var single_player = true
var multiplayer_game_over: int = 0
var Player = preload("res://Player.tscn")
var Normal_mode = true
var Unmute = true
var player_2_died_from: int = 0
var WASD_and_arrows = true
var instructions_opened = false
var nights_goal : int = 0
var instructions_opened_text_file = "user://instructions_opened.txt"

func _ready():
	#reset_high_score() # this resets the values of the txt's in user
	#reset_instructions_opened() # same thing - ensure both are inactive before exporting
	var instructions_opened_boolean = get_text_file_content(instructions_opened_text_file) # keeping same name as in other func, 
	# as the variables are local.
	if not instructions_opened_boolean: # for whatever reason, 
		# instructions_file_as_text.find("true") returns true when it isnt found, and false when it is, 
		# therefore is instructions opened bool is false, then set instructions opened to true. 
		instructions_opened = true

func get_text_file_content(filePath):
	var access_instructions_file = FileAccess.open(filePath, FileAccess.READ)
	if access_instructions_file == null:
		return false # if the file can't load for whatever reason, assume they've never opened the instructions section.
		print("Instructions opened txt file failed to load. ")
	var instructions_file_as_text = access_instructions_file.get_as_text()
	var instructions_opened_boolean : bool
	instructions_opened_boolean = instructions_file_as_text.find("true")
	return instructions_opened_boolean

func update_player_2_position(pos: Vector2):
	player_2_position = pos


func update_player_position(pos: Vector2):  # called function update_player_position, with the variable in the parameter being a Vector2 Variable.
	player_position = pos  # the player_position variable is set to the Vector2 Variable in the parameter.


func daytime_process():
	if (day_and_night % 2) != 0:  # this checks if it is day, to check if the following should be run.
		daytime_process_declarations += 1
		var start_daytime_process_value = daytime_process_declarations
		await get_tree().create_timer(15.0).timeout  # this times the day, after 15 seconds it times out and makes the day turn back into night.
		if daytime_process_declarations == start_daytime_process_value:
			if day_and_night != 0:
				# this patches a potential error, as when re playing the game, this timer continues, so this could cause,
				# if the player died during the day, the night to randomly turn to day for no reason.
				# However, since day_and_night is reset to 0 in new playthroughs from the main scene,
				# and this code doesn't run until minimum day_and_night = 1,
				# this small line  of code patches that potential error with no possible repercussions.
				if not game_over:
					day_and_night += 1
					Signals.daytime_over.emit()


func update_day_and_night(new_day_or_night_value: int):
	day_and_night = new_day_or_night_value
	daytime_process()


func update_fuel(fuel_var):
	global_fuel = fuel_var


func update_game_over(is_game_over: bool):
	game_over = is_game_over


func update_single_player(true_or_false: bool):
	single_player = true_or_false
	# the following prevents an error where cursor can be used in multiplayer,
	#  if multiplayer is selected after cursor control mode.
	if not true_or_false:
		update_WASD_and_arrows(true)  # this sets controls to WASD and arrows in multiplayer.


func update_multiplayer_game_over(new_game_over: int):
	multiplayer_game_over = new_game_over
	if multiplayer_game_over == 2:
		game_over = true


func update_normal_mode(boolean_value: bool):
	Normal_mode = boolean_value


func update_unmute(mute_or_unmute: bool):
	Unmute = mute_or_unmute


func update_player_2_died_from(died_from: int):
	player_2_died_from = died_from


# FUTURE IDEA: (THANS TO ROSE :D)
# ON GOING INTO NIGHT, PAUSE MAIN, CANCEL CAMERA ZOOM TO VIEW THE WHOLE MAP, AND DISPLAY FUEL LOCATION FOR 2 SECONDS.
# THEN FADE CANVASLAYER INTO EXISTENCE OF BLACKNESS, AND THEN TRANSITION INTO NIGHT, UNPAUSE MAIN.
# THIS MEANS THAT ITS ACTUALLY MEMORY, NOT LUCK.
# This has been successfully implimented! :D


func update_WASD_and_arrows(new_bool_value: bool):
	WASD_and_arrows = new_bool_value


func update_instructions_opened():
	# this one doesn't get changed back to false, so doesn't need the same bool_variable : bool, instructions_opened = bool_variable thing.
	instructions_opened = true # changes it for this run
	# changes it for the next runs:
	var instructions_opened_content = FileAccess.open(instructions_opened_text_file, FileAccess.WRITE)
	instructions_opened_content.store_string("true")

func update_nights_goal(goal : int):
	nights_goal = goal

'''

# these correspond to the functions called in the top of func _ready():, 
# and reset the values in the .txt files in user://

func reset_high_score():
	var file_path = "user://local_high_score.txt"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string("0")  # Reset to 0
	file.close()

func reset_instructions_opened():
	var file_path = "user://instructions_opened.txt"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string("false")  # Reset to 0
	file.close()
'''
