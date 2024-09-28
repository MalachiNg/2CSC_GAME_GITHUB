extends Node
@onready var page = 1
@onready var page_1 = preload("res://INSTRUCTIONS_page_1.png")
@onready var page_2 = preload("res://INSTRUCTIONS_page_2.png")
@onready var page_3 = preload("res://INSTRUCTIONS_page_3.png")
@onready var page_4 = preload("res://INSTRUCTIONS_page_4.png")
@onready var page_5 = preload("res://INSTRUCTIONS_page_5.png")
@onready var page_6 = preload("res://INSTRUCTIONS_page_6.png")

func _ready():
	$TextureRect.texture = preload("res://INSTRUCTIONS_page_1.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print(page)
	$TextureRect.show()
	$TextureRect.size = Vector2(1152, 648)
	if page == 1:
		$TextureRect.texture = page_1
	elif page == 2:
		$TextureRect.texture = page_2
		$Next_Button.global_position = Vector2(950,390)
	elif page == 3:
		$TextureRect.texture = page_3
		$Next_Button.global_position = Vector2(926,543)
	elif page == 4:
		$TextureRect.texture = page_4
	elif page == 5:
		$TextureRect.texture = page_5
		$Back_Button.scale = Vector2(0.35,0.35)
		$Back_Button.global_position = Vector2(35,-11)
	elif page == 6:
		$TextureRect.texture = page_6
		$Next_Button.hide()
		$Back_Button.scale = Vector2(0.35,0.35)
		$Back_Button.global_position = Vector2(970,-11)



func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Start_scene.tscn")


#CHANGE INSTRUCTIONS TO HAVE MORE, MAYBE MAKE A NEXT BUTTON UNTIL IT SHOWS LITERALLY EVERYTHING THAT IS NECESSARY.


func _on_next_button_pressed():
	page += 1
