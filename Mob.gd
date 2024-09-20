extends CharacterBody2D # using a 2D environment.
@onready var speed = randi_range(20,80) #MAYBE INCREASE MOB SPEED AS GAME PROGRESSES. 
@onready var player_target_position: Vector2 = Vector2.ZERO
@onready var player_2_target_position: Vector2 = Vector2.ZERO
@onready var player_pos: Vector2 = Vector2.ZERO
@onready var player_2_pos: Vector2 = Vector2.ZERO
@onready var direction: Vector2 = Vector2.ZERO # instead of DOWN as it is in player, as the player automatically starts moving down, this is set to ZERO, so the variable only measures the direction. 
@onready var min_x = 0 # the minimum x co-ordinate the player can be in as long as they stay in the map.
@onready var max_x = 1152 # the maximum x co-ord
@onready var min_y = 0 # min y co-ord
@onready var max_y = 648 # max y co-ord
@onready var spawned_today = false
@onready var spawn_and_despawn_called = false
@onready var sound_function_called = false

func _ready():
	spawn_in_random_location()
	 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.game_over == true:
		$AnimatedSprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		move_to_player()
		$AnimatedSprite2D.play("move_down")
		spawn_and_despawn()
		play_sound()
	

func move_to_player():
	if Global.single_player == true:
		if (Global.day_and_night % 2) == 0: # ensures the mob only moves during the night.
			player_pos = Global.player_position # and this corresponds to the other piece of code in the player.gd script, this one accessing the position from the global script. 
			player_target_position = (player_pos - global_position).normalized()
		
			if global_position.distance_to(player_pos) > 3:
				velocity = player_target_position * (speed * (1+(Global.day_and_night)*0.05)) # increases speed as game progresses.
				move_and_slide()
	else:
		if (Global.day_and_night % 2) == 0: # ensures the mob only moves during the night.
			player_pos = Global.player_position # and this corresponds to the other piece of code in the player.gd script, this one accessing the position from the global script. 
			player_2_pos = Global.player_2_position # this is the same as for player 1 position, but accessing fromg Global player 2's position, as it is provided into global from player 2's process function.
			player_target_position = (player_pos - global_position).normalized() # this gets the target position for the mob to move towards player 1.
			player_2_target_position = (player_2_pos - global_position).normalized() # this does the same thing, for player 2.
			
			if global_position.distance_to(player_pos) > global_position.distance_to(player_2_pos) and\
				global_position.distance_to(player_pos) > 3 and\
				player_2_pos != Vector2(-1,-1): # this parameter set checks if player 1 or 2 is closer to the mob, and chases player 1 if it's closer. it also ensures that the player isn't less than 3 away to keep from being inside the player. Finally, the last part checks if the player position is -1, -1, which is set once the player is dead and only possible then, as the position is clamped, so will only follow the closer player if the closer player is alive.
				velocity = player_2_target_position * (speed * (1+(Global.day_and_night)*0.05)) # increases speed as game progresses.
				move_and_slide()
			elif global_position.distance_to(player_2_pos) > global_position.distance_to(player_pos) and\
				global_position.distance_to(player_2_pos) > 3 and\
				player_pos != Vector2(-1,-1): # this parameter set pretty much does the same thing as the last, but makes the mob move towards the player 2 if it's closer. 
				velocity = player_target_position * (speed * (1+(Global.day_and_night)*0.05)) # increases speed as game progresses.
				move_and_slide()
			elif global_position.distance_to(player_2_pos) == global_position.distance_to(player_pos): # when player positions are the same (this addresses an issue where mobs would stop when both players were in teh same place), then:
				velocity = player_target_position * (speed * (1+(Global.day_and_night)*0.05)) # move toward player 1. (or 2, makes absolutely no difference)
			else:
				return

func spawn_and_despawn():
	if spawn_and_despawn_called:
		return
	else:
		spawn_and_despawn_called = true
		var first_value = Global.day_and_night
		await get_tree().create_timer(0.15).timeout
		var second_value = Global.day_and_night
		if first_value != second_value and (Global.day_and_night % 2) == 0 and spawned_today == false:
			spawned_today = true
			$AnimatedSprite2D.show()
			$CollisionShape2D.set_deferred("disabled", false)
			spawn_and_despawn_called = false
		elif first_value != second_value and (Global.day_and_night % 2) != 0:
			spawned_today = false
			print("done stuff")
			spawn_in_random_location()
			$AnimatedSprite2D.hide()
			$CollisionShape2D.set_deferred("disabled", true)
			spawn_and_despawn_called = false
		else:
			spawn_and_despawn_called = false

func spawn_in_random_location(): # this spawns the mob in a reandom location, which is no more than 200 pixels away from the player, to keep things fair. otherwise mobs will spawn on the player and instantly kill them, which sucks!
	var random_x = randf_range(min_x, max_x)
	var random_y = randf_range(min_y, max_y)
	var player_x = Global.player_position.x #VERY NOT AT ALL EFFICIENT, FIND A WAY TO IMPROVE!!!
	var player_y = Global.player_position.x
	var boss_mob_x = random_x
	var boss_mob_y = random_y
	if player_x < 0:
		player_x *= -1
	if player_y < 0:
		player_y *= -1
	if boss_mob_x < 0:
		boss_mob_x *= -1
	if boss_mob_x < 0:
		boss_mob_x *= -1
	var distance_x = player_x - boss_mob_x
	var distance_y = player_y - boss_mob_y
	if distance_x < 200 and distance_x > -200:
		spawn_in_random_location()
	if distance_y < 200 and distance_y > -200:
		spawn_in_random_location()
	else:
		position = Vector2(random_x, random_y)

# THE LARGE PART OF THE ANIMATION FUNCTION WAS REMOVED AS IT IS UNNECESSARY, 
# AND DIDN'T FUNCTION DUE TO THE DiFFERENT TYPE OF MOVEMENT FROM PLAYER TO MOB.


func play_sound():
	if sound_function_called:
		return
	else:
		sound_function_called = true
		var interval = randf_range(2,40)
		await get_tree().create_timer(interval).timeout
		if (Global.day_and_night % 2) == 0: # if it is still night after the timer ends.
			$AudioListener2D.make_current()
			$AudioStreamPlayer2D.pitch_scale = randf_range(0.1, 2)
			$AudioListener2D.global_position = global_position
			$AudioStreamPlayer2D.play()
			sound_function_called = false
		else:
			sound_function_called = false
