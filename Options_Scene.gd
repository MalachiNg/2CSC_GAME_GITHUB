extends Node
@onready var Selected_1_Player = preload("res://Selected_1_Player.png")
@onready var Unselected_1_Player = preload("res://Unselected_1_Player.png")
@onready var Selected_2_Players = preload("res://Selected_2_Players.png")
@onready var Unselected_2_Players = preload("res://Unselected_2_Players.png")



# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.single_player == true:
		Selected_Single_Player()
	else:
		Selected_Multiplayer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass




func _on_single_player_button_pressed():
	Global.update_single_player(true)
	Selected_Single_Player()
	
# 2 selected is slightly smaller

func _on_multiplayer_button_pressed():
	Global.update_single_player(false)
	Selected_Multiplayer()
	

func Selected_Multiplayer():
	$Single_Player_Button.icon = Unselected_1_Player
	$Single_Player_Button.scale = Vector2(0.59, 0.59)
	$Single_Player_Button.position = Vector2(231, 393)
	$Multiplayer_Button.icon = Selected_2_Players
	$Multiplayer_Button.scale = Vector2(0.85, 0.85)
	$Multiplayer_Button.position = Vector2(46, 518)

func Selected_Single_Player():
	$Single_Player_Button.icon = Selected_1_Player
	$Single_Player_Button.position = Vector2(50, 378)
	$Single_Player_Button.scale = Vector2(0.75, 0.75)
	$Multiplayer_Button.icon = Unselected_2_Players
	$Multiplayer_Button.position = Vector2(167, 526)
	$Multiplayer_Button.scale = Vector2(0.75, 0.75)
	



func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Start_scene.tscn")


func _on_next_button_pressed():
	pass # Replace with function body.
