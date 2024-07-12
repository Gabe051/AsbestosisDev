extends GroundItem

@onready var outline = $Model/Outline

# Called when the node enters the scene tree for the first time.
func _ready():
	ID = ItemEnum.ItemID.BATTERY
	item_name = "Ground_Battery"


