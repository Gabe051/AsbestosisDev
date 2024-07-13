class_name HUD

extends Control

@onready var player = $".."
@onready var battery_label = $BatteryLabel



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var label_text = "Battery Power: "
	label_text += str(round(player.battery_power))
	battery_label.set_text(label_text)
