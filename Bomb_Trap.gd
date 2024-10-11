extends Area2D
@onready var food: int
@onready var show_at_day = Global.day_and_night
@onready var min_x = 0 # the minimum x co-ordinate the player can be in as long as they stay in the map.
@onready var max_x = 1152 # the maximum x co-ord
@onready var min_y = 0 # min y co-ord
@onready var max_y = 648 # max y co-ord
@onready var spawned_today = false


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_in_random_location()
	$AnimatedSprite2D.show() # CHANGE BACK TO HIDE, THIS IS FOR DEBUGGING.
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite2D.play("Bomb")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.game_over == true:
		$AnimatedSprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		show_and_hide()


func show_and_hide():
	show_at_day = Global.day_and_night
	if (show_at_day % 2) == 0:
		if spawned_today:
			return
		else:
			spawned_today = true
			$AnimatedSprite2D.show()
			$CollisionShape2D.set_deferred("disabled", false)
	else:
		$AnimatedSprite2D.hide() 
		$CollisionShape2D.set_deferred("disabled", true)
		spawned_today = false


func spawn_in_random_location():
	var random_x = randf_range(min_x, max_x)
	var random_y = randf_range(min_y, max_y)
	position = Vector2(random_x, random_y)


func _on_body_entered(body):
	if body.is_in_group("Player"):
		$AnimatedSprite2D.scale = Vector2(0.1,0.1)
		$AnimatedSprite2D.play("Explosion")


func _on_body_exited(body):
	if body.is_in_group("Player"):
		$CollisionShape2D.set_deferred("disabled", true)
		spawn_in_random_location()
		$AnimatedSprite2D.hide()
		$AnimatedSprite2D.scale = Vector2(0.02,0.02)


func _on_area_entered(area):
	if area.is_in_group("Player"):
		$AnimatedSprite2D.scale = Vector2(0.1,0.1)
		$AnimatedSprite2D.play("Explosion")


func _on_area_exited(area):
	if area.is_in_group("Player"):
		$CollisionShape2D.set_deferred("disabled", true)
		spawn_in_random_location()
		$AnimatedSprite2D.hide()
		$AnimatedSprite2D.scale = Vector2(0.02,0.02)
