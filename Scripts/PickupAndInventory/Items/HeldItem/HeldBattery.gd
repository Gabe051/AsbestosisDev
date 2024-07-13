extends HeldItem


# Called when the node enters the scene tree for the first time.
func _ready():
	ID = ItemEnum.ItemID.BATTERY
	item_name = "Held_Battery"

func use_item(target) -> bool:
	target.battery_power = 100.0
	return true
