extends TextureButton
func _on_stasis_button_down():
	rect_scale = Vector2(0.9,0.9)


func _on_stasis_button_up():
	rect_scale = Vector2(1,1)
