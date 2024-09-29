extends Area2D
@onready var food: int
@onready var show_at_day = Global.day_and_night
@onready var skins = { # HERE IS MY DICTIONARY!!! (:-D)
	0 : "apple", 
	1 : "burger", 
	2 : "chicken_drumstick", 
	3 : "doughnut", 
	4 : "pear",
} 
@onready var skin_num : int
@onready var min_x = 0 
# the minimum x co-ordinate the player can be in as long as they stay in the map.
@onready var max_x = 1152 # the maximum x co-ord
@onready var min_y = 0 # min y co-ord
@onready var max_y = 648 # max y co-ord
@onready var spawned_today = false


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_in_random_location()
	$CollisionShape2D.set_deferred("disabled", true)
	show_skin()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.game_over == true:
		$AnimatedSprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		show_and_hide()


func _on_area_entered(area):
	if area.is_in_group("Player"):
		$AnimatedSprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
		spawn_in_random_location()


func show_and_hide():
	show_at_day = Global.day_and_night
	if (show_at_day % 2) == 1:
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


func show_skin():
	skin_num = randi_range(0, 4)
	var skin = skins[skin_num]
	$AnimatedSprite2D.play(skin)


func spawn_in_random_location():
	var random_x = randf_range(min_x, max_x)
	var random_y = randf_range(min_y, max_y)
	position = Vector2(random_x, random_y)
