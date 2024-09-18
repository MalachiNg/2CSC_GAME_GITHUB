extends ColorRect
@export var radius : float = 100.0

var player_1_instance
var player_2_instance
var map = preload("res://Background.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
'''
func _draw():
	if Global.single_player == false:
		if player_1_instance != null and player_2_instance != null:
			var player_1_position = player_1_instance.global_position - global_position
			var player_2_position = player_2_instance.global_position - global_position
			
			draw_circle(player_1_position, radius, Color(6, 3, 8, 1))
			draw_circle(player_2_position, radius, Color(6, 3, 8, 1))
			
'''

func _process(_delta):
	pass


