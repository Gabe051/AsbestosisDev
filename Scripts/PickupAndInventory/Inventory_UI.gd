extends Control

@onready var inventory_screen = $"../.."
@onready var grid_container = $GridContainer
@onready var player_inventory = $"../../.."
@onready var mouse_drag_rect = $MouseDragRect

var item_held

func set_item_held(texture):
	mouse_drag_rect.texture = texture
	item_held = true
	mouse_drag_rect.show()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 12:
		var child = grid_container.get_child(i)
		child.index = i
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if item_held:
		mouse_drag_rect.position = get_global_mouse_position()
