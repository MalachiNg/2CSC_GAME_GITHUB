extends Node
@onready var page = 1
const page_1 = preload("res://INSTRUCTIONS_page_1.png")
const page_2 = preload("res://INSTRUCTIONS_page_2.png")
const page_3 = preload("res://INSTRUCTIONS_page_3.png")
const page_4 = preload("res://INSTRUCTIONS_page_4.png")
const page_5 = preload("res://INSTRUCTIONS_page_5.png")
const page_6 = preload("res://INSTRUCTIONS_page_6.png")
const page_7 = preload("res://INSTRUCTIONS_page_7.png")
const page_8 = preload("res://INSTRUCTIONS_page_8.png")
const page_9 = preload("res://INSTRUCTIONS_page_9.png")


func _ready():
	$TextureRect.texture = preload("res://INSTRUCTIONS_page_1.png")
	Global.update_instructions_opened()
	$Next_Button.global_position = Vector2(920, 560)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$TextureRect.show()
	$TextureRect.size = Vector2(1152, 648)
	if page == 1:
		$TextureRect.texture = page_1
	elif page == 2:
		$Back_Button.scale = Vector2(0.35, 0.35)
		$TextureRect.texture = page_2
		$Next_Button.global_position = Vector2(960, 530)
	elif page == 3:
		$TextureRect.texture = page_3
		$Next_Button.global_position = Vector2(970,120)
	elif page == 4:
		$TextureRect.texture = page_4
		$Next_Button.global_position = Vector2(926, 543)
	elif page == 5:
		$TextureRect.texture = page_5
	elif page == 6:
		$TextureRect.texture = page_6
		$Next_Button.global_position = Vector2(970, 500)
	elif page == 7:
		$TextureRect.texture = page_7
		$Back_Button.scale = Vector2(0.35, 0.35)
		$Back_Button.global_position = Vector2(35, -11)
		$Next_Button.global_position = Vector2(926, 543)
	elif page == 8:
		$TextureRect.texture = page_8
		$Back_Button.global_position = Vector2(0, -11)
		$Next_Button.global_position = Vector2(950, 20)
	elif page == 9:
		$Back_Button.global_position = Vector2(950, -11)
		$TextureRect.texture = page_9
		$Next_Button.hide()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Start_scene.tscn")


#CHANGE INSTRUCTIONS TO HAVE MORE, MAYBE MAKE A NEXT BUTTON UNTIL IT SHOWS LITERALLY EVERYTHING THAT IS NECESSARY.


func _on_next_button_pressed():
	page += 1
