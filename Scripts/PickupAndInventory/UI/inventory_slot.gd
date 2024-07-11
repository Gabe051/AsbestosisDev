extends Control

@onready var player_inventory = $"../../../../.."

@onready var inventory_ui = $"../.."
@onready var texture_rect = $InnerBorder/TextureRect




var index = -1

func update_texture(new_tex):
	texture_rect.set_texture(new_tex)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_button_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		player_inventory.clicked_item(event, self)


func _on_item_button_pressed():
	pass
	
	
func _on_item_button_mouse_entered():
	pass # Replace with function body.


func _on_item_button_mouse_exited():
	pass # Replace with function body.

