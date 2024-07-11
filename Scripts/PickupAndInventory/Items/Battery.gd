class_name Battery

extends Item

var gui_texture = load("res://Assets/Textures/durexell.png")

#virtual functions
func hold_item():
	pass
	
func use_item():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	item_name = "battery"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
