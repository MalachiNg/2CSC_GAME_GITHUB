extends Area2D
@onready var min_x = 50 # the minimum x co-ordinate the player can be in as long as they stay in the map.
@onready var max_x = 1052 # the maximum x co-ord
@onready var min_y = 50 # min y co-ord
@onready var max_y = 608 # max y co-ord
@onready var hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_in_random_location()
	$AnimatedSprite2D.show()
	$CollisionShape2D.disabled = false
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	show_and_hide()





func _on_area_entered(area):
	if area.is_in_group("Player"):
		$AnimatedSprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
		spawn_in_random_location()
		hit = true
	else:
		return


func show_and_hide():
	if (Global.day_and_night % 2) == 0:
		if hit == false:
			$AnimatedSprite2D.show()
			$CollisionShape2D.disabled = false
		else:
			return
	else:
		hit = false
		$AnimatedSprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)


func spawn_in_random_location():
	var random_x = randf_range(min_x, max_x)
	var random_y = randf_range(min_y, max_y)
	position = Vector2(random_x, random_y)

