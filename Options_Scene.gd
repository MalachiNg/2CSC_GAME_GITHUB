extends Node
const Selected_1_Player = preload("res://Selected_1_Player.png")
const Unselected_1_Player = preload("res://Unselected_1_Player.png")
const Selected_2_Players = preload("res://Selected_2_Players.png")
const Unselected_2_Players = preload("res://Unselected_2_Players.png")
@onready var page = 1
var selected_Normal
var unselected_Normal
var selected_Hard 
var unselected_Hard 
var Selected_Unmute 
var Unselected_Unmute
var Selected_Mute
var Unselected_Mute



# Called when the node enters the scene tree for the first time.
func _ready():
	print("loaded on")
	$Normal_Mode_Button.hide()
	$Hard_Mode_Button.hide()
	$Mute_Button.hide() 
	$Unmute_Button.hide()
	if Global.single_player == true:
		Selected_Single_Player()
	else:
		Selected_Multiplayer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if page == 1:
		$Single_or_Multiplayer_TextureRect.show() ; $Single_Player_Button.show() ; $Multiplayer_Button.show()
		$Mute_or_Unmute_TextureRect.hide() ; $Normal_or_Hard_Mode_TextureRect.hide()
	elif page == 2:
		$Normal_or_Hard_Mode_TextureRect.show()
		$Single_or_Multiplayer_TextureRect.hide() ; $Mute_or_Unmute_TextureRect.hide() 
		$Single_Player_Button.hide() ; $Multiplayer_Button.hide()
		$Hard_Mode_Button.show() ; $Normal_Mode_Button.show()
		normal_or_hard()
	
	elif page == 3:
		$Mute_or_Unmute_TextureRect.show()
		$Single_or_Multiplayer_TextureRect.hide() ; $Normal_or_Hard_Mode_TextureRect.hide() ; $Next_Button.hide()
		$Hard_Mode_Button.hide() ; $Normal_Mode_Button.hide()
		mute_or_unmute()




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
	page += 1
	if page == 2:
		selected_Normal = preload("res://Normal_Mode_Selected.png")
		unselected_Normal = preload("res://Normal_Mode_Button.png")
		selected_Hard = preload("res://Hard_Mode_Selected.png")
		unselected_Hard = preload("res://Hard_Mode_Button.png")
	else:
		Selected_Unmute = preload("res://Selected_Unmute.png")
		Unselected_Unmute = preload("res://Unselected_Unmute.png")
		Selected_Mute = preload("res://Selected_Mute.png")
		Unselected_Mute = preload("res://Unselected_Mute.png")

func normal_or_hard():
	if Global.Normal_mode == true:
		$Normal_Mode_Button.icon = selected_Normal
		$Hard_Mode_Button.icon = unselected_Hard
	else:
		$Normal_Mode_Button.icon = unselected_Normal
		$Hard_Mode_Button.icon = selected_Hard



func _on_hard_mode_button_pressed():
	Global.update_normal_mode(false)
	$Normal_Mode_Button.icon = unselected_Normal
	$Hard_Mode_Button.icon = selected_Hard



func _on_normal_mode_button_pressed():
	Global.update_normal_mode(true)
	$Normal_Mode_Button.icon = selected_Normal
	$Hard_Mode_Button.icon = unselected_Hard


func _on_unmute_button_pressed():
	Global.update_unmute(true)
	$Unmute_Button.icon = Selected_Unmute
	$Mute_Button.icon = Unselected_Mute



func _on_mute_button_pressed():
	Global.update_unmute(false)
	$Unmute_Button.icon = Unselected_Unmute
	$Mute_Button.icon = Selected_Mute
	

func mute_or_unmute():
	$Mute_Button.show() ; $Unmute_Button.show()
	if Global.Unmute == true:
		$Mute_Button.icon = Unselected_Mute
		$Unmute_Button.icon = Selected_Unmute
	else:
		$Mute_Button.icon = Selected_Mute
		$Unmute_Button.icon = Unselected_Unmute
