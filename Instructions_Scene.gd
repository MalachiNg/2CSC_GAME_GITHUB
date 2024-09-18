extends Node
@onready var page = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if page == 1:
		$Page_1.show() ; $Back_Button.show()
		$Page_2.hide() ; $Page_3.hide() ; $Page_4.hide()
		$Next_Button.position = Vector2(926,543)
	elif page == 2:
		$Page_2.show()
		$Page_1.hide() ; $Page_3.hide() ; $Page_4.hide()
		$Next_Button.position = Vector2(960,363)
	elif page == 3:
		$Page_3.show()
		$Page_1.hide() ; $Page_2.hide() ; $Page_4.hide()
		$Next_Button.position = Vector2(926,543)
	elif page == 4:
		$Page_4.show() ; $Back_Button.show()
		$Page_1.hide() ; $Page_2.hide() ; $Page_3.hide() ; $Next_Button.hide()
		$Back_Button.position = Vector2(960,000)



func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Start_scene.tscn")


#CHANGE INSTRUCTIONS TO HAVE MORE, MAYBE MAKE A NEXT BUTTON UNTIL IT SHOWS LITERALLY EVERYTHING THAT IS NECESSARY.


func _on_next_button_pressed():
	page += 1
