extends Button

@onready var slot_texture = $TextureRect
var slot_item
var slot_index


signal OnButtonClick(item, index)

func update_item(item):
	if item:
		self.slot_item = item
		slot_texture.set_texture(item.texture)
		
	else:
		self.slot_item = null
		slot_texture.set_texture(null)

func _on_area_2d_area_entered(area):
	pass # Replace with function body.

func _on_area_2d_area_exited(area):
	pass # Replace with function body.

func _on_button_down():
	emit_signal("OnButtonClick", slot_item, slot_index)
	pass
	
