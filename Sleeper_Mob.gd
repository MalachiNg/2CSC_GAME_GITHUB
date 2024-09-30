extends CharacterBody2D # using a 2D environment.
@onready var speed = 150
@onready var player_target_position: Vector2 = Vector2.ZERO
@onready var player_2_target_position: Vector2 = Vector2.ZERO
@onready var player_pos: Vector2 = Vector2.ZERO
@onready var player_2_pos: Vector2 = Vector2.ZERO
@onready var spawned_today = false
@onready var spawn_and_despawn_called = false
@onready var player_in_proximity = false
@onready var despawned_tonight = false

func _ready():
	spawn_in_random_location()
	 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.game_over == true:
		$AnimatedSprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
		$Proximity_Area2D/Proximity_CollisionShape2D.set_deferred("disabled", true) # disable the proximity collisionshape.
	else:
		spawn_and_despawn()
		if player_in_proximity == true:
			move_to_player()

func move_to_player():
	if Global.single_player == true:
		if (Global.day_and_night % 2) == 0: # ensures the mob only moves during the night.
			player_pos = Global.player_position # and this corresponds to the other piece of code in the player.gd script, 
			# this one accessing the position from the global script. 
			player_target_position = (player_pos - global_position).normalized()
		
			if global_position.distance_to(player_pos) > 3:
				velocity = player_target_position * (speed * (1+(Global.day_and_night)*0.05)) 
				# increases speed as game progresses.
				move_and_slide()
				if (player_pos.x - global_position.x) < 0: # if the player's x co -ord is less than sleeper mob's:
					$AnimatedSprite2D.play("move_left") # this means player is to the left, 
					# so play the corresponding animation.
				else:
					$AnimatedSprite2D.play("move_right") # if not, move right.
	else:
		if (Global.day_and_night % 2) == 0: # ensures the mob only moves during the night.
			player_pos = Global.player_position # and this corresponds to the other piece of code in the player.gd script, 
			# this one accessing the position from the global script. 
			player_2_pos = Global.player_2_position # this is the same as for player 1 position, 
			# but accessing fromg Global player 2's position, as it is provided into global from player 2's process function.
			player_target_position = (player_pos - global_position).normalized() 
			# this gets the target position for the mob to move towards player 1.
			player_2_target_position = (player_2_pos - global_position).normalized() 
			# this does the same thing, for player 2.
			
			if global_position.distance_to(player_pos) > global_position.distance_to(player_2_pos) and\
				global_position.distance_to(player_pos) > 3 and\
				player_2_pos != Vector2(-1,-1): 
					# this parameter set checks if player 1 or 2 is closer to the mob, and chases player 2 if it's closer. 
					# it also ensures that the player isn't less than 3 away to keep from being inside the player. 
					# Finally, the last part checks if the player position is -1, -1, 
					# which is set once the player is dead and only possible then, as the position is clamped, 
					# so will only follow the closer player if the closer player is alive.
				velocity = player_2_target_position * (speed * (1+(Global.day_and_night)*0.05)) 
				# increases speed as game progresses.
				move_and_slide()
				if (player_2_pos.x - global_position.x) < 0: # if the player 2's x co -ord is less than sleeper mob's:
					$AnimatedSprite2D.play("move_left") # this means player 2 is to the left, 
					# so play the corresponding animation.
				else:
					$AnimatedSprite2D.play("move_right") # if not, move right.
			elif global_position.distance_to(player_2_pos) > global_position.distance_to(player_pos) and\
				global_position.distance_to(player_2_pos) > 3 and\
				player_pos != Vector2(-1,-1): 
				# this parameter set pretty much does the same thing as the last, 
				# but makes the mob move towards the player 2 if it's closer. 
				velocity = player_target_position * (speed * (1+(Global.day_and_night)*0.05)) 
				# increases speed as game progresses.
				move_and_slide()
				if (player_pos.x - global_position.x) < 0: # if the player 2's x co -ord is less than sleeper mob's:
					$AnimatedSprite2D.play("move_left") # this means player 2 is to the left, 
					# so play the corresponding animation.
				else:
					$AnimatedSprite2D.play("move_right") # if not, move right.
			elif global_position.distance_to(player_2_pos) == global_position.distance_to(player_pos): 
				# when player positions are the same 
				# (this addresses an issue where mobs would stop when both players were in teh same place), then:
				velocity = player_2_target_position * (speed * (1+(Global.day_and_night)*0.05)) 
				# move toward player 1. (or 2, makes absolutely no difference)
				move_and_slide()
				if (player_pos.x - global_position.x) < 0: # if the player 2's x co -ord is less than sleeper mob's:
					$AnimatedSprite2D.play("move_left") # this means player 2 is to the left, so play the corresponding animation.
				else:
					$AnimatedSprite2D.play("move_right") # if not, move right.
			elif player_2_pos == Vector2(-1,-1): # if player 2 is dead, (since they move to -1, -1 when dead, and can't go there otherwise, then.
				velocity = player_target_position * (speed * (1+(Global.day_and_night)*0.05)) # move to player 1.
				move_and_slide()
				if (player_pos.x - global_position.x) < 0: # if the player 2's x co -ord is less than sleeper mob's:
					$AnimatedSprite2D.play("move_left") # this means player 2 is to the left, 
					# so play the corresponding animation.
				else:
					$AnimatedSprite2D.play("move_right") # if not, move right.
			elif player_pos == Vector2(-1,-1): # if player 1 is dead, then:
				velocity = player_2_target_position * (speed * (1+(Global.day_and_night)*0.05)) # move to player 2.
				move_and_slide()
				if (player_2_pos.x - global_position.x) < 0: # if the player 2's x co -ord is less than sleeper mob's:
					$AnimatedSprite2D.play("move_left") # this means player 2 is to the left, 
					# so play the corresponding animation.
				else:
					$AnimatedSprite2D.play("move_right") # if not, move right.

func spawn_and_despawn():
	if (Global.day_and_night % 2) != 0 and despawned_tonight == false: # if it is day and this hasn't run before:
		despawned_tonight = true # prevents this section from running again.
		spawned_today = false # allows the next section to run once during night.
		$AnimatedSprite2D.hide() # hide
		$CollisionShape2D.set_deferred("disabled", true) # disable Collision Shape.
		$Proximity_Area2D/Proximity_CollisionShape2D.set_deferred("disabled", true) # disables the proximity collision shape.
		spawn_in_random_location()
		# this section is put here, as variables like spawned_today mean that it isn't running always.
		# Also, a reccurring error in the previous version of this code, where the code here was in the later section.
		# This error meant that if the user changed to day in the time between the end of the 0.15 seconds, 
		# and the start of the next calling of first_value, then:
		# the mobs would freeze, yet still be visible and touchable. 
		# this solves that error, without also making it less optimised. 
	elif (Global.day_and_night % 2) == 0 and spawned_today == false:
		spawned_today = true # prevents this running again.
		despawned_tonight = false # allows the last section to run again during day.
		$AnimatedSprite2D.show()
		$CollisionShape2D.set_deferred("disabled", false)
		$Proximity_Area2D/Proximity_CollisionShape2D.set_deferred("disabled", false) 
		# enables the proximity collision shape. 




func spawn_in_random_location(): 
	# this spawns the mob in a reandom location, 
	# which is no more than 200 pixels away from the player, to keep things fair. 
	# otherwise mobs will spawn on the player and instantly kill them, which sucks!
	var random_x = randf_range(0, 1152) # generates a random x value within the co-ordinates of the map.
	var random_y = randf_range(0, 648) # generates a random y value within the co-ordinates of the map.
	var distance_to_player = Vector2(random_x, random_y).distance_to(Global.player_position) 
	# finds the distance from the random mob position to the player
	if Global.single_player == false:
		var distance_to_player_2 = Vector2(random_x, random_y).distance_to(Global.player_2_position) # finds the distance from the random mob position to the player
		if distance_to_player_2 < 300:
			spawn_in_random_location()
	if distance_to_player < 300: 
		# if the distance to player is less than 300, then: (greater as there is the proximity collisionshape to consider)
		spawn_in_random_location() # try again, this continues until the mob spawns outside of this 150 pixel radius.
		# This prevents the game from being unfair, as if mobs can spawn really close to the player, 
		# leaving the player with no time to react, this is unfair. 
	else:
		global_position = Vector2(random_x, random_y) 
		# if the random position is not less than 300 from the player, 
		# then spawn there.






func _on_proximity_area_2d_area_entered(area):
	player_in_proximity = true




func _on_proximity_area_2d_area_exited(area):
	player_in_proximity = false
